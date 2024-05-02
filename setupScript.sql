-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Address` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(255) NOT NULL,
  `City` VARCHAR(100) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `AddressID` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  `CustomerName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idCustomer`),
  UNIQUE INDEX `ContactNumber_UNIQUE` (`ContactNumber` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `AddressIDCust`
    FOREIGN KEY (`AddressID`)
    REFERENCES `LittleLemonDB`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Delivery` (
  `idDelivery` INT NOT NULL AUTO_INCREMENT,
  `AddressID` INT NOT NULL,
  `DeliveryStatus` VARCHAR(45) NOT NULL DEFAULT 'Not ready',
  `DeliveryTarget` DATETIME NULL,
  `DeliveryAchieved` DATETIME NULL,
  PRIMARY KEY (`idDelivery`),
  INDEX `AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `AddressIDDel`
    FOREIGN KEY (`AddressID`)
    REFERENCES `LittleLemonDB`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `idOrders` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `DeliveryID` INT NOT NULL,
  `OrderPlaced` DATETIME NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `DeliveryID_idx` (`DeliveryID` ASC) VISIBLE,
  CONSTRAINT `CustomerIDOrd`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DeliveryID`
    FOREIGN KEY (`DeliveryID`)
    REFERENCES `LittleLemonDB`.`Delivery` (`idDelivery`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `AddressID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(55) NOT NULL,
  `Salary` DECIMAL NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  PRIMARY KEY (`idEmployee`),
  INDEX `AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `AddressIDEmp`
    FOREIGN KEY (`AddressID`)
    REFERENCES `LittleLemonDB`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `idBookings` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `TableNo` INT NULL,
  `When` DATETIME NOT NULL,
  `EmployeeID` INT NULL,
  `Bookingscol` VARCHAR(45) NULL,
  PRIMARY KEY (`idBookings`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `EmployeeID_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `CustomerIDBook`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EmployeeIDBook`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `idMenu` INT NOT NULL AUTO_INCREMENT,
  `Cusine` VARCHAR(45) NULL,
  PRIMARY KEY (`idMenu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Course` (
  `idCourse` INT NOT NULL AUTO_INCREMENT,
  `Course` VARCHAR(45) NULL,
  PRIMARY KEY (`idCourse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `idMenuItems` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `MenuID` INT NOT NULL,
  `CourseID` INT NOT NULL,
  PRIMARY KEY (`idMenuItems`),
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `CourseID_idx` (`CourseID` ASC) VISIBLE,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CourseID`
    FOREIGN KEY (`CourseID`)
    REFERENCES `LittleLemonDB`.`Course` (`idCourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderItems` (
  `idOrderItems` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `MenuItemID` INT NOT NULL,
  PRIMARY KEY (`idOrderItems`),
  INDEX `OrderID_idx` (`OrderID` ASC) VISIBLE,
  INDEX `MenuIItemID_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuIItemID`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`idMenuItems`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
