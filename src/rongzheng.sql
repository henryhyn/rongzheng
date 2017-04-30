-- MySQL dump 10.13  Distrib 5.6.22, for osx10.10 (x86_64)
--
-- Host: 127.0.0.1    Database: rongzheng
-- ------------------------------------------------------
-- Server version	5.6.22

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
-- Table structure for table `RZ_Company_Salary_0000`
--

DROP TABLE IF EXISTS `RZ_Company_Salary_0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Company_Salary_0000` (
  `股票代码` char(9) NOT NULL,
  `股票简称` varchar(16) DEFAULT NULL,
  `高管薪酬总和` varchar(255) DEFAULT NULL,
  `高管人数` varchar(255) DEFAULT NULL,
  `领薪高管人数` varchar(255) DEFAULT NULL,
  `高管人均薪酬` varchar(255) DEFAULT NULL,
  `独董薪酬总和` varchar(255) DEFAULT NULL,
  `独董人数` varchar(255) DEFAULT NULL,
  `领薪独董人数` varchar(255) DEFAULT NULL,
  `独董人均薪酬` varchar(255) DEFAULT NULL,
  `员工薪酬总和` varchar(255) DEFAULT NULL,
  `员工人数` varchar(255) DEFAULT NULL,
  `员工人均薪酬` varchar(255) DEFAULT NULL,
  `董监薪酬总和` varchar(255) DEFAULT NULL,
  `董监人数` varchar(255) DEFAULT NULL,
  `领薪董监人数` varchar(255) DEFAULT NULL,
  `董监人均薪酬` varchar(255) DEFAULT NULL,
  `总股本` varchar(255) DEFAULT NULL,
  `流通股本` varchar(255) DEFAULT NULL,
  `总资产` varchar(255) DEFAULT NULL,
  `净资产` varchar(255) DEFAULT NULL,
  `营业总收入` varchar(255) DEFAULT NULL,
  `营业收入` varchar(255) DEFAULT NULL,
  `主营业务收入` varchar(255) DEFAULT NULL,
  `净利润` varchar(255) DEFAULT NULL,
  `利润总额` varchar(255) DEFAULT NULL,
  `息税前利润` varchar(255) DEFAULT NULL,
  `支付各项税费` varchar(255) DEFAULT NULL,
  `固定资产折旧` varchar(255) DEFAULT NULL,
  `固定资产累计折旧` varchar(255) DEFAULT NULL,
  `应付职工薪酬` varchar(255) DEFAULT NULL,
  `行业分类` enum('交通运输、仓储业','传播与文化产业','信息技术业','农、林、牧、渔业','制造业','建筑业','房地产业','批发和零售贸易','电力、煤气及水的生产和供应业','社会服务业','综合类','采掘业','金融、保险业') DEFAULT NULL,
  `企业属性` enum('国资委央企','地方国企','外资','民企','非国资委央企') DEFAULT NULL,
  `地域全称` enum('上海','云南省','内蒙古自治区','北京','吉林省','四川省','天津','宁夏回族自治区','安徽省','山东省','山西省','广东省','广西壮族自治区','新疆维吾尔自治区','江苏省','江西省','河北省','河南省','浙江省','海南省','湖北省','湖南省','甘肃省','福建省','西藏自治区','贵州省','辽宁省','重庆','陕西省','青海省','黑龙江省') DEFAULT NULL,
  PRIMARY KEY (`股票代码`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Company_Stock_0000`
--

DROP TABLE IF EXISTS `RZ_Company_Stock_0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Company_Stock_0000` (
  `股票代码` char(9) NOT NULL,
  `股票简称` varchar(16) DEFAULT NULL,
  `高管持股总数` varchar(255) DEFAULT NULL,
  `高管人数` varchar(255) DEFAULT NULL,
  `持股高管人数` varchar(255) DEFAULT NULL,
  `高管人均持股数量` varchar(255) DEFAULT NULL,
  `高管人均持股市值` varchar(255) DEFAULT NULL,
  `高管持股总数占比` varchar(255) DEFAULT NULL,
  `董监持股总数` varchar(255) DEFAULT NULL,
  `董监人数` varchar(255) DEFAULT NULL,
  `持股董监人数` varchar(255) DEFAULT NULL,
  `董监人均持股数量` varchar(255) DEFAULT NULL,
  `董监人均持股市值` varchar(255) DEFAULT NULL,
  `董监持股总数占比` varchar(255) DEFAULT NULL,
  `总股本` varchar(255) DEFAULT NULL,
  `流通股本` varchar(255) DEFAULT NULL,
  `总资产` varchar(255) DEFAULT NULL,
  `净资产` varchar(255) DEFAULT NULL,
  `营业收入` varchar(255) DEFAULT NULL,
  `净利润` varchar(255) DEFAULT NULL,
  `利润总额` varchar(255) DEFAULT NULL,
  `息税前利润` varchar(255) DEFAULT NULL,
  `行业分类` enum('交通运输、仓储业','传播与文化产业','信息技术业','农、林、牧、渔业','制造业','建筑业','房地产业','批发和零售贸易','电力、煤气及水的生产和供应业','社会服务业','综合类','采掘业','金融、保险业') DEFAULT NULL,
  `企业属性` enum('国资委央企','地方国企','外资','民企','非国资委央企') DEFAULT NULL,
  `地域全称` enum('上海','云南省','内蒙古自治区','北京','吉林省','四川省','天津','宁夏回族自治区','安徽省','山东省','山西省','广东省','广西壮族自治区','新疆维吾尔自治区','江苏省','江西省','河北省','河南省','浙江省','海南省','湖北省','湖南省','甘肃省','福建省','西藏自治区','贵州省','辽宁省','重庆','陕西省','青海省','黑龙江省') DEFAULT NULL,
  PRIMARY KEY (`股票代码`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Company_Size_0000`
--

DROP TABLE IF EXISTS `RZ_Company_Size_0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Company_Size_0000` (
  `股票代码` char(9) NOT NULL,
  `股票简称` varchar(16) DEFAULT NULL,
  `上市日期` varchar(255) DEFAULT NULL,
  `总股本` varchar(255) DEFAULT NULL,
  `年末收盘价` varchar(255) DEFAULT NULL,
  `基本每股收益` varchar(255) DEFAULT NULL,
  `每股收益` varchar(255) DEFAULT NULL,
  `净资产收益率` varchar(255) DEFAULT NULL,
  `摊薄净资产收益率` varchar(255) DEFAULT NULL,
  `加权净资产收益率` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`股票代码`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Company_Genre_0000`
--

DROP TABLE IF EXISTS `RZ_Company_Genre_0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Company_Genre_0000` (
  `股票代码` char(9) NOT NULL,
  `股票简称` varchar(16) DEFAULT NULL,
  `行业名称` varchar(16) DEFAULT NULL,
  `行业编码` varchar(2) NOT NULL DEFAULT '',
  KEY `股票代码` (`股票代码`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Salary_0000`
--

DROP TABLE IF EXISTS `RZ_Salary_0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Salary_0000` (
  `股票代码` char(9) DEFAULT NULL,
  `股票简称` varchar(16) DEFAULT NULL,
  `高管姓名` varchar(64) DEFAULT NULL,
  `职位` varchar(64) DEFAULT NULL,
  `年薪` varchar(255) DEFAULT NULL,
  `报告期` varchar(64) DEFAULT NULL,
  `兼职` enum('True','False') DEFAULT NULL,
  KEY `股票代码` (`股票代码`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Stock_0000`
--

DROP TABLE IF EXISTS `RZ_Stock_0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Stock_0000` (
  `股票代码` char(9) DEFAULT NULL,
  `股票简称` varchar(16) DEFAULT NULL,
  `高管姓名` varchar(64) DEFAULT NULL,
  `职位` varchar(64) DEFAULT NULL,
  `持股数量` varchar(255) DEFAULT NULL,
  `持股市值` varchar(255) DEFAULT NULL,
  `持股比例` varchar(255) DEFAULT NULL,
  `报告期` varchar(64) DEFAULT NULL,
  KEY `股票代码` (`股票代码`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-01 14:15:05
