-- MySQL dump 10.13  Distrib 5.7.19, for osx10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: test
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Table structure for table `rz_company_hangye`
--

DROP TABLE IF EXISTS `rz_company_hangye`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rz_company_hangye` (
  `证券代码` varchar(16) NOT NULL,
  `证券简称` varchar(16) DEFAULT NULL,
  `上市日期` date DEFAULT NULL,
  `行业名称` varchar(32) DEFAULT NULL,
  `行业代码` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`证券代码`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rz_company_salary`
--

DROP TABLE IF EXISTS `rz_company_salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rz_company_salary` (
  `股票代码` varchar(16) NOT NULL,
  `证券简称` varchar(16) DEFAULT NULL,
  `高管薪酬总和` double DEFAULT NULL,
  `高管人数` double DEFAULT NULL,
  `高管薪酬均值` double DEFAULT NULL,
  `领薪高管人数` double DEFAULT NULL,
  `高管人均薪酬` double DEFAULT NULL,
  `独董薪酬总额` double DEFAULT NULL,
  `独董总人数` double DEFAULT NULL,
  `独立董事薪酬总和` double DEFAULT NULL,
  `独立董事薪酬均值` double DEFAULT NULL,
  `领薪独董人数` double DEFAULT NULL,
  `独董人均薪酬` double DEFAULT NULL,
  `员工薪酬` double DEFAULT NULL,
  `员工人数` double DEFAULT NULL,
  `员工人均薪酬` double DEFAULT NULL,
  `董监高管薪酬总和` double DEFAULT NULL,
  `董监高总人数` double DEFAULT NULL,
  `领薪董监高人数` double DEFAULT NULL,
  `董监高人均薪酬` double DEFAULT NULL,
  `总股本` double DEFAULT NULL,
  `流通股本` double DEFAULT NULL,
  `总资产` double DEFAULT NULL,
  `净资产` double DEFAULT NULL,
  `净资产收益率` double DEFAULT NULL,
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
  `行业` text,
  `企业属性` text,
  `地域` text,
  `规模系数` double DEFAULT NULL,
  PRIMARY KEY (`股票代码`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rz_company_size`
--

DROP TABLE IF EXISTS `rz_company_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rz_company_size` (
  `证券代码` varchar(16) NOT NULL,
  `证券简称` varchar(16) DEFAULT NULL,
  `首发上市日期` date DEFAULT NULL,
  `总股本` bigint(20) DEFAULT NULL,
  `收盘价` double DEFAULT NULL,
  `每股收益EPS-基本` double DEFAULT NULL,
  `每股收益EPS-扣除/期末股本摊薄` double DEFAULT NULL,
  `净资产收益率ROE(扣除/摊薄)` double DEFAULT NULL,
  `净资产收益率ROE(加权)` double DEFAULT NULL,
  `净资产收益率ROE(扣除/加权)` double DEFAULT NULL,
  PRIMARY KEY (`证券代码`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rz_company_stock`
--

DROP TABLE IF EXISTS `rz_company_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rz_company_stock` (
  `股票代码` varchar(16) NOT NULL,
  `证券简称` varchar(16) DEFAULT NULL,
  `高管持股总数` double DEFAULT NULL,
  `高管总人数` double DEFAULT NULL,
  `持股高管人数` double DEFAULT NULL,
  `高管人均持股数` double DEFAULT NULL,
  `高管人均持股市值` double DEFAULT NULL,
  `高管持股总数占比` double DEFAULT NULL,
  `董监高持股总数` double DEFAULT NULL,
  `董监高总人数` double DEFAULT NULL,
  `持股董监高人数` double DEFAULT NULL,
  `董监高人均持股数` double DEFAULT NULL,
  `董监高人均持股市值` double DEFAULT NULL,
  `董监高持股总数占比` double DEFAULT NULL,
  `总股本` double DEFAULT NULL,
  `流通股本` double DEFAULT NULL,
  `总资产` double DEFAULT NULL,
  `净资产` double DEFAULT NULL,
  `营业收入` double DEFAULT NULL,
  `净利润` double DEFAULT NULL,
  `利润总额` double DEFAULT NULL,
  `息税前利润` double DEFAULT NULL,
  `行业` text,
  `企业属性` text,
  `地域` text,
  PRIMARY KEY (`股票代码`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rz_salary`
--

DROP TABLE IF EXISTS `rz_salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rz_salary` (
  `股票代码` varchar(16) DEFAULT NULL,
  `证券简称` varchar(16) DEFAULT NULL,
  `高管姓名` text,
  `职务` text,
  `年薪` double DEFAULT NULL,
  `任职开始时间` date DEFAULT NULL,
  `任职截止时间` date DEFAULT NULL,
  `报告期` date DEFAULT NULL,
  `是否在其它单位领取报酬` text,
  `在其它单位领取报酬` double DEFAULT NULL,
  KEY `股票代码` (`股票代码`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rz_stock`
--

DROP TABLE IF EXISTS `rz_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rz_stock` (
  `股票代码` varchar(16) DEFAULT NULL,
  `证券简称` varchar(16) DEFAULT NULL,
  `高管姓名` text,
  `职务` text,
  `持股数量` double DEFAULT NULL,
  `持股市值` double DEFAULT NULL,
  `持股比例` double DEFAULT NULL,
  `报告期` bigint(20) DEFAULT NULL,
  KEY `股票代码` (`股票代码`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-02 20:27:29
