-- MySQL dump 10.13  Distrib 5.1.39, for Win64 (unknown)
--
-- Host: localhost    Database: itdadb002
-- ------------------------------------------------------
-- Server version	5.1.39-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `itda_attribute`
--

DROP TABLE IF EXISTS `itda_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itda_attribute` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `display_order` float DEFAULT NULL,
  `enabled` bit(1) NOT NULL,
  `long_label` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `name2` varchar(255) DEFAULT NULL,  
  `short_label` varchar(255) DEFAULT NULL,
  `value` varchar(255) NOT NULL,
  `value2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itda_attribute`
--

LOCK TABLES `itda_attribute` WRITE;
/*!40000 ALTER TABLE `itda_attribute` DISABLE KEYS */;
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (1,0,NULL,true,NULL,'manufacturerCode','All American','allamerican');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (2,1,NULL,true,NULL,'manufacturerCode','Audible','audible');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (3,0,NULL,true,NULL,'manufacturerCode','NuEar','nuear');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (4,0,NULL,true,NULL,'manufacturerCode','Star Key','starkey');

INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (5,0,NULL,true,NULL,'offerCode','50% Off','50X');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (6,0,NULL,true,NULL,'offerCode','$500 Off','500');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (7,0,NULL,true,NULL,'offerCode','$995','995');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (8,0,NULL,true,NULL,'offerCode','$1495','1495');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (9,0,NULL,true,NULL,'offerCode','45% Off','45X');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (10,0,NULL,true,NULL,'offerCode','Expert','EXP');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (11,0,NULL,true,NULL,'offerCode','Free Hearing Test','FHT');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (12,0,NULL,true,NULL,'offerCode','40% Off','40X');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (13,0,NULL,true,NULL,'offerCode','Buy One Get One Free','BOGO');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (14,0,NULL,true,NULL,'offerCode','Try Before You Buy','TBYB');
INSERT INTO `itda_attribute` (`id`, `version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (15,0,NULL,true,NULL,'offerCode','As Low As XX Per Month','ALA');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,true,NULL,'offerCode','Other','OTHER');

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,true,NULL,'adTypeCode','Newspaper','NP');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,true,NULL,'adTypeCode','Direct Mail','DM');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,true,NULL,'adTypeCode','Media','ME');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,true,NULL,'adTypeCode','Event','EV');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,true,NULL,'adTypeCode','Miscellaneous','MI');
INSERT INTO `itda_attribute` (`version`, `display_order`,  `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,NULL,'adTypeCode','UNKNOWN','UNKNOWN');

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Full Page','adSizeCode', 'NP','Full Page','FP', '129');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'3/4 Page Vertical','adSizeCode', 'NP','3/4 Page V','3_4V', '119');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'2/3 Page Vertical','adSizeCode', 'NP','2/3 Page V','2_3V', '109');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'2/3 Page Horizontal','adSizeCode', 'NP','2/3 Page H','2_3H', '109');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/2 Page Vertical','adSizeCode', 'NP','1/2 Page V','1_2V', '99');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/2 Page Horizontal','adSizeCode', 'NP','1/2 Page H','1_2H', '99');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/3 Page Vertical','adSizeCode', 'NP','1/3 Page V','1_3V', '89');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/3 Page Horizontal','adSizeCode', 'NP','1/3 Page H','1_3H', '89');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/4 Page Horizontal','adSizeCode', 'NP','1/4 Page H','1_4H', '79');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/4 Page Vertical','adSizeCode', 'NP','1/4 Page V','1_4V', '79');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/5 Page Vertical','adSizeCode', 'NP','1/5 Page V','1_5V', '69');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/5 Page Horizontal','adSizeCode', 'NP','1/5 Page H','1_5H', '69');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/6 Page Vertical','adSizeCode', 'NP','1/6 Page V','1_6V', '69');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/6 Page Horizontal','adSizeCode', 'NP','1/6 Page H','1_6H', '69');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/6 Page 2 Column','adSizeCode', 'NP','1/6 Page 2C','1_62C', '69');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/6 Page 3 Column','adSizeCode', 'NP','1/6 Page 3C','1_63C', '69');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/8 Page Vertical','adSizeCode', 'NP','1/8 Page V','1_8V', '59');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'1/8 Page Horizontal','adSizeCode', 'NP','1/8 Page H','1_8H', '59');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'6 Column Horizontal','adSizeCode', 'NP','6CH','6CH', '100');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'2 Panel Newspaper Insert','adSizeCode', 'NP','2PI','2PI', '100');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'4 Panel Newspaper Insert','adSizeCode', 'NP','4PI','4PI', '100');

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Standard Letter','adSizeCode', 'DM','Standard Letter','SL', '79');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Check Letter','adSizeCode', 'DM','Check Letter','CL', '99');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Check','adSizeCode', 'DM','Check','CH', '19');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Invitation Mailer','adSizeCode', 'DM','Invitation Mailer','IM', '89');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Postcard','adSizeCode', 'DM','Postcard','PC', '69');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Self Mailer','adSizeCode', 'DM','Self Mailer','SM', '129');

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'TV 30 Seconds','adSizeCode', 'ME','TV 30 Sec','TV_30_SEC');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'TV 30 Seconds','adSizeCode', 'ME','TV 60 Sec','TV_60_SEC');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Radio 30 Seconds','adSizeCode', 'ME','Radio 30 Sec','RADIO_30_SEC');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Radio 60 Seconds','adSizeCode', 'ME','Radio 60 Sec','RADIO_60_SEC');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Internet Ad','adSizeCode', 'ME','Internet Ad','INTERNET_AD');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Social Media','adSizeCode', 'ME','Social Media','SOCIAL_MEDIA');


INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Open House','adSizeCode', 'EV','Open House','OPEN_HOUSE');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,'Health Fair',true,NULL,'adSizeCode', 'EV','Health Fair','HEALTH_FAIR');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Outreach Program','adSizeCode', 'EV','Outreach Program','OUTREACH_PROGRAM');

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Lead Pull','adSizeCode', 'MI','Lead Pull','LEAD_PULL');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Bus Ad','adSizeCode', 'MI','Bus Ad','BUS_AD');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Billboard','adSizeCode', 'MI','Billboard','BILLBOARD');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,true,'Contest','adSizeCode', 'MI','Contest','CONTEST');


INSERT INTO `itda_attribute` (`version`, `display_order`,  `long_label`, `name`, `name2`, `short_label`, `value`) 
VALUES (0,NULL,NULL,'adSizeCode', 'UNKNOWN','UNKNOWN','UNKNOWN');


INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Size','adSizeCode', 'NP','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'DM','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'ME','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'EV','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'MI','Other','OTHER', 300);


INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Up to 3 Offices for $129/Month includes 15 GB of file storage','pricingPlanCode','3', 'Up to 3 Offices for $129/Month','129', '15 GB');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Up to 6 Offices for $199/Month includes 40 GB of file storage','pricingPlanCode', '6','Up to 6 Offices for $199/Month','199', '40 GB');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Up to 12 Offices $249/Month includes 75 GB of file storage','pricingPlanCode', '12', 'Up to 12 Offices for $249/Month','249', '75 GB');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Unlimited Offices for $499/Month includes 100 GB of file storage','pricingPlanCode', '9999999','Unlimited Offices for $499/Month','499', '100 GB');


/*!40000 ALTER TABLE `itda_attribute` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-30  6:49:36
