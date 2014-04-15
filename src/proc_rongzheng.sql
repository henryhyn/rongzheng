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
-- Table structure for table `RZ_Company`
--

DROP TABLE IF EXISTS `RZ_Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Company` (
  `股票代码` char(9) NOT NULL,
  `股票简称` varchar(16) DEFAULT NULL,
  `行业名称` varchar(16) DEFAULT NULL,
  `行业编码` varchar(2) NOT NULL DEFAULT '',
  `企业属性` enum('国资委央企','地方国企','外资','民企','非国资委央企') DEFAULT NULL,
  `地域` varchar(4) NOT NULL,
  `板块` varchar(4) NOT NULL DEFAULT '暂不考虑',
  `高管薪酬总和` double DEFAULT NULL,
  `高管人数` double DEFAULT NULL,
  `领薪高管人数` double DEFAULT NULL,
  `高管人均薪酬` double DEFAULT NULL,
  `独董薪酬总和` double DEFAULT NULL,
  `独董人数` double DEFAULT NULL,
  `领薪独董人数` double DEFAULT NULL,
  `独董人均薪酬` double DEFAULT NULL,
  `员工薪酬总和` double DEFAULT NULL,
  `员工人数` double DEFAULT NULL,
  `员工人均薪酬` double DEFAULT NULL,
  `董监薪酬总和` double DEFAULT NULL,
  `董监人数` double DEFAULT NULL,
  `领薪董监人数` double DEFAULT NULL,
  `董监人均薪酬` double DEFAULT NULL,
  `高管持股总数` double DEFAULT NULL,
  `持股高管人数` double DEFAULT NULL,
  `高管人均持股数量` double DEFAULT NULL,
  `高管人均持股市值` double DEFAULT NULL,
  `高管持股总数占比` double DEFAULT NULL,
  `董监持股总数` double DEFAULT NULL,
  `持股董监人数` double DEFAULT NULL,
  `董监人均持股数量` double DEFAULT NULL,
  `董监人均持股市值` double DEFAULT NULL,
  `董监持股总数占比` double DEFAULT NULL,
  `总股本` double DEFAULT NULL,
  `流通股本` double DEFAULT NULL,
  `总资产` double DEFAULT NULL,
  `净资产` double DEFAULT NULL,
  `营业总收入` double DEFAULT NULL,
  `营业收入` double DEFAULT NULL,
  `主营业务收入` double DEFAULT NULL,
  `净利润` double DEFAULT NULL,
  `利润总额` double DEFAULT NULL,
  `息税前利润` double DEFAULT NULL,
  `支付各项税费` double DEFAULT NULL,
  `固定资产折旧` double DEFAULT NULL,
  `固定资产累计折旧` double DEFAULT NULL,
  `应付职工薪酬` double DEFAULT NULL,
  `每股收益` double DEFAULT NULL,
  `净资产收益率` double DEFAULT NULL,
  `加权净资产收益率` double DEFAULT NULL,
  `高管薪酬占比` double DEFAULT NULL,
  `年份` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`股票代码`,`年份`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Salary`
--

DROP TABLE IF EXISTS `RZ_Salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Salary` (
  `股票代码` char(9) NOT NULL DEFAULT '',
  `高管姓名` varchar(64) NOT NULL DEFAULT '',
  `职位` varchar(64) DEFAULT NULL,
  `职位秩序` int(4) NOT NULL DEFAULT '0',
  `职位内容` varchar(4) NOT NULL DEFAULT '',
  `年薪` double DEFAULT NULL,
  `兼职` enum('True','False') DEFAULT NULL,
  `年份` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`股票代码`,`高管姓名`,`职位秩序`,`年份`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Stock`
--

DROP TABLE IF EXISTS `RZ_Stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Stock` (
  `股票代码` char(9) NOT NULL DEFAULT '',
  `高管姓名` varchar(64) NOT NULL DEFAULT '',
  `职位` varchar(64) DEFAULT NULL,
  `职位秩序` int(4) NOT NULL DEFAULT '0',
  `职位内容` varchar(4) NOT NULL DEFAULT '',
  `持股数量` double DEFAULT NULL,
  `持股市值` double DEFAULT NULL,
  `持股比例` double DEFAULT NULL,
  `年份` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`股票代码`,`高管姓名`,`职位秩序`,`年份`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RZ_Job_All`
--

DROP TABLE IF EXISTS `RZ_Job_All`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RZ_Job_All` (
  `职位` varchar(64) NOT NULL DEFAULT '',
  `出现次数` bigint(21) NOT NULL DEFAULT '0',
  `职位秩序` int(4) NOT NULL DEFAULT '0',
  `职位内容` varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`职位`)
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

-- Dump completed on 2014-04-15 16:10:13
