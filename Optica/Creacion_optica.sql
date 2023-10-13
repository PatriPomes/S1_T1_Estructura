-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Proveedores` (
  `idProveedores` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` INT(10) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `fax` INT NULL,
  `nif` INT NOT NULL,
  PRIMARY KEY (`idProveedores`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`gafas` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(60) NOT NULL,
  `grad_derch` FLOAT(8) NULL,
  `grad_izq` FLOAT(8) NULL,
  `montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_cris_derch` VARCHAR(45) NULL,
  `color_cris_izq` VARCHAR(45) NULL,
  `precio` DOUBLE NOT NULL,
  `Proveedores_idProveedores` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_gafas_Proveedores1_idx` (`Proveedores_idProveedores` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_Proveedores1`
    FOREIGN KEY (`Proveedores_idProveedores`)
    REFERENCES `Optica`.`Proveedores` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `telefono` INT NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `id_recomendacion` INT NULL DEFAULT NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idClientes`),
  INDEX `fk_Clientes_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `Optica`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`compras` (
  `Clientes_idClientes` INT NOT NULL,
  `gafas_codigo` INT NOT NULL,
  `fecha_compra` DATE NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`Clientes_idClientes`, `gafas_codigo`, `Empleado_idEmpleado`),
  INDEX `fk_Clientes_has_gafas_gafas1_idx` (`gafas_codigo` ASC) VISIBLE,
  INDEX `fk_Clientes_has_gafas_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_compras_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_has_gafas_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `Optica`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_has_gafas_gafas1`
    FOREIGN KEY (`gafas_codigo`)
    REFERENCES `Optica`.`gafas` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Optica`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
