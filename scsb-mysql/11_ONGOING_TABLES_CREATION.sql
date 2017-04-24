USE `recap`;

CREATE TABLE IF NOT EXISTS `JOB_T` (
  `JOB_ID` INT NOT NULL AUTO_INCREMENT,
  `JOB_NAME` VARCHAR(45) NULL,
  `JOB_DESC` VARCHAR(2000) NULL,
  `LAST_EXECUTED_TIME` DATETIME NULL,
  `NEXT_RUN_TIME` DATETIME NULL,
  `CRON_EXP` VARCHAR(45) NULL,
  `STATUS` VARCHAR(45) NULL,
  PRIMARY KEY (`JOB_ID`))

ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `DELIVERY_RESTRICTION_CROSS_PARTNER_T` (
  `DELIVERY_RESTRICTION_CROSS_PARTNER_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `DELIVERY_RESTRICTIONS` VARCHAR(2000) NOT NULL,
  `INSTITUTION_ID` INT(11) NOT NULL,
  PRIMARY KEY (`DELIVERY_RESTRICTION_CROSS_PARTNER_ID`),
  KEY `FK_DELIVERY_RESTRICTION_CROSS_PARTNER_T_1_IDX` (`INSTITUTION_ID`),
  CONSTRAINT `FK_DELIVERY_RESTRICTION_CROSS_PARTNER_REQUESTING_INST` FOREIGN KEY (`INSTITUTION_ID`) REFERENCES `INSTITUTION_T` (`INSTITUTION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION)

ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `CROSS_PARTNER_MAPPING_T` (
  `CUSTOMER_CODE_ID` INT(11) NOT NULL,
  `DELIVERY_RESTRICTION_CROSS_PARTNER_ID` INT(11) NOT NULL,
  PRIMARY KEY (`CUSTOMER_CODE_ID`,`DELIVERY_RESTRICTION_CROSS_PARTNER_ID`),
  CONSTRAINT `FK_CROSS_PARTNER_CUSTOMER_CODE` FOREIGN KEY (`CUSTOMER_CODE_ID`) REFERENCES `CUSTOMER_CODE_T` (`CUSTOMER_CODE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DELIVERY_RESTRICTION_ID` FOREIGN KEY (`DELIVERY_RESTRICTION_CROSS_PARTNER_ID`) REFERENCES `DELIVERY_RESTRICTION_CROSS_PARTNER_T` (`DELIVERY_RESTRICTION_CROSS_PARTNER_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION)

ENGINE=INNODB;

CREATE TABLE REQUEST_INST_BIB_T (
  ITEM_ID INT(11) NOT NULL,
  OWNING_INST_BIB_ID VARCHAR(45) NOT NULL,
  OWNING_INST_ID INT(11) NOT NULL,
  PRIMARY KEY (ITEM_ID, OWNING_INST_ID),
  KEY INSTITUTION_INSTITUTION_ID_FK (OWNING_INST_ID),
  CONSTRAINT INSTITUTION_INSTITUTION_ID_FK FOREIGN KEY (OWNING_INST_ID) REFERENCES INSTITUTION_T (INSTITUTION_ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT ITEM_ITEM_ID_FK FOREIGN KEY (ITEM_ID) REFERENCES ITEM_T (ITEM_ID) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `MATCHING_BIB_INFO_DETAIL_T` (
  `MATCHING_BIB_INFO_DATA_DUMP_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BIB_ID` varchar(45) NOT NULL,
  `OWNING_INST_BIB_ID` varchar(45) NOT NULL,
  `OWNING_INST` varchar(5) NOT NULL,
  `LATEST_RECORD_NUM` int(11) NOT NULL,
  PRIMARY KEY (`MATCHING_BIB_INFO_DATA_DUMP_ID`),
  KEY `BIB_ID_IDX` (`BIB_ID`),
  KEY `RECORD_NUM_IDX` (`LATEST_RECORD_NUM`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `USER_T` (
  `USER_ID` INT NOT NULL,
  `LOGIN_ID` VARCHAR(45) NOT NULL,
  `USER_INSTITUTION` INT NOT NULL,
  `USER_DESCRIPTION` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`USER_ID`),
  INDEX `FK_USER_T_1_IDX` (`USER_INSTITUTION` ASC),
  CONSTRAINT `FK_USER_T_1`
    FOREIGN KEY (`USER_INSTITUTION`)
    REFERENCES `INSTITUTION_T` (`INSTITUTION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `ROLES_T` (
  `ROLE_ID` INT NOT NULL,
  `ROLE_NAME` VARCHAR(45) NOT NULL,
  `ROLE_DESCRIPTION` VARCHAR(80) NULL,
  PRIMARY KEY (`ROLE_ID`),
  UNIQUE INDEX `ROLE_NAME_UNIQUE` (`ROLE_NAME` ASC))

ENGINE = InnoDB;

 CREATE TABLE IF NOT EXISTS `USER_ROLE_T` (
  `USER_ID` INT NOT NULL,
  `ROLE_ID` INT NOT NULL ,
  INDEX `FK_USER_ROLE_T_1_IDX` (`USER_ID` ASC),
  INDEX `FK_USER_ROLE_T_2_IDX` (`ROLE_ID` ASC),
  CONSTRAINT `FK_USER_ROLE_T_1`
  FOREIGN KEY (`USER_ID`)
  REFERENCES `USER_T` (`USER_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
  CONSTRAINT `FK_USER_ROLE_T_2`
  FOREIGN KEY (`ROLE_ID`)
  REFERENCES `ROLES_T` (`ROLE_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION)

ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `PERMISSIONS_T` (
  `PERMISSION_ID` INT NOT NULL,
  `PERMISSION_NAME` VARCHAR(45) NOT NULL,
  `PERMISSION_DESCRIPTION` VARCHAR(80) NULL,
  PRIMARY KEY (`PERMISSION_ID`))

ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `ROLE_PERMISSION_T` (
  `ROLE_ID` INT NOT NULL,
  `PERMISSION_ID` INT NOT NULL,
  INDEX `FK_ROLE_PERMISSION_T_1_IDX` (`ROLE_ID` ASC),
  INDEX `FK_ROLE_PERMISSION_T_2_IDX` (`PERMISSION_ID` ASC),
  CONSTRAINT `FK_ROLE_PERMISSION_T_1`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `ROLES_T` (`ROLE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ROLE_PERMISSION_T_2`
    FOREIGN KEY (`PERMISSION_ID`)
    REFERENCES `PERMISSIONS_T` (`PERMISSION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS REQUEST_ITEM_STATUS_T (
  REQUEST_STATUS_ID int(11) NOT NULL AUTO_INCREMENT,
  REQUEST_STATUS_CODE varchar(45) NOT NULL,
  REQUEST_STATUS_DESC varchar(512) NOT NULL,
  PRIMARY KEY (REQUEST_STATUS_ID),
  UNIQUE KEY REQUEST_STATUS_CODE_UNIQUE (REQUEST_STATUS_CODE))

ENGINE = InnoDB;
