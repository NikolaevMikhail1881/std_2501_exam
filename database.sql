-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_2501_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('4e10f83b4d05');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `desc` text NOT NULL,
  `year` int(11) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `volume` int(11) NOT NULL,
  `cover_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_cover_id_covers` (`cover_id`),
  CONSTRAINT `fk_books_cover_id_covers` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (8,'Капитанская дочка','Книга рассказывает о событиях Пугачевского восстания, их влиянии на судьбы главных героев Петра Гринева и Маши Мироновой. Это история любви, чести и долга, переплетенная с историческими событиями.',1836,'АСТ','Александр Сергеевич Пушкин',200,5),(20,'Алые паруса','Романтическая повесть о мечтах и надеждах, рассказывающая о девушке Ассоль, которая ждет своего суженого под алыми парусами. Книга символизирует веру в чудеса и силу мечты.',1923,'АСТ','Александр Грин',150,6),(22,'Герой нашего времени','Психологический роман, состоящий из пяти новелл, связанных образом главного героя Печорина. Это исследование его сложного внутреннего мира и характеристика типичного представителя \"лишних людей\" в русской литературе.',1840,'Русский Вестник','Михаил Юрьевич Лермонтов ',220,10),(23,'Горе от ума','Острая социальная комедия, критикующая общественные нравы и порядки. Главный герой Чацкий возвращается в Москву после долгого отсутствия и сталкивается с консервативными взглядами общества.',1825,'АСТ','Александр Сергеевич Грибоедов',150,11),(24,'Мастер и Маргарита','Один из самых известных русских романов ХХ века, переплетающий реальные и мистические сюжеты. Книга рассказывает о визите дьявола в Москву, истории любви Мастера и Маргариты, и повествует о событиях в древнем Иерусалиме.\r\n**проверка markdown**\r\n\r\n',1967,'Эксмодетство ','Михаил Афанасьевич Булгаков',500,12),(25,'Обломов','Роман о жизни Ильи Обломова, дворянина, погруженного в бездействие и апатию. Книга исследует тему \"обломовщины\" — символа лени и пассивности, критически изображая жизнь русской аристократии.',1859,'Эксмо','Иван Александрович Гончаров',550,13),(26,'Отцы и дети','Социально-психологический роман, изображающий конфликт поколений. Главный герой, нигилист Базаров, сталкивается с идеями и убеждениями старшего поколения, что приводит к трагическим последствиям.',1862,'Эксмо','Иван Сергеевич Тургенев',350,14),(27,'Полярный летчик','Прославленный летчик Герой Советского Союза М. В. Водопьянов рассказывает о том, как он, деревенский парнишка, стал летчиком, как в труднейших условиях открыл первуюна Дальнем Востоке воздушную линию на Сахалин, спасал челюскинцев, перевозил из Москвы матрицы газеты \"Правда\" в Ленинград и другие города, летал на Северный полюс, в годы Великой Отечественной войны водил тяжелые самолеты в дальние тылы фашистов.',1952,'Детская литература','Водопьянов Михаил Васильевич',320,15),(28,'Преступление и наказание','Психологический роман, исследующий тему преступления и возмездия. Главный герой, Родион Раскольников, совершает убийство и пытается оправдать его \"идеей\" о праве на преступление. Книга исследует его внутреннюю борьбу и путь к покаянию.',1866,'Русский Вестник','Фёдор Миха́йлович Достоевский',550,16),(29,'Ревизор','Острая сатирическая комедия, в которой Гоголь высмеивает бюрократическую систему России. Главный герой, Хлестаков, принимает себя за важного ревизора, что приводит к череде комических ситуаций и разоблачений.',1836,'Русский Вестник','Николай Васильевич Гоголь',150,8),(30,'Приключения Тома Сойера','Повесть о приключениях мальчика Тома Сойера, живущего на берегу Миссисипи. История наполнена юмором, приключениями и отражает жизнь американской глубинки XIX века.',1876,'Эксмо','Марк Твен',300,7),(31,'Волшебник Изумрудного города','Сказочная повесть, пересказ книги Л. Ф. Баума \"Удивительный волшебник из страны Оз\". История о девочке Элли и её друзьях, которые отправляются в волшебный Изумрудный город, чтобы встретиться с Великим Волшебником и исполнить свои заветные желания.',1939,'Детство','Александр Волков',200,17),(34,'Бастер ко мне ','Кто из ребят не мечтает о своей собаке или хотя бы кошке? А герою этой книги школьнику Клинту Барлоу несказанно повезло: у него завёлся тюленёнок. Нашёл он его совсем маленьким, всего нескольких дней от роду, выкормил, вырастил и не расставался с ним, несмотря на все отчаянные проказы, какие вытворял Бастер - так Клинт назвал своего тюленя..\r\n**жирный текст**\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n',1962,'Мелик Пашаев',' Бинз Арчи',176,18);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `covers`
--

DROP TABLE IF EXISTS `covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `md5_hash` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `covers`
--

LOCK TABLES `covers` WRITE;
/*!40000 ALTER TABLE `covers` DISABLE KEYS */;
INSERT INTO `covers` VALUES (5,'0070dea72729149aad1e735e29a2b787.jpeg','image/jpeg','0070dea72729149aad1e735e29a2b787'),(6,'65aa7b0c4c1fa7fc8683ea117e7832ca.jpeg','image/jpeg','65aa7b0c4c1fa7fc8683ea117e7832ca'),(7,'811747422b1e531a2b19e42d46e5a661.jpeg','image/jpeg','811747422b1e531a2b19e42d46e5a661'),(8,'812dd49ce799ea49ef987da8cb07abd5.jpeg','image/jpeg','812dd49ce799ea49ef987da8cb07abd5'),(10,'ca8a5d41b65bcdd81af5c598de1d73a1.jpeg','image/jpeg','ca8a5d41b65bcdd81af5c598de1d73a1'),(11,'54aad7aad6ef960cbeea0983cb029b6c.jpeg','image/jpeg','54aad7aad6ef960cbeea0983cb029b6c'),(12,'004201d1e611ab0898f6d772f68a1373.jpeg','image/jpeg','004201d1e611ab0898f6d772f68a1373'),(13,'a02b1249b76bcc8005b419881b44ce46.jpeg','image/jpeg','a02b1249b76bcc8005b419881b44ce46'),(14,'35a41f13f3c5ebadbf21f22ce819e505.jpeg','image/jpeg','35a41f13f3c5ebadbf21f22ce819e505'),(15,'1546511e02e6a08a9a3b52f2fe07df40.jpeg','image/jpeg','1546511e02e6a08a9a3b52f2fe07df40'),(16,'5f8fdc6d646601a250f4fd20ff9064bf.jpeg','image/jpeg','5f8fdc6d646601a250f4fd20ff9064bf'),(17,'e499216c32e868a601c8b492765115d4.jpeg','image/jpeg','e499216c32e868a601c8b492765115d4'),(18,'efc5544fc7fdc65aa43bb4b87c511178.jpeg','image/jpeg','efc5544fc7fdc65aa43bb4b87c511178');
/*!40000 ALTER TABLE `covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre_to_book`
--

DROP TABLE IF EXISTS `genre_to_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre_to_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_genre_to_book_book_id_books` (`book_id`),
  KEY `fk_genre_to_book_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_genre_to_book_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_genre_to_book_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre_to_book`
--

LOCK TABLES `genre_to_book` WRITE;
/*!40000 ALTER TABLE `genre_to_book` DISABLE KEYS */;
INSERT INTO `genre_to_book` VALUES (14,8,11),(28,22,9),(29,23,13),(31,25,9),(32,26,9),(33,27,1),(34,28,9),(35,29,4),(36,30,15),(37,31,16),(51,20,12),(121,24,9),(122,34,1),(123,34,16);
/*!40000 ALTER TABLE `genre_to_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (8,'Баллада'),(10,'Басня'),(3,'Драма'),(11,'Историческая повесть'),(4,'Комедия'),(13,'Комедия в стихах'),(14,'Магический реализм'),(6,'Ода'),(2,'Очерк'),(15,'Приключенческая повесть'),(7,'Пьеса'),(1,'Рассказ'),(9,'Роман'),(12,'Романтическая сказка'),(16,'Сказка'),(5,'Трагедия');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_book_id_books` (`book_id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  CONSTRAINT `fk_reviews_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (26,24,3,5,'Книга супер!!!\r\n**Проверка markdown**','2024-06-15 16:00:08'),(27,24,2,3,'**Проверяю среднюю оценку**','2024-06-15 16:01:24'),(28,24,1,1,'Пользователь оставляет только по одному отзыву','2024-06-15 16:02:23');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_roles_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению книг'),(2,'Moderator','может редактировать данные книг и производить модерацию рецензий'),(3,'User','может оставлять рецензии');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(256) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user','scrypt:32768:8:1$bU6hfkFJSfaysP0y$908945dbbffb8a62af1d88675b9cafc590a895f73c239c80b0a19c36f0c7079ed3b8cca13d300f76b532714d2957d8ad68382b3dd060f72cc30a255884f38616','Михаил','Николаев',NULL,3),(2,'moderator','scrypt:32768:8:1$OpI8EAlHjEHa7rmJ$0e78c85a502d999e0b3c908f274b31611b0108aa81a2624c4fad921d299ce977dad2ae1a7b3aa8d5d67536f20602a9d97916df3a02236b89d8e5c67a1edeb5eb','Михаил','Николаев',NULL,2),(3,'admin','scrypt:32768:8:1$knodbavcrfJdcm1j$ad7b1fccb0b642df462e14aab48a4a99b0613e7845a41224d7c6e0f95f965468628c0ca11305e135d4b5ad63fdac007f2a33403f88ddc4b5cc6474c223c2a29c','Михаил','Николаев',NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-15 16:42:37
