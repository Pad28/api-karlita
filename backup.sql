-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: law_tech
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbabogado`
--

DROP TABLE IF EXISTS `tbabogado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbabogado` (
  `idAbogado` int(11) NOT NULL AUTO_INCREMENT,
  `idRol` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `ApellidoPaterno` varchar(255) NOT NULL,
  `ApellidoMaterno` varchar(255) DEFAULT NULL,
  `Cedula` varchar(50) NOT NULL,
  `Especialidad` varchar(50) NOT NULL,
  `Telefono` varchar(10) NOT NULL,
  `Correo` varchar(255) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`idAbogado`),
  KEY `tbRol_idRol_tbAbogado` (`idRol`),
  CONSTRAINT `tbRol_idRol_tbAbogado` FOREIGN KEY (`idRol`) REFERENCES `tbrol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbabogado`
--

LOCK TABLES `tbabogado` WRITE;
/*!40000 ALTER TABLE `tbabogado` DISABLE KEYS */;
INSERT INTO `tbabogado` VALUES
(5,1,'Nancy','Fernandez','Moreno','adsfghf','Derecho mercantil','465123564','nancy@gogle.com','56789','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','asdfds'),
(6,1,'lili','fer','','agshdsfadsfh','Derecho mercantil','8451265489','tenorio@papas.com','101010','awesrdgfds','aestryjukjggdsf'),
(7,1,'Jovanny','Soto','Loma','47895425','Derecho fiscal','7589461238','jovanny@mazatlan.com','98765432','Acahuales, Pahuatlan, Puebla','Es el mas chingon manejando casos de empresas patitos....');
/*!40000 ALTER TABLE `tbabogado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbadmin`
--

DROP TABLE IF EXISTS `tbadmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbadmin` (
  `idadmi` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `ApellidoPaterno` varchar(30) NOT NULL,
  `ApellidoMaterno` varchar(30) NOT NULL,
  `Clave` varchar(10) NOT NULL,
  `Correo` varchar(50) NOT NULL,
  `Contrasena` varchar(15) NOT NULL,
  `idRol` int(11) NOT NULL,
  PRIMARY KEY (`idadmi`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbadmin`
--

LOCK TABLES `tbadmin` WRITE;
/*!40000 ALTER TABLE `tbadmin` DISABLE KEYS */;
INSERT INTO `tbadmin` VALUES
(5,'car','dan','lopez','OhFTNg4#5Q','moto@coqa.com','99999',3);
/*!40000 ALTER TABLE `tbadmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcalificacion`
--

DROP TABLE IF EXISTS `tbcalificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbcalificacion` (
  `idCalificacion` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(15) NOT NULL,
  PRIMARY KEY (`idCalificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcalificacion`
--

LOCK TABLES `tbcalificacion` WRITE;
/*!40000 ALTER TABLE `tbcalificacion` DISABLE KEYS */;
INSERT INTO `tbcalificacion` VALUES
(1,'No recomendable'),
(2,'Puede Mejorar'),
(3,'Regular'),
(4,'Bueno'),
(5,'Excelente');
/*!40000 ALTER TABLE `tbcalificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcita`
--

DROP TABLE IF EXISTS `tbcita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbcita` (
  `idCita` int(11) NOT NULL AUTO_INCREMENT,
  `FechaCreacion` date NOT NULL,
  `FechaReservacion` date NOT NULL,
  `HoraCita` time NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  `idCiudadano` int(11) NOT NULL,
  `idAbogado` int(11) NOT NULL,
  `idStatus` int(11) NOT NULL,
  PRIMARY KEY (`idCita`),
  KEY `tbCiudadano_idUsuario_tbCita` (`idCiudadano`),
  KEY `tbStatus_idStatus_tbCita` (`idStatus`),
  KEY `fk_abogado_cita` (`idAbogado`),
  CONSTRAINT `fk_abogado_cita` FOREIGN KEY (`idAbogado`) REFERENCES `tbabogado` (`idAbogado`),
  CONSTRAINT `tbCiudadano_idUsuario_tbCita` FOREIGN KEY (`idCiudadano`) REFERENCES `tbciudadano` (`idCiudadano`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tbStatus_idStatus_tbCita` FOREIGN KEY (`idStatus`) REFERENCES `tbstatus` (`idStatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tbabogado_idAbogado_tbCita` FOREIGN KEY (`idAbogado`) REFERENCES `tbabogado` (`idAbogado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcita`
--

LOCK TABLES `tbcita` WRITE;
/*!40000 ALTER TABLE `tbcita` DISABLE KEYS */;
INSERT INTO `tbcita` VALUES
(4,'2024-04-07','2024-04-08','09:00:00','Calle Principal #123','Consulta legal',5,6,2),
(7,'2024-04-07','2024-04-16','16:29:00','asdfghfds','saludos',5,5,2),
(8,'2024-04-07','2024-04-10','15:38:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(11,'2024-04-08','2024-04-22','14:33:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(12,'2024-04-08','2024-04-17','17:32:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(13,'2024-04-08','2024-04-17','10:54:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(14,'2024-04-08','2024-04-23','14:31:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(15,'2024-04-08','2024-04-23','14:38:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(17,'2024-04-08','2024-04-23','15:40:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(18,'2024-04-08','2024-04-17','17:41:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(19,'2024-04-08','2024-04-25','18:41:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(20,'2024-04-08','2024-04-25','18:41:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(21,'2024-04-08','2024-04-24','15:08:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(22,'2024-04-08','2024-04-23','15:09:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(23,'2024-04-08','2024-04-17','15:08:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(24,'2024-04-08','2024-04-23','15:10:00','Luis Donaldo Colosio Santiago Tulantepec Hidalgo','saludos',5,5,2),
(25,'2024-04-08','2024-04-23','18:11:00','awesrdgfds','saludos',5,6,2),
(26,'2024-04-08','2024-04-29','15:23:00','awesrdgfds','saludos',5,6,2),
(27,'2024-04-08','2024-04-24','16:23:00','awesrdgfds','saludos',5,6,2),
(29,'2024-04-10','2024-04-16','15:38:00','21 de marzo, Centro, Tulancingo, Hidalgo','Continuidad',8,6,2);
/*!40000 ALTER TABLE `tbcita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbciudadano`
--

DROP TABLE IF EXISTS `tbciudadano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbciudadano` (
  `idCiudadano` int(11) NOT NULL AUTO_INCREMENT,
  `idRol` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `ApellidoPaterno` varchar(40) NOT NULL,
  `ApellidoMaterno` varchar(40) DEFAULT NULL,
  `Telefono` varchar(10) NOT NULL,
  `Correo` varchar(50) NOT NULL,
  `Contrasena` varchar(20) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  PRIMARY KEY (`idCiudadano`),
  KEY `idRol_tbrol_tbciudadano` (`idRol`),
  CONSTRAINT `idRol_tbrol_tbciudadano` FOREIGN KEY (`idRol`) REFERENCES `tbrol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbciudadano`
--

LOCK TABLES `tbciudadano` WRITE;
/*!40000 ALTER TABLE `tbciudadano` DISABLE KEYS */;
INSERT INTO `tbciudadano` VALUES
(5,2,'nancy','fer','more','7751549835','nancy@gmail.com','12345','ashfdjhgdfsd'),
(6,2,'pao','lop','bafa','846513256','pao@coca.com','555555','asdfgfghtgsfd'),
(7,2,'antonia','cano','zendra','555695623','casadelili@lejos.com','888888','sgdfgdsfafgh'),
(8,2,'pancha','lata','coca','1561212345','lili03tenorio@gmail.com','123456789','adgshghjgrf'),
(9,2,'sars','kajdf','asdfa','846513284','norma19871fernandez@gmail.com','1234567','asdfghhfds'),
(10,2,'Uriel','Escobar','','4578963258','urielito@reprobados.com','123456','Calle Ingenierias, #100, Col Hupalcalco'),
(11,2,'Zeus','Sanchez','Soto','1245789653','nadie@vive.com','78910','{$Direccion}'),
(12,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(13,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(14,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(15,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(16,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(17,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(18,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(19,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(20,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(21,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(22,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(23,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(24,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(25,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(26,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(27,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(28,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(29,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(30,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(31,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(32,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(33,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(34,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(35,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(36,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(37,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(38,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(39,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(40,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(41,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(42,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(43,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(44,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(45,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(46,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(47,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(48,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(49,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(50,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(51,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(52,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(53,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(54,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(55,2,'Karla','LH','LH','7641003007','lopez.hernandez.karla1104@gmail.com','Eka123','ksksks'),
(56,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(57,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(58,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(59,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(60,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(61,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(62,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(63,2,'Karla','lH','jsjs','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(64,2,'Karla','lH','','7641002007','lopez.hernandez.karla1104@gmail.com','Elo04','ksksjs'),
(65,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(66,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(67,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(68,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(69,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(70,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(71,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(72,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(73,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(74,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(75,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(76,2,'Karla','lH','','7641002007','2134532@upt.edu.mx','Elo04','ksksjs'),
(77,2,'Karla ','Lop','','7641002007','2134532@upt.edu.mx','Elo04','jsjs'),
(78,2,'Karla ','Lop','','7641002007','2134532@upt.edu.mx','Elo04','jsjs'),
(79,2,'Karla ','Lop','','7641002007','2134532@upt.edu.mx','Elo04','jsjs'),
(80,2,'Karla','l','','7641002007','2134532@upt.edu.mx','Elo78','kks'),
(81,2,'Karla','l','','7641002007','2134532@upt.edu.mx','Elo78','kks'),
(82,2,'Karla','l','','7641002007','2134532@upt.edu.mx','Elo78','kks'),
(83,2,'Karla','l','','7641002007','2134532@upt.edu.mx','Elo78','kks'),
(84,2,'Karla','l','','7641002007','2134532@upt.edu.mx','Elo78','kks'),
(85,2,'Karla','Lopez','k','7641002007','2134532@upt.edu.mx','Elo04','kskd'),
(86,2,'Karla','Lopez','k','7641002007','2134532@upt.edu.mx','Elo04','kskd'),
(87,2,'Karla','Lopez','k','7641002007','2134532@upt.edu.mx','Elo04','kskd');
/*!40000 ALTER TABLE `tbciudadano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcomentario`
--

DROP TABLE IF EXISTS `tbcomentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbcomentario` (
  `idComentario` int(11) NOT NULL AUTO_INCREMENT,
  `idCiudadano` int(11) NOT NULL,
  `idAbogado` int(11) NOT NULL,
  `Comentario` varchar(200) NOT NULL,
  `idCalificacion` int(10) NOT NULL,
  PRIMARY KEY (`idComentario`),
  KEY `tbCiudadano_idUsuario_tbComentario` (`idCiudadano`),
  KEY `tbabogado_idAbogado_tbComentario` (`idAbogado`),
  KEY `tbCalificacion_idCalificacion_tbComentario` (`idCalificacion`),
  CONSTRAINT `tbCalificacion_idCalificacion_tbComentario` FOREIGN KEY (`idCalificacion`) REFERENCES `tbcalificacion` (`idCalificacion`),
  CONSTRAINT `tbCiudadano_idUsuario_tbComentario` FOREIGN KEY (`idCiudadano`) REFERENCES `tbciudadano` (`idCiudadano`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tbabogado_idAbogado_tbComentario` FOREIGN KEY (`idAbogado`) REFERENCES `tbabogado` (`idAbogado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcomentario`
--

LOCK TABLES `tbcomentario` WRITE;
/*!40000 ALTER TABLE `tbcomentario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbcomentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbpago`
--

DROP TABLE IF EXISTS `tbpago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbpago` (
  `idPago` int(11) NOT NULL AUTO_INCREMENT,
  `idAbogado` int(11) NOT NULL,
  `Suscripcion` varchar(20) NOT NULL,
  `Pago` varchar(15) NOT NULL,
  `FechaCorte` date NOT NULL,
  `FechaPago` date NOT NULL,
  `idStatus` int(11) NOT NULL,
  PRIMARY KEY (`idPago`),
  KEY `tbAbogado_idAbogado_tbPago` (`idAbogado`),
  KEY `tbStatus_idStatus_tbPago` (`idStatus`),
  CONSTRAINT `tbAbogado_idAbogado_tbPago` FOREIGN KEY (`idAbogado`) REFERENCES `tbabogado` (`idAbogado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tbStatus_idStatus_tbPago` FOREIGN KEY (`idStatus`) REFERENCES `tbstatus` (`idStatus`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpago`
--

LOCK TABLES `tbpago` WRITE;
/*!40000 ALTER TABLE `tbpago` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbpago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbrol`
--

DROP TABLE IF EXISTS `tbrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbrol` (
  `idRol` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(15) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbrol`
--

LOCK TABLES `tbrol` WRITE;
/*!40000 ALTER TABLE `tbrol` DISABLE KEYS */;
INSERT INTO `tbrol` VALUES
(1,'Abogado'),
(2,'Ciudadano'),
(3,'Admi');
/*!40000 ALTER TABLE `tbrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbstatus`
--

DROP TABLE IF EXISTS `tbstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbstatus` (
  `idStatus` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(15) NOT NULL,
  PRIMARY KEY (`idStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbstatus`
--

LOCK TABLES `tbstatus` WRITE;
/*!40000 ALTER TABLE `tbstatus` DISABLE KEYS */;
INSERT INTO `tbstatus` VALUES
(1,'Aceptada'),
(2,'Pendiente'),
(3,'Cancelada'),
(4,'Activo'),
(5,'En pausa'),
(6,'Inactiva');
/*!40000 ALTER TABLE `tbstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UsuarioTipo` enum('ciudadano','abogado','admin') NOT NULL,
  `Correo` varchar(255) NOT NULL,
  `Token` varchar(255) NOT NULL,
  `FechaCreacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `Expiracion` timestamp NOT NULL DEFAULT (current_timestamp() + interval 1 hour),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Token` (`Token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-12 23:18:10
