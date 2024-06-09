from typing import Optional  
from datetime import datetime
from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.orm import Mapped, mapped_column  
from sqlalchemy import String, ForeignKey, Text, Integer, MetaData  

ADMIN_ROLE_ID = 1           #константы роллей id
MODERATOR_ROLE_ID = 2
USER_ROLE_ID = 3


class Base(DeclarativeBase):    #шаблон для именования constraint(ограничение)
    metadata = MetaData(
        naming_convention={
            "ix": "ix_%(column_0_label)s",
            "uq": "uq_%(table_name)s_%(column_0_name)s",
            "ck": "ck_%(table_name)s_%(constraint_name)s",
            "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
            "pk": "pk_%(table_name)s",
        }
    )


db = SQLAlchemy(model_class=Base) #создаем экземпляр класса SQLAlchemy


class Book(Base): #таблица книг
    __tablename__ = "books"

    id = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(255))
    desc: Mapped[str] = mapped_column(Text)
    year: Mapped[int] = mapped_column(Integer)
    publisher: Mapped[str] = mapped_column(String(255))
    author: Mapped[str] = mapped_column(String(255))
    volume: Mapped[int] = mapped_column(Integer)
    cover_id: Mapped[int] = mapped_column(ForeignKey("covers.id", ondelete="RESTRICT"))

    def __repr__(self):
        return "<Book %r>" % self.name


class Genre(Base):
    __tablename__ = "genres"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(100), unique=True)

    def __repr__(self):
        return "<Genre %r>" % self.name


class GenreToBook(Base):
    __tablename__ = "genre_to_book"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    book_id: Mapped[int] = mapped_column(ForeignKey("books.id", ondelete="CASCADE"))
    genre_id: Mapped[int] = mapped_column(ForeignKey("genres.id"))




class Cover(Base):
    __tablename__ = "covers"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    filename: Mapped[str] = mapped_column(String(255))
    mime_type: Mapped[str] = mapped_column(String(100))
    md5_hash: Mapped[str] = mapped_column(String(256))

    def __repr__(self):
        return "<Covers %r>" % self.filename


class Review(Base):
    __tablename__ = "reviews"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    book_id: Mapped[int] = mapped_column(ForeignKey("books.id", ondelete="CASCADE"))
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"))
    rating: Mapped[int] = mapped_column(Integer)
    text: Mapped[str] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(default=datetime.now)

    def __repr__(self):
        return "<Review %r>" % self.text


class User(Base, UserMixin):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True)
    login: Mapped[str] = mapped_column(String(100), unique=True)
    password_hash: Mapped[str] = mapped_column(String(256))
    first_name: Mapped[str] = mapped_column(String(100))
    last_name: Mapped[str] = mapped_column(String(100))
    middle_name: Mapped[Optional[str]] = mapped_column(String(100))
    role_id: Mapped[int] = mapped_column(ForeignKey("roles.id"))

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def is_admin(self):
        return self.role_id == ADMIN_ROLE_ID

    def can(self, action):
        match action:
            case "createBook" | "deleteBook":
                return self.role_id == ADMIN_ROLE_ID
            case "editBook":
                if self.role_id == ADMIN_ROLE_ID or self.role_id == MODERATOR_ROLE_ID:
                    return True
            case "makeReview" | "showBook":
                return True
        return False

    @property
    def full_name(self):
        return " ".join([self.last_name, self.first_name, self.middle_name or ""])

    def __repr__(self):
        return "<User %r>" % self.login


class Role(Base):
    __tablename__ = "roles"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(100), unique=True)
    desc: Mapped[str] = mapped_column(Text)

    def __repr__(self):
        return "<Role %r>" % self.name

