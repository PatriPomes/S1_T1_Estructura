-- MySQL Workbench Synchronization
-- Generated: 2023-10-16 16:07
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: patri

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `pizzeria`.`reparto` 
DROP FOREIGN KEY `fk_reparto_comanda1`;

ALTER TABLE `pizzeria`.`categoria` 
DROP FOREIGN KEY `fk_categoria_productos1`;

ALTER TABLE `pizzeria`.`productos` 
ADD COLUMN `categoria_idcategoria` INT(11) NOT NULL AFTER `precio`,
ADD INDEX `fk_productos_categoria1_idx` (`categoria_idcategoria` ASC) ;
;

ALTER TABLE `pizzeria`.`reparto` 
DROP COLUMN `comanda_tienda_idtienda`,
DROP COLUMN `comanda_client_idclient`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`idreparto`, `empleados_idempleados`, `comanda_idcomanda`),
DROP INDEX `fk_reparto_comanda1_idx` ,
ADD INDEX `fk_reparto_comanda1_idx` (`comanda_idcomanda` ASC) ;
;

ALTER TABLE `pizzeria`.`categoria` 
DROP COLUMN `productos_idproductos`,
CHANGE COLUMN `nombre` `nombre` VARCHAR(45) NULL DEFAULT NULL ,
DROP INDEX `fk_categoria_productos1_idx` ;
;

ALTER TABLE `pizzeria`.`productos` 
ADD CONSTRAINT `fk_productos_categoria1`
  FOREIGN KEY (`categoria_idcategoria`)
  REFERENCES `pizzeria`.`categoria` (`idcategoria`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `pizzeria`.`reparto` 
ADD CONSTRAINT `fk_reparto_comanda1`
  FOREIGN KEY (`comanda_idcomanda`)
  REFERENCES `pizzeria`.`comanda` (`idcomanda`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;