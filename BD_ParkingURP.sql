SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `BD_ParkingURP` DEFAULT CHARACTER SET utf8 ;
USE `BD_ParkingURP` ;

-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Evento` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Evento` (
  `id_evento` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `decripcion` VARCHAR(255) NOT NULL ,
  `fecha_inicio` DATE NOT NULL ,
  `fecha_fin` DATE NOT NULL ,
  `estado` CHAR(1) NOT NULL ,
  PRIMARY KEY (`id_evento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Area` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Area` (
  `id_area` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `espacio` INT NOT NULL ,
  `total` INT NOT NULL ,
  `estado` CHAR(1) NOT NULL ,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `id_evento` INT NOT NULL ,
  PRIMARY KEY (`id_area`, `id_evento`) ,
  INDEX `fk_T_Area_T_Evento1_idx` (`id_evento` ASC) ,
  CONSTRAINT `fk_T_Area_T_Evento1`
    FOREIGN KEY (`id_evento` )
    REFERENCES `BD_ParkingURP`.`T_Evento` (`id_evento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Seccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Seccion` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Seccion` (
  `id_seccion` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `estado` CHAR(1) NOT NULL ,
  `id_area` INT NOT NULL ,
  PRIMARY KEY (`id_seccion`, `id_area`) ,
  INDEX `fk_T_Seccion_T_Area1_idx` (`id_area` ASC) ,
  CONSTRAINT `fk_T_Seccion_T_Area1`
    FOREIGN KEY (`id_area` )
    REFERENCES `BD_ParkingURP`.`T_Area` (`id_area` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Tipo_Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Tipo_Persona` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Tipo_Persona` (
  `id_tipo_persona` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL ,
  `tipo_sistema` CHAR(5) NOT NULL ,
  PRIMARY KEY (`id_tipo_persona`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Carrera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Carrera` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Carrera` (
  `id_carrera` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id_carrera`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Persona` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Persona` (
  `id_persona` INT NOT NULL AUTO_INCREMENT ,
  `codigo` CHAR(9) NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `ape_paterno` VARCHAR(45) NOT NULL ,
  `ape_materno` VARCHAR(45) NOT NULL ,
  `celular` CHAR(9) NULL DEFAULT NULL ,
  `correo` VARCHAR(255) NULL DEFAULT NULL ,
  `id_tipo_persona` INT NOT NULL ,
  `id_carrera` INT NOT NULL ,
  PRIMARY KEY (`id_persona`, `id_tipo_persona`, `id_carrera`) ,
  INDEX `fk_T_Persona_T_Tipo_Persona1_idx` (`id_tipo_persona` ASC) ,
  INDEX `fk_T_Persona_T_Carrera1_idx` (`id_carrera` ASC) ,
  CONSTRAINT `fk_T_Persona_T_Tipo_Persona1`
    FOREIGN KEY (`id_tipo_persona` )
    REFERENCES `BD_ParkingURP`.`T_Tipo_Persona` (`id_tipo_persona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_Persona_T_Carrera1`
    FOREIGN KEY (`id_carrera` )
    REFERENCES `BD_ParkingURP`.`T_Carrera` (`id_carrera` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Usuario` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT ,
  `codigo` CHAR(9) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `estado` CHAR(1) NOT NULL ,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `id_persona` INT NOT NULL ,
  PRIMARY KEY (`id_usuario`, `id_persona`) ,
  INDEX `fk_T_Usuario_T_Persona1_idx` (`id_persona` ASC) ,
  CONSTRAINT `fk_T_Usuario_T_Persona1`
    FOREIGN KEY (`id_persona` )
    REFERENCES `BD_ParkingURP`.`T_Persona` (`id_persona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Control`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Control` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Control` (
  `id_control` INT NOT NULL AUTO_INCREMENT ,
  `entrada` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `salida` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP ,
  `flag_quedarse` CHAR(1) NOT NULL ,
  `motivo` VARCHAR(45) NULL DEFAULT NULL ,
  `id_usuario` INT NOT NULL ,
  PRIMARY KEY (`id_control`, `id_usuario`) ,
  INDEX `fk_T_Control_T_Usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_T_Control_T_Usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `BD_ParkingURP`.`T_Usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Color`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Color` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Color` (
  `id_color` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id_color`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Marca_Vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Marca_Vehiculo` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Marca_Vehiculo` (
  `id_marca_vehiculo` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id_marca_vehiculo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Tipo_Vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Tipo_Vehiculo` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Tipo_Vehiculo` (
  `id_tipo_vehiculo` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id_tipo_vehiculo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Marca_Vehiculo_has_T_Tipo_Vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Marca_Vehiculo_has_T_Tipo_Vehiculo` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Marca_Vehiculo_has_T_Tipo_Vehiculo` (
  `id_marca_vehiculo` INT NOT NULL ,
  `id_tipo_vehiculo` INT NOT NULL ,
  PRIMARY KEY (`id_marca_vehiculo`, `id_tipo_vehiculo`) ,
  INDEX `fk_T_Marca_Vehiculo_has_T_Tipo_Vehiculo_T_Tipo_Vehiculo1_idx` (`id_tipo_vehiculo` ASC) ,
  INDEX `fk_T_Marca_Vehiculo_has_T_Tipo_Vehiculo_T_Marca_Vehiculo1_idx` (`id_marca_vehiculo` ASC) ,
  CONSTRAINT `fk_T_Marca_Vehiculo_has_T_Tipo_Vehiculo_T_Marca_Vehiculo1`
    FOREIGN KEY (`id_marca_vehiculo` )
    REFERENCES `BD_ParkingURP`.`T_Marca_Vehiculo` (`id_marca_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_Marca_Vehiculo_has_T_Tipo_Vehiculo_T_Tipo_Vehiculo1`
    FOREIGN KEY (`id_tipo_vehiculo` )
    REFERENCES `BD_ParkingURP`.`T_Tipo_Vehiculo` (`id_tipo_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Vehiculo` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Vehiculo` (
  `id_vehiculo` INT NOT NULL AUTO_INCREMENT ,
  `placa` CHAR(8) NOT NULL ,
  `modelo` VARCHAR(45) NOT NULL ,
  `id_color` INT NOT NULL ,
  `id_marca_vehiculo` INT NOT NULL ,
  `id_tipo_vehiculo` INT NOT NULL ,
  PRIMARY KEY (`id_vehiculo`, `id_color`, `id_marca_vehiculo`, `id_tipo_vehiculo`) ,
  INDEX `fk_T_Vehiculo_T_Color1_idx` (`id_color` ASC) ,
  INDEX `fk_T_Vehiculo_T_Marca_Vehiculo_has_T_Tipo_Vehiculo1_idx` (`id_marca_vehiculo` ASC, `id_tipo_vehiculo` ASC) ,
  CONSTRAINT `fk_T_Vehiculo_T_Color1`
    FOREIGN KEY (`id_color` )
    REFERENCES `BD_ParkingURP`.`T_Color` (`id_color` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_Vehiculo_T_Marca_Vehiculo_has_T_Tipo_Vehiculo1`
    FOREIGN KEY (`id_marca_vehiculo` , `id_tipo_vehiculo` )
    REFERENCES `BD_ParkingURP`.`T_Marca_Vehiculo_has_T_Tipo_Vehiculo` (`id_marca_vehiculo` , `id_tipo_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Incidencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Incidencia` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Incidencia` (
  `id_incidencia` INT NOT NULL AUTO_INCREMENT ,
  `detalle` VARCHAR(255) NOT NULL ,
  `estado` VARCHAR(45) NOT NULL ,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id_incidencia`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Persona_has_T_Vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Persona_has_T_Vehiculo` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Persona_has_T_Vehiculo` (
  `id_persona` INT NOT NULL ,
  `id_vehiculo` INT NOT NULL ,
  PRIMARY KEY (`id_persona`, `id_vehiculo`) ,
  INDEX `fk_T_Persona_has_T_Vehiculo_T_Vehiculo1_idx` (`id_vehiculo` ASC) ,
  INDEX `fk_T_Persona_has_T_Vehiculo_T_Persona1_idx` (`id_persona` ASC) ,
  CONSTRAINT `fk_T_Persona_has_T_Vehiculo_T_Persona1`
    FOREIGN KEY (`id_persona` )
    REFERENCES `BD_ParkingURP`.`T_Persona` (`id_persona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_Persona_has_T_Vehiculo_T_Vehiculo1`
    FOREIGN KEY (`id_vehiculo` )
    REFERENCES `BD_ParkingURP`.`T_Vehiculo` (`id_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Vehiculo_has_T_Incidencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Vehiculo_has_T_Incidencia` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Vehiculo_has_T_Incidencia` (
  `id_vehiculo` INT NOT NULL ,
  `id_incidencia` INT NOT NULL ,
  PRIMARY KEY (`id_vehiculo`, `id_incidencia`) ,
  INDEX `fk_T_Vehiculo_has_T_Incidencia_T_Incidencia1_idx` (`id_incidencia` ASC) ,
  INDEX `fk_T_Vehiculo_has_T_Incidencia_T_Vehiculo1_idx` (`id_vehiculo` ASC) ,
  CONSTRAINT `fk_T_Vehiculo_has_T_Incidencia_T_Vehiculo1`
    FOREIGN KEY (`id_vehiculo` )
    REFERENCES `BD_ParkingURP`.`T_Vehiculo` (`id_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_Vehiculo_has_T_Incidencia_T_Incidencia1`
    FOREIGN KEY (`id_incidencia` )
    REFERENCES `BD_ParkingURP`.`T_Incidencia` (`id_incidencia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ParkingURP`.`T_Estacionamiento_Cercano`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ParkingURP`.`T_Estacionamiento_Cercano` ;

CREATE  TABLE IF NOT EXISTS `BD_ParkingURP`.`T_Estacionamiento_Cercano` (
  `id_estacionamiento_cercano` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(255) NOT NULL ,
  `latitud` VARCHAR(255) NOT NULL ,
  `longitud` VARCHAR(255) NOT NULL ,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id_estacionamiento_cercano`) )
ENGINE = InnoDB;

USE `BD_ParkingURP` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
