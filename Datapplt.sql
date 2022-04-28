-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbms_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbms_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbms_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `dbms_project` ;

-- -----------------------------------------------------
-- Table `dbms_project`.`Visible_Contact_List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms_project`.`Visible_Contact_List` (
  `Phone_Number` VARCHAR(11) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Phone_Number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbms_project`.`User_Data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms_project`.`User_Data` (
  `User_ID` VARCHAR(8) NOT NULL,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Status` VARCHAR(45) NULL,
  `About` VARCHAR(45) NULL,
  `Profile_Picture` GEOMETRY NULL,
  `Visible_Contact_List_Phone_Number` VARCHAR(11) NULL,
  `hide_details` VARCHAR(70) NULL,
  `online status` VARCHAR(45) NULL,
  PRIMARY KEY (`User_ID`),
  INDEX `fk_User_Data_Visible_Contact_List1_idx` (`Visible_Contact_List_Phone_Number` ASC) VISIBLE,
  CONSTRAINT `fk_User_Data_Visible_Contact_List1`
    FOREIGN KEY (`Visible_Contact_List_Phone_Number`)
    REFERENCES `dbms_project`.`Visible_Contact_List` (`Phone_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbms_project`.`DM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms_project`.`DM` (
  `DM_ID` VARCHAR(8) NOT NULL,
  `User_Data_User_ID` VARCHAR(8) NOT NULL,
  `Second_person_User_ID` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`DM_ID`),
  INDEX `fk_DM_User_Data1_idx` (`User_Data_User_ID` ASC) VISIBLE,
  INDEX `fk_DM_second_person_Data1_idx` (`Second_person_User_ID` ASC) VISIBLE,
  CONSTRAINT `fk_DM_User_Data1`
    FOREIGN KEY (`User_Data_User_ID`)
    REFERENCES `dbms_project`.`User_Data` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DM_second_person_Data1`
    FOREIGN KEY (`Second_person_User_ID`)
    REFERENCES `dbms_project`.`User_Data` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbms_project`.`Group_Chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms_project`.`Group_Chat` (
  `Group_ID` VARCHAR(8) NOT NULL,
  `Group_Admin` VARCHAR(45) NULL,
  `Group_Name` VARCHAR(45) NULL,
  `Group_Description` VARCHAR(45) NULL,
  `Group_Image` GEOMETRY NULL,
  `member` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Group_ID`, `member`),
  INDEX `fk_member_idx` (`member` ASC) VISIBLE,
  CONSTRAINT `fk_member`
    FOREIGN KEY (`member`)
    REFERENCES `dbms_project`.`User_Data` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbms_project`.`Conversation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms_project`.`Conversation` (
  `C_ID` VARCHAR(8) NOT NULL,
  `Time_Sent` DATETIME(6) NULL,
  `Conversation_Type` VARCHAR(45) NULL,
  `Time_delivered` DATETIME(6) NULL,
  `DM_DM_ID` VARCHAR(8) NULL,
  `Group_Chat_Group_ID` VARCHAR(8) NULL,
  `Time_read` DATETIME(6) NULL,
  PRIMARY KEY (`C_ID`),
  INDEX `fk_Conversation_Group_Chat1_idx` (`Group_Chat_Group_ID` ASC) VISIBLE,
  INDEX `fk_Conversation_DM1_idx` (`DM_DM_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Conversation_DM1`
    FOREIGN KEY (`DM_DM_ID`)
    REFERENCES `dbms_project`.`DM` (`DM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Conversation_Group_Chat1`
    FOREIGN KEY (`Group_Chat_Group_ID`)
    REFERENCES `dbms_project`.`Group_Chat` (`Group_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbms_project`.`Media_Files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms_project`.`Media_Files` (
  `Conversation_C_ID` VARCHAR(8) NOT NULL,
  `Files` BLOB NULL,
  INDEX `fk_Voice_Call_Conversation1_idx` (`Conversation_C_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Voice_Call_Conversation1`
    FOREIGN KEY (`Conversation_C_ID`)
    REFERENCES `dbms_project`.`Conversation` (`C_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbms_project`.`Message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms_project`.`Message` (
  `Conversation_C_ID` VARCHAR(8) NOT NULL,
  `message` VARCHAR(150) NULL,
  INDEX `fk_Message_Conversation1_idx` (`Conversation_C_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Message_Conversation1`
    FOREIGN KEY (`Conversation_C_ID`)
    REFERENCES `dbms_project`.`Conversation` (`C_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `visible_contact_list` (`Phone_Number`)
VALUES
  ("11313899067"),
  ("15117138635"),
  ("17984466629"),
  ("14233275622"),
  ("21556154730");


INSERT INTO `User_Data` (`User_ID`,`First_Name`,`Last_Name`,`About`,`Profile_Picture`,`Visible_Contact_List_Phone_Number`,`hide_details`,`online status`)
VALUES
  ("1","Nathaniel","Weaver","busy",null,"11313899067",0,"online"),
  ("2","Madeson","Flynn","using whatsapp",null,"15117138635",0,"offline"),
  ("3","Xaviera","Cash","vella",null,"17984466629",0,"online"),
  ("4","Aretha","Miranda","only calls",null,"14233275622",0,"offline"),
  ("5","Xanthus","Wood","on a break",null,"21556154730",0,"online");

INSERT INTO `dm` (`DM_ID`,`User_Data_User_Id`,`Second_person_User_ID`)
VALUES
  (11,1,4),
  (12,2,3),
  (13,3,1),
  (14,4,5),
  (15,5,2);

INSERT INTO `group_chat` (`Group_ID`,`Group_Admin`,`Group_Name`,`Group_Description`,`Group_Image`)
VALUES
  ("1","Raju","hera pheri","chori kahan karni hai",null),
 --  ("1","Shyam","hera pheri","chori kahan karni hai",null),
--   ("1","Babu Rao","hera pheri","chori kahan karni hai",null,"3"),
 --  ("8","Prem","ainve hi","baad mein sochege",null,"4"),
  ("2","Ram","ainve hi","baad mein sochege",null);

INSERT INTO members (`Group_ID`,`Member_ID`)
VALUES
  ("1",1),
  ("1",2),
  ("1",3),
  ("2",4),
  ("2",1);



INSERT INTO messenger (`Group_ID`,`Member_ID`,`C_ID`)
VALUES
  ("1",1,24),
  ("1",2,26),
  ("2",4,25),
  ("2",1,27);

INSERT INTO `conversation` (`C_ID`,`Time_Sent`,`Conversation_Type`,`Time_delivered`,`DM_DM_ID`,`Group_Chat_Group_ID`,`Time_read`)
VALUES
  ("21",'2000-01-03 10:00:00.000000',"message",0,11,null,0),
  ("22",'2000-01-03 11:00:00.000000',"message",0,12,null,0),
  ("23",'2000-01-03 01:00:00.000000',"message",0,13,null,0),
  ("24",'2000-01-03 02:00:00.000000',"message",0,null,1,0),
  ("25",'2000-01-03 03:00:00.000000',"message",0,null,8,0);


INSERT INTO `message` (`Conversation_C_ID`,`message`)
VALUES
  ("21","hello"),
  ("22","sup"),
  ("23","yo"),
  ("24","this is a group chat"),
  ("25","ho gaya group chat");


  INSERT INTO `media_files` (`Conversation_C_ID`,`Files`)
VALUES
  ("21",null),
  ("22",null),
  ("23",null),
  ("24",null),
  ("25",null);


