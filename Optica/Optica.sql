CREATE DATABASE  IF NOT EXISTS `optica` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `optica`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: optica
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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `idClientes` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `telefono` INT NOT NULL,
  `mail` varchar(45) NOT NULL,
  `fecha_registro` date NOT NULL,
  `id_recomendacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`idClientes`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Lucas','08620','663259814','gracioso@gmail.com','2020-02-20',0),(2,'Marta','12004','625147236','hola@hotmail.com','2023-03-15',0),(3,'Carlos','08536','695178963','carlota@yahoo.es','2021-12-23',1),(4,'Pakita','08412','632145987','pakitasala@hotmail.com','2019-12-15',2);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `Clientes_idClientes` int(11) NOT NULL,
  `gafas_codigo` int(11) NOT NULL,
  `fecha_compra` date NOT NULL,
  `Empleado_idEmpleado` int(11) NOT NULL,
  PRIMARY KEY (`Clientes_idClientes`,`gafas_codigo`),
  KEY `fk_Clientes_has_gafas_gafas1_idx` (`gafas_codigo`),
  KEY `fk_Clientes_has_gafas_Clientes1_idx` (`Clientes_idClientes`),
  KEY `fk_compras_Empleado1_idx` (`Empleado_idEmpleado`),
  CONSTRAINT `fk_Clientes_has_gafas_Clientes1` FOREIGN KEY (`Clientes_idClientes`) REFERENCES `clientes` (`idClientes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_has_gafas_gafas1` FOREIGN KEY (`gafas_codigo`) REFERENCES `gafas` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_Empleado1` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,3,'2023-06-18',5),(1,6,'2023-08-10',3),(2,2,'2023-05-12',2);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `idEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idEmpleado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Nil'),(2,'Jos Luis'),(3,'Lucia'),(4,'Laia'),(5,'Francesca'),(6,'Clarabel');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gafas`
--

DROP TABLE IF EXISTS `gafas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gafas` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(60) NOT NULL,
  `grad_derch` FLOAT(8) NULL,
  `grad_izq` FLOAT(8) NULL,
  `montura` enum('flotante','pasta','metalica') NOT NULL,
  `color_montura` varchar(45) NOT NULL,
  `color_cris_derch` varchar(45) DEFAULT NULL,
  `color_cris_izq` varchar(45) DEFAULT NULL,
  `precio` double NOT NULL,
  `Proveedores_idProveedores` int(11) NOT NULL,
  PRIMARY KEY (`codigo`,`Proveedores_idProveedores`),
  KEY `fk_gafas_Proveedores_idx` (`Proveedores_idProveedores`),
  CONSTRAINT `fk_gafas_Proveedores` FOREIGN KEY (`Proveedores_idProveedores`) REFERENCES `proveedores` (`idProveedores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gafas`
--

LOCK TABLES `gafas` WRITE;
/*!40000 ALTER TABLE `gafas` DISABLE KEYS */;
INSERT INTO `gafas` VALUES (1,'XinXin','0.5','0.5','flotante','roja','transparente','transparente',23.66,1),(2,'Asmin','0.25','0.12','pasta','negro','blanco','blanco',14.25,2),(3,'Dior','1','1','metalica','azul','negro','negro',52,3),(6,'Gabana','0','0','metalica','dorado','polarizado','polarizado',100,2);
/*!40000 ALTER TABLE `gafas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `idProveedores` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `ciudad` varchar(45) NOT NULL,
  `codigo_postal` int(10) NOT NULL,
  `pais` varchar(45) NOT NULL,
  `telefono` int(10) NOT NULL,
  `fax` int(10) NOT NULL,
  `nif` varchar(45) NOT NULL,
  PRIMARY KEY (`idProveedores`),
  UNIQUE KEY `nif_UNIQUE` (`nif`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'MaxLoops','buenavista 12','Mostoles',5623,'España','91236589','912365478','P25963741'),(2,'RayBan','poligono cipreses 65','Paris',14789,'Francia','523698741','256398741','GV25639'),(3,'Mirabien','mayor 147','Nueva York',52368,'EEUU','555698321','555963741','T563218K'),(4,'Nike','pluton','Barcelona',8221,'España','93265895','936548217','J5632418');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-18 15:46:57
