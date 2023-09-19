-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pizzeria
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `productos_idproductos` int(11) NOT NULL,
  PRIMARY KEY (`idcategoria`,`productos_idproductos`),
  KEY `fk_categoria_productos1_idx` (`productos_idproductos`),
  CONSTRAINT `fk_categoria_productos1` FOREIGN KEY (`productos_idproductos`) REFERENCES `productos` (`idproductos`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'mediana',5),(2,'infantil',6),(3,'premium',7),(4,'premium',8),(5,'premium',9),(6,'mediana',10);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `idclient` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `codigo_postal` int(8) NOT NULL,
  `localidad` varchar(45) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `telefono` int(15) NOT NULL,
  PRIMARY KEY (`idclient`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Pablo','Motos','Torpedo 23',8256,'Barcelona','Barcelona',652982555),(2,'Kevin','Cosner','Costelao 7',8512,'Barcelona','Barcelona',666333222),(3,'Ainoha','Barrios','Mayor 4',8621,'Sant Vicenç dels Horts','Barcelona',612325874),(4,'Juan','De Austria','Pispireta 8',8621,'Sant Vicenç dels Horts','Barcelona',644859632),(5,'Imanol ','Arias','Quevedo 33',8562,'Agramunt','Lleida',602145862),(6,'Arancha','Sanchez','De la Victoria',541256,'Agramunt','Lleida',612589745),(7,'Brad ','Pitt','Bacardi',8902,'Barcelona','Barcelona',625145222),(8,'Julia','Roberts','Olivera 65',8903,'Barcelona','Barcelona',666520001);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comanda`
--

DROP TABLE IF EXISTS `comanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comanda` (
  `idcomanda` int(11) NOT NULL AUTO_INCREMENT,
  `inici_comanda` datetime(6) NOT NULL,
  `tipo` enum('domicilio','tienda') NOT NULL,
  `numero_productos` int(11) NOT NULL,
  `precio_total` int(11) NOT NULL,
  `client_idclient` int(11) NOT NULL,
  `tienda_idtienda` int(11) NOT NULL,
  PRIMARY KEY (`idcomanda`,`client_idclient`,`tienda_idtienda`),
  KEY `fk_comanda_client_idx` (`client_idclient`),
  KEY `fk_comanda_tienda1_idx` (`tienda_idtienda`),
  CONSTRAINT `fk_comanda_client` FOREIGN KEY (`client_idclient`) REFERENCES `client` (`idclient`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_tienda1` FOREIGN KEY (`tienda_idtienda`) REFERENCES `tienda` (`idtienda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comanda`
--

LOCK TABLES `comanda` WRITE;
/*!40000 ALTER TABLE `comanda` DISABLE KEYS */;
INSERT INTO `comanda` VALUES (1,'2023-06-12 14:00:00.000000','tienda',3,15,1,1),(2,'2023-08-07 20:00:00.000000','domicilio',2,6,4,3),(3,'2023-10-12 21:00:00.000000','domicilio',10,25,8,5);
/*!40000 ALTER TABLE `comanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comanda_has_productos`
--

DROP TABLE IF EXISTS `comanda_has_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comanda_has_productos` (
  `comanda_idcomanda` int(11) NOT NULL,
  `productos_idproductos` int(11) NOT NULL,
  PRIMARY KEY (`comanda_idcomanda`,`productos_idproductos`),
  KEY `fk_comanda_has_productos_productos1_idx` (`productos_idproductos`),
  KEY `fk_comanda_has_productos_comanda1_idx` (`comanda_idcomanda`),
  CONSTRAINT `fk_comanda_has_productos_comanda1` FOREIGN KEY (`comanda_idcomanda`) REFERENCES `comanda` (`idcomanda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_has_productos_productos1` FOREIGN KEY (`productos_idproductos`) REFERENCES `productos` (`idproductos`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comanda_has_productos`
--

LOCK TABLES `comanda_has_productos` WRITE;
/*!40000 ALTER TABLE `comanda_has_productos` DISABLE KEYS */;
INSERT INTO `comanda_has_productos` VALUES (1,1),(1,5),(1,8),(2,2),(2,4),(3,2);
/*!40000 ALTER TABLE `comanda_has_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `idempleados` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `nif` varchar(9) NOT NULL,
  `telefono` int(11) NOT NULL,
  `puesto` enum('cocinero','reparto') NOT NULL,
  `tienda_idtienda` int(11) NOT NULL,
  PRIMARY KEY (`idempleados`,`tienda_idtienda`),
  KEY `fk_empleados_tienda1_idx` (`tienda_idtienda`),
  CONSTRAINT `fk_empleados_tienda1` FOREIGN KEY (`tienda_idtienda`) REFERENCES `tienda` (`idtienda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Xavi','Garcia','20459632P',669357421,'cocinero',1),(2,'Marta','Perez','35269875S',603254187,'reparto',1),(3,'Manolo','Tapias','20159357P',669587412,'cocinero',5),(4,'Jonathan','Fernandez','98563219L',648951221,'reparto',2),(5,'Alfredo ','Flores','77588659R',621555483,'cocinero',2),(6,'Laia','Soldevilla','19325488D',684599977,'cocinero',3),(7,'Sara','Martinez','22548963S',686886362,'reparto',3),(8,'Mayka','Gonzalez','34256981T',663322144,'reparto',4),(9,'Luis','Tosar','14869741H',609654987,'cocinero',4),(10,'Jeniffer','Aniston','33266599X',693287412,'reparto',5);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `idproductos` int(11) NOT NULL AUTO_INCREMENT,
  `producto` enum('pizza','burguer','bebida') NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `precio` double NOT NULL,
  PRIMARY KEY (`idproductos`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'bebida','agua',NULL,NULL,1.5),(2,'bebida','fanta',NULL,NULL,2.5),(3,'burguer','completa',NULL,NULL,4.5),(4,'burguer','normal',NULL,NULL,3.5),(5,'pizza','barbacoa',NULL,NULL,6.5),(6,'pizza','margarita',NULL,NULL,5),(7,'pizza','romana',NULL,NULL,7),(8,'pizza','funghi',NULL,NULL,7),(9,'pizza','caprichiosa',NULL,NULL,7),(10,'pizza','serrana',NULL,NULL,6.5);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reparto`
--

DROP TABLE IF EXISTS `reparto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reparto` (
  `idreparto` int(11) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `entrega` datetime(6) NOT NULL,
  `empleados_idempleados` int(11) NOT NULL,
  `comanda_idcomanda` int(11) NOT NULL,
  `comanda_client_idclient` int(11) NOT NULL,
  `comanda_tienda_idtienda` int(11) NOT NULL,
  PRIMARY KEY (`idreparto`,`empleados_idempleados`,`comanda_idcomanda`,`comanda_client_idclient`,`comanda_tienda_idtienda`),
  KEY `fk_reparto_empleados1_idx` (`empleados_idempleados`),
  KEY `fk_reparto_comanda1_idx` (`comanda_idcomanda`,`comanda_client_idclient`,`comanda_tienda_idtienda`),
  CONSTRAINT `fk_reparto_comanda1` FOREIGN KEY (`comanda_idcomanda`, `comanda_client_idclient`, `comanda_tienda_idtienda`) REFERENCES `comanda` (`idcomanda`, `client_idclient`, `tienda_idtienda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reparto_empleados1` FOREIGN KEY (`empleados_idempleados`) REFERENCES `empleados` (`idempleados`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reparto`
--

LOCK TABLES `reparto` WRITE;
/*!40000 ALTER TABLE `reparto` DISABLE KEYS */;
INSERT INTO `reparto` VALUES (0,'0','0023-08-11 21:00:00.000000',1,1,1,1),(1,'Pispireta 8','2023-05-06 20:00:00.000000',7,2,4,3),(2,'Olivera 65','2023-09-02 21:00:00.000000',10,3,8,5);
/*!40000 ALTER TABLE `reparto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tienda`
--

DROP TABLE IF EXISTS `tienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tienda` (
  `idtienda` int(11) NOT NULL AUTO_INCREMENT,
  `direccion` varchar(45) NOT NULL,
  `codigo_postal` int(11) NOT NULL,
  `localidad` varchar(50) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`idtienda`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tienda`
--

LOCK TABLES `tienda` WRITE;
/*!40000 ALTER TABLE `tienda` DISABLE KEYS */;
INSERT INTO `tienda` VALUES (1,'travessera de les corts 45',80150,'Barcelona','Barcelona'),(2,'Gran de gracia 122',80364,'Barcelona','Barcelona'),(3,'Hort de la figuera 11',8521,'Sant Vicenç dels Horts','Barcelona'),(4,'Pot petit 2',7459,'Agramunt','LLeida'),(5,'Dels angels 5',8004,'Barcelona','Barcelona');
/*!40000 ALTER TABLE `tienda` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-19 22:41:14
