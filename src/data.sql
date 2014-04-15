-- MySQL dump 10.13  Distrib 5.6.14, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: rongzheng
-- ------------------------------------------------------
-- Server version	5.6.14

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
-- Table structure for table `RZ_HangYe`
--

DROP TABLE IF EXISTS `RZ_HangYe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_HangYe` (
  `行业名称` varchar(16) DEFAULT NULL,
  `行业编码` varchar(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`行业编码`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RZ_HangYe`
--

LOCK TABLES `RZ_HangYe` WRITE;
/*!40000 ALTER TABLE `RZ_HangYe` DISABLE KEYS */;
INSERT INTO `RZ_HangYe` VALUES ('农、林、牧、渔业','A'),('采掘业','B'),('制造业','C'),('电力、煤气及水的生产和供应业','D'),('建筑业','E'),('交通运输、仓储业','F'),('信息技术业','G'),('批发和零售贸易','H'),('金融、保险业','I'),('房地产业','J'),('社会服务业','K'),('传播与文化产业','L'),('综合类','M');
/*!40000 ALTER TABLE `RZ_HangYe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RZ_Area`
--

DROP TABLE IF EXISTS `RZ_Area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Area` (
  `地域全称` varchar(16) NOT NULL,
  `地域` varchar(4) NOT NULL,
  PRIMARY KEY (`地域全称`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RZ_Area`
--

LOCK TABLES `RZ_Area` WRITE;
/*!40000 ALTER TABLE `RZ_Area` DISABLE KEYS */;
INSERT INTO `RZ_Area` VALUES ('上海','上海'),('云南省','云南'),('内蒙古自治区','内蒙古'),('北京','北京'),('吉林省','吉林'),('四川省','四川'),('天津','天津'),('宁夏回族自治区','宁夏'),('安徽省','安徽'),('山东省','山东'),('山西省','山西'),('广东省','广东'),('广西壮族自治区','广西'),('新疆维吾尔自治区','新疆'),('江苏省','江苏'),('江西省','江西'),('河北省','河北'),('河南省','河南'),('浙江省','浙江'),('海南省','海南'),('湖北省','湖北'),('湖南省','湖南'),('甘肃省','甘肃'),('福建省','福建'),('西藏自治区','西藏'),('贵州省','贵州'),('辽宁省','辽宁'),('重庆','重庆'),('陕西省','陕西'),('青海省','青海'),('黑龙江省','黑龙江');
/*!40000 ALTER TABLE `RZ_Area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RZ_Job`
--

DROP TABLE IF EXISTS `RZ_Job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Job` (
  `职位内容` enum('董事长','总经理','副总经理','董秘','财务总监','独立董事','董事','监事','暂不考虑') DEFAULT NULL,
  `职位秩序` int(11) NOT NULL DEFAULT '0',
  `年薪_2011` int(11) DEFAULT NULL,
  `年薪_2012` int(11) DEFAULT NULL,
  `持股_2011` int(11) DEFAULT NULL,
  `持股_2012` int(11) DEFAULT NULL,
  PRIMARY KEY (`职位秩序`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RZ_Job`
--

LOCK TABLES `RZ_Job` WRITE;
/*!40000 ALTER TABLE `RZ_Job` DISABLE KEYS */;
INSERT INTO `RZ_Job` VALUES ('董事长',1,NULL,2457,962,1089),('总经理',2,1685,1808,545,631),('副总经理',4,8870,9688,2678,3130),('董秘',8,1295,1265,311,304),('财务总监',16,1157,1192,267,282),('独立董事',32,7806,8119,NULL,55),('董事',64,NULL,NULL,NULL,NULL),('监事',128,NULL,NULL,NULL,NULL),('暂不考虑',1000,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `RZ_Job` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-15 16:10:13
