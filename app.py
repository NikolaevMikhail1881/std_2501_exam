from flask import Flask, render_template, request, redirect, url_for, flash, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, current_user, login_user, logout_user, login_required
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import os
import hashlib
import hmac
from flask_migrate import Migrate
from models import Book, User, Review, db, Genre, Cover, GenreToBook, Role
from auth import bp as auth_bp, init_login_manager
from flask_paginate import Pagination, get_page_parameter
from sqlalchemy.orm import aliased
from sqlalchemy import desc, func
from bleach import clean
from markdown2 import markdown

app = Flask(__name__)
app.config.from_pyfile("config.py")
application = app
app.register_blueprint(auth_bp)
db.init_app(app)
migrate = Migrate(app, db)
init_login_manager(app)


@app.route('/', methods=['GET'])
def index():
    page = request.args.get(get_page_parameter(), type=int, default=1)
    books = (
        db.session.query(
            Book.id.label("books_id"),
            Book.name.label("name"),
            Book.desc.label("books_desc"),
            Book.year.label("year"),
            Book.publisher.label("books_publisher"),
            Book.author.label("books_author"),
            Book.volume.label("books_volume"),
            Book.cover_id.label("books_cover_id"),
            Cover.filename.label("covers_filename"),
            func.group_concat(Genre.name.distinct()).label("genres"),
            func.avg(Review.rating).label("average_rating"),
            func.count(Review.id).label("review_count")
        )
        .outerjoin(GenreToBook, Book.id == GenreToBook.book_id)
        .outerjoin(Genre, Genre.id == GenreToBook.genre_id)
        .outerjoin(Review, Book.id == Review.book_id)
        .outerjoin(Cover, Cover.id == Book.cover_id)
        .group_by(Book.id, Cover.filename)
        .order_by(desc(Book.year))
    )
    paginated_books = books.paginate(page=page, per_page=4)
    
    return render_template('index.html', books=paginated_books, role=role_name())


@app.route('/books/<int:book_id>', methods=['GET'])
@login_required
def book_detail(book_id):
    book = Book.query.get_or_404(book_id)
    reviews = Review.query.filter_by(book_id=book_id).all()
    has_reviewed = Review.query.filter_by(
        book_id=book_id, user_id=current_user.id).first() is not None
    return render_template('book.html', book=book, reviews=reviews, has_reviewed=has_reviewed)


@app.route("/media/images/<path:filename>")
def image_path(filename):
    return send_from_directory(
        os.path.join(os.path.dirname(
            os.path.abspath(__file__)), "media", "images"),
        filename,
    )


@app.route('/books/add', methods=['GET', 'POST'])
@login_required
def add_book():
    if request.method == 'POST':
        name = request.form['name']
        author = request.form['author']
        publisher = request.form['publisher']
        volume = request.form['volume']
        desc = clean(request.form['desc'])
        genres = request.form.getlist('genres_id')
        year = request.form['year']

        file = request.files['book_cover']

        file.seek(0)  # Убедиться, что указатель файла в начале
        md5_hash = hashlib.md5(file.read()).hexdigest()

# Сформировать имя файла с расширением
        file_extension = file.mimetype.split('/')[-1]
        file_name = f"{md5_hash}.{file_extension}"

# Сформировать полный путь для сохранения файла
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], file_name)
        mime_type = file.mimetype

        new_book = Book(name=name, author=author, publisher=publisher,
                        volume=volume, desc=desc, year=year)
        cover=Cover()
        try:
            try:
                cover = db.session.query(Cover).filter_by(md5_hash=md5_hash).one()
            except Exception:
                pass

            if not cover.id:
                cover = Cover(md5_hash=md5_hash,
                              mime_type=mime_type, filename=file_name)
                if not (mime_type == 'image/jpeg') and not (mime_type == 'image/png'):
                    flash('Неверное расширение обложки', 'danger')
                    return render_template('books/create.html',  new_book=new_book, genres=genres, role=role_name())

                db.session.add(cover)
                db.session.commit()
                # Сохранить файл
                # Вернуть указатель файла в начало перед сохранением
                file.seek(0)
                file.save(file_path)
                cover = db.session.query(Cover).filter_by(
                    md5_hash=md5_hash).first()
        except Exception:
            db.session.rollback()
            flash('Произошла ошибка при сохранении обложки {}'.format(
                Exception), 'danger')
            return render_template('books/create.html',new_book=new_book, genres=genres, role=role_name())
            


        new_book.cover_id = cover.id
        db.session.add(new_book)
        db.session.commit()

        all_form_genres = request.form.getlist('genres_id')

        for genre_id in all_form_genres:
            genre_to_book = GenreToBook(genre_id=genre_id, book_id=new_book.id)
            db.session.add(genre_to_book)
            db.session.commit()

        db.session.commit()
        flash('Книга успешно добавлена!', 'success')
        return redirect(url_for('index'))

    genres = db.session.query(Genre).all()
    return render_template('books/create.html', genres=genres, role=role_name())



def role_name():
    role = None
    if current_user.is_authenticated:
        role = (
            db.session.query(
               Role.name.label("role_name")
           )
           .join(User, User.role_id == Role.id)
           .filter(User.id == current_user.id)
           .first()
       )

    return role.role_name if role else None
        
@app.route('/books/show_book/<int:book_id>')
def show_book(book_id):
    
    book = db.session.query(
        Book.id.label('id'),
        Book.name.label('name'),
        Book.year.label('year'),
        Book.desc.label('description'),
        Book.publisher.label('publisher'),
        Book.author.label('author'),
        Book.volume.label('volume'),
        func.coalesce(func.avg(Review.rating), 0).label('average_rating'),
        func.group_concat(Genre.name).label('genres'),
        Cover.filename.label('cover_filename')
    ).outerjoin(
        GenreToBook, GenreToBook.book_id == Book.id
    ).outerjoin(
        Genre, Genre.id == GenreToBook.genre_id
    ).outerjoin(
        Review, Review.book_id == Book.id
    ).outerjoin(
        Cover, Cover.id == Book.cover_id
    ).filter(
        Book.id == book_id
    ).group_by(
        Book.id, Cover.filename
    ).first()
    book=book._asdict()
    book["description"]=(markdown(book["description"]))
   

    reviews = db.session.query(
        Review.id.label('review_id'),
        Review.book_id.label('book_id'),
        Review.user_id.label('user_id'),
        Review.rating.label('rating'),
        Review.text.label('text'),
        Review.created_at.label('created_at'),
        User.first_name.label('first_name'),
        User.last_name.label('last_name'),
        User.middle_name.label('middle_name'),
        func.count(GenreToBook.genre_id).label('genre_count')
        ).join(User, Review.user_id == User.id
        ).join(GenreToBook, GenreToBook.book_id == Review.book_id
        ).filter(Review.book_id == book_id
        ).group_by(Review.id
        ).order_by(Review.created_at.desc()
        ).all()

    reviews_list = []
    reviews_count = db.session.query(func.count(Review.id)).filter(Review.book_id == book_id).scalar()
    for review in reviews:
        review = review._asdict()    
        review["text"] = (markdown(review["text"]))
        reviews_list.append(review)
        
    

    return render_template('books/show_book.html', book=book, current_user=current_user, reviews_count=reviews_count, reviews_list=reviews_list)

@app.route('/books/edit/<int:book_id>', methods=['GET', 'POST'])
@login_required
def edit_book(book_id):
    book = db.session.query(Book).get(book_id)

    if book is None:
        flash('Книга не найдена', 'danger')
        return redirect(url_for('index'))

    if request.method == 'POST':
        book.name = request.form.get('name')
        book.author = request.form.get('author')
        book.publisher = request.form.get('publisher')
        book.volume = request.form.get('volume')
        book.desc = request.form.get('desc')
        book.year = request.form.get('year')

        genres_id = request.form.getlist('genres_id')
        db.session.query(GenreToBook).filter(GenreToBook.book_id == book_id).delete()
        for genre_id in genres_id:
            genre = db.session.query(Genre).get(genre_id)
            if genre is None:
                flash('Жанр не найден', 'danger')
                return redirect(url_for('edit_book', book_id=book_id))
            genre_to_book = GenreToBook(book_id=book.id, genre_id=genre_id)
            db.session.add(genre_to_book)

        db.session.commit()
        flash('Книга успешно обновлена!', 'success')
        return redirect(url_for('show_book', book_id=book_id))

    genres = db.session.query(Genre).all()
    book_genres = db.session.query(Genre).join(GenreToBook, Genre.id == GenreToBook.genre_id).filter(GenreToBook.book_id == book.id).all()
    book_genre_ids = [genre.id for genre in book_genres]

    return render_template('books/edit.html',
                           book=book,
                           genres=genres,
                           book_genre_ids=book_genre_ids)

@app.route('/books/delete/<int:book_id>', methods=['POST'])
@login_required
def delete_book(book_id):
    book = db.session.query(Book).filter_by(id=book_id).first()
    
    if book is None:
        flash('Книга не найдена', 'danger')
        return redirect(url_for('index'))

    if not current_user.can("deleteBook"):
        flash('У вас нет прав на удаление этой книги', 'danger')
        return redirect(url_for('index'))
    

    # Удаление самой книги
    db.session.delete(book)
    db.session.commit()

    cover_path = None
    if book.cover_id:
        cover = db.session.query(Cover).filter_by(id=book.cover_id).first()
        if cover:
            try: 
                cover_path = os.path.join(app.config['UPLOAD_FOLDER'], cover.filename)
                db.session.delete(cover)
                db.session.commit()
                os.remove(cover_path)
            except Exception:
                pass
            




    flash('Книга успешно удалена!', 'success')
    return redirect(url_for('index'))



@app.route('/books/add_review/<int:book_id>', methods=['POST'])
@login_required
def add_review(book_id):
    existing_review = db.session.execute(
        db.select(Review).where(Review.book_id == book_id, Review.user_id == current_user.id)
    ).scalar()

    if existing_review:
        flash('Вы уже оставили отзыв на этот курс.', 'warning')
        return redirect(url_for('show_book', book_id=book_id))

    review=Review(
        user_id=current_user.id,
        rating=request.form.get('rating'),
        text=request.form.get('text'),
        book_id=book_id
    )

    db.session.add(review)
    db.session.commit()

    return redirect(url_for('show_book', book_id=book_id))




