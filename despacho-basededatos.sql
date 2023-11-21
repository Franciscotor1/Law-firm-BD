-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema despacho
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema despacho
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `despacho` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `despacho` ;

-- -----------------------------------------------------
-- Table `despacho`.`abogados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`abogados` (
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `sexo` ENUM('Masculino', 'Femenino') NULL DEFAULT NULL,
  `especialidad` VARCHAR(50) NULL DEFAULT NULL,
  `sueldo` DECIMAL(10,2) NULL DEFAULT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `correo_electronico` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `despacho`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `sexo` ENUM('Masculino', 'Femenino') NULL DEFAULT NULL,
  `ingresos` DECIMAL(15,2) NULL DEFAULT NULL,
  `correo_electronico` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `despacho`.`personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`personal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `sexo` ENUM('Masculino', 'Femenino') NULL DEFAULT NULL,
  `sueldo` DECIMAL(10,2) NULL DEFAULT NULL,
  `puesto` VARCHAR(50) NULL DEFAULT NULL,
  `correo_electronico` VARCHAR(100) NULL DEFAULT NULL,
  `abogado_id` INT NULL DEFAULT NULL,
  `cliente_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_abogado_id` (`abogado_id` ASC) VISIBLE,
  INDEX `fk_cliente_id_personal` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_abogado`
    FOREIGN KEY (`abogado_id`)
    REFERENCES `despacho`.`abogados` (`id`),
  CONSTRAINT `fk_abogado_id`
    FOREIGN KEY (`abogado_id`)
    REFERENCES `despacho`.`abogados` (`id`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_cliente_id_personal`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `despacho`.`clientes` (`id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `despacho`.`casos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`casos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NULL DEFAULT NULL,
  `abogado_id` INT NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `fecha_inicio` DATE NULL DEFAULT NULL,
  `fecha_fin` DATE NULL DEFAULT NULL,
  `honorarios` DECIMAL(15,2) NULL DEFAULT NULL,
  `estado` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_abogado_id_casos` (`abogado_id` ASC) VISIBLE,
  INDEX `fk_cliente_id_casos` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_abogado_casos`
    FOREIGN KEY (`abogado_id`)
    REFERENCES `despacho`.`abogados` (`id`),
  CONSTRAINT `fk_abogado_id_casos`
    FOREIGN KEY (`abogado_id`)
    REFERENCES `despacho`.`abogados` (`id`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `despacho`.`clientes` (`id`),
  CONSTRAINT `fk_cliente_id_casos`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `despacho`.`personal` (`id`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_personal_casos`
    FOREIGN KEY (`abogado_id`)
    REFERENCES `despacho`.`personal` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `despacho`.`jueces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`jueces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NULL DEFAULT NULL,
  `sexo` ENUM('Masculino', 'Femenino') NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `despacho`.`audiencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`audiencias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `caso_id` INT NULL DEFAULT NULL,
  `juez_id` INT NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `resultado` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `caso_id` (`caso_id` ASC) VISIBLE,
  INDEX `juez_id` (`juez_id` ASC) VISIBLE,
  CONSTRAINT `audiencias_ibfk_1`
    FOREIGN KEY (`caso_id`)
    REFERENCES `despacho`.`casos` (`id`),
  CONSTRAINT `audiencias_ibfk_2`
    FOREIGN KEY (`juez_id`)
    REFERENCES `despacho`.`jueces` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `despacho`.`documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`documentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `caso_id` INT NULL DEFAULT NULL,
  `tipo_documento` VARCHAR(50) NULL DEFAULT NULL,
  `contenido` TEXT NULL DEFAULT NULL,
  `fecha_creacion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `caso_id` (`caso_id` ASC) VISIBLE,
  CONSTRAINT `documentos_ibfk_1`
    FOREIGN KEY (`caso_id`)
    REFERENCES `despacho`.`casos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `despacho`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `despacho`.`pagos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NULL DEFAULT NULL,
  `monto` DECIMAL(15,2) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_id_pagos` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_id_pagos`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `despacho`.`clientes` (`id`)
    ON DELETE SET NULL,
  CONSTRAINT `pagos_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `despacho`.`clientes` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `despacho`;

DELIMITER $$
USE `despacho`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `despacho`.`before_insert_personal`
BEFORE INSERT ON `despacho`.`personal`
FOR EACH ROW
BEGIN
    IF NEW.puesto = 'Abogado' THEN
        SET NEW.abogado_id = (SELECT id FROM abogados WHERE nombre = NEW.nombre AND apellido = NEW.apellido LIMIT 1);
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
