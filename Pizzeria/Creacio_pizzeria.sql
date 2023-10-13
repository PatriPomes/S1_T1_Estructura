-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`client` (
  `idclient` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT(8) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` INT(15) NOT NULL,
  PRIMARY KEY (`idclient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`tienda` (
  `idtienda` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `localidad` VARCHAR(50) NOT NULL,
  `provincia` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idtienda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comanda` (
  `idcomanda` INT NOT NULL AUTO_INCREMENT,
  `inici_comanda` DATETIME(6) NOT NULL,
  `tipo` ENUM('domicilio', 'tienda') NOT NULL,
  `numero_productos` INT NOT NULL,
  `precio_total` INT NOT NULL,
  `client_idclient` INT NOT NULL,
  `tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idcomanda`, `client_idclient`, `tienda_idtienda`),
  INDEX `fk_comanda_client_idx` (`client_idclient` ASC) ,
  INDEX `fk_comanda_tienda1_idx` (`tienda_idtienda` ASC) ,
  CONSTRAINT `fk_comanda_client`
    FOREIGN KEY (`client_idclient`)
    REFERENCES `Pizzeria`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `Pizzeria`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `Pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `producto` ENUM('pizza', 'burguer', 'bebida') NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `imagen` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DOUBLE NOT NULL,
  PRIMARY KEY (`idproductos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleados` (
  `idempleados` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` INT NOT NULL,
  `puesto` ENUM('cocinero', 'reparto') NOT NULL,
  `tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idempleados`, `tienda_idtienda`),
  INDEX `fk_empleados_tienda1_idx` (`tienda_idtienda` ASC) ,
  CONSTRAINT `fk_empleados_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `Pizzeria`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comanda_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comanda_has_productos` (
  `comanda_idcomanda` INT NOT NULL,
  `productos_idproductos` INT NOT NULL,
  `cantidad_productos` INT NULL,
  PRIMARY KEY (`comanda_idcomanda`, `productos_idproductos`),
  INDEX `fk_comanda_has_productos_productos1_idx` (`productos_idproductos` ASC) ,
  INDEX `fk_comanda_has_productos_comanda1_idx` (`comanda_idcomanda` ASC) ,
  CONSTRAINT `fk_comanda_has_productos_comanda1`
    FOREIGN KEY (`comanda_idcomanda`)
    REFERENCES `Pizzeria`.`comanda` (`idcomanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_has_productos_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `Pizzeria`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`reparto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`reparto` (
  `idreparto` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `entrega` DATETIME(6) NOT NULL,
  `empleados_idempleados` INT NOT NULL,
  `comanda_idcomanda` INT NOT NULL,
  `comanda_client_idclient` INT NOT NULL,
  `comanda_tienda_idtienda` INT NOT NULL,
  PRIMARY KEY (`idreparto`, `empleados_idempleados`, `comanda_idcomanda`, `comanda_client_idclient`, `comanda_tienda_idtienda`),
  INDEX `fk_reparto_empleados1_idx` (`empleados_idempleados` ASC) ,
  INDEX `fk_reparto_comanda1_idx` (`comanda_idcomanda` ASC, `comanda_client_idclient` ASC, `comanda_tienda_idtienda` ASC) ,
  CONSTRAINT `fk_reparto_empleados1`
    FOREIGN KEY (`empleados_idempleados`)
    REFERENCES `Pizzeria`.`empleados` (`idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reparto_comanda1`
    FOREIGN KEY (`comanda_idcomanda` , `comanda_client_idclient` , `comanda_tienda_idtienda`)
    REFERENCES `Pizzeria`.`comanda` (`idcomanda` , `client_idclient` , `tienda_idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `productos_idproductos` INT NOT NULL,
  PRIMARY KEY (`idcategoria`),
  INDEX `fk_categoria_productos1_idx` (`productos_idproductos` ASC) ,
  CONSTRAINT `fk_categoria_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `Pizzeria`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
