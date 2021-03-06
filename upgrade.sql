use home_inventory;

ALTER TABLE `home_inventory`.`Item` 
ADD COLUMN `ITM_Brand` VARCHAR(40)  DEFAULT NULL AFTER `ITM_Quantity`,
ADD COLUMN `ITM_Model` VARCHAR(40)  DEFAULT NULL AFTER `ITM_Brand`,
ADD COLUMN `ITM_SerialNum` VARCHAR(20)  DEFAULT NULL AFTER `ITM_Model`,

ADD COLUMN `ITM_State` TINYINT DEFAULT NULL AFTER `ITM_SerialNum`,
ADD COLUMN `ITM_Condition` TINYINT DEFAULT NULL AFTER `ITM_State`,
ADD COLUMN `ITM_ConditionDescr` VARCHAR(80) DEFAULT NULL AFTER `ITM_Condition`,

ADD COLUMN `ITM_PurchaseDate` date DEFAULT NULL AFTER `ITM_ConditionDescr`,
ADD COLUMN `ITM_PurchaseLocation` VARCHAR(40) DEFAULT NULL AFTER `ITM_PurchaseDate`,
ADD COLUMN `ITM_PurchasePrice` VARCHAR(15) DEFAULT NULL AFTER `ITM_PurchaseLocation`,

ADD COLUMN `ITM_CurrentValue` VARCHAR(15) DEFAULT NULL AFTER `ITM_PurchasePrice`,
ADD COLUMN `ITM_ReplacementCost` VARCHAR(15) DEFAULT NULL AFTER `ITM_CurrentValue`,

ADD COLUMN `ITM_WarrantyInfo` VARCHAR(100) DEFAULT NULL AFTER `ITM_ReplacementCost`,
ADD COLUMN `ITM_History` VARCHAR(300) DEFAULT NULL AFTER `ITM_WarrantyInfo`;



CREATE TABLE `Picture` (
  `PCT_ID` int(11) NOT NULL auto_increment,
  `PCT_ItemId` int(11) NOT NULL default '0',
  `PCT_FileName` varchar(50) default NULL,
  PRIMARY KEY  (`PCT_ID`),
  KEY `PCT_ItemId` (`PCT_ItemId`),
  CONSTRAINT `PCT_Item_fk` FOREIGN KEY (`PCT_ItemId`) REFERENCES `Item` (`ITM_ID`)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1 
COMMENT='Item''s Picture';


