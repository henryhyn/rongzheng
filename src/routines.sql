-- MySQL dump 10.13  Distrib 5.7.13, for osx10.11 (x86_64)
--
-- Host: 127.0.0.1    Database: RongZheng
-- ------------------------------------------------------
-- Server version	5.7.13

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
-- Dumping routines for database 'RongZheng'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_MergeData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_MergeData`(IN `year` integer)
BEGIN

DELETE FROM RZ_Company WHERE 年份=year;
INSERT INTO RZ_Company
select a.股票代码,a.股票简称,d.行业名称,d.行业编码,a.企业属性,c.地域,"暂不考虑" as 板块,
    10000*a.高管薪酬总和,  1*a.高管人数,  1*a.领薪高管人数,  10000*a.高管人均薪酬,
    10000*a.独董薪酬总和,  1*a.独董人数,  1*a.领薪独董人数,  10000*a.独董人均薪酬,
    10000*a.员工薪酬总和,  1*a.员工人数,  10000*a.员工人均薪酬,
    10000*a.董监薪酬总和,  1*a.董监人数,  1*a.领薪董监人数,  10000*a.董监人均薪酬,
    10000*b.高管持股总数,  1*b.持股高管人数,  10000*b.高管人均持股数量,  10000*b.高管人均持股市值,  1*b.高管持股总数占比,
    10000*b.董监持股总数,  1*b.持股董监人数,  10000*b.董监人均持股数量,  10000*b.董监人均持股市值,  1*b.董监持股总数占比,
    10000*a.总股本,  10000*a.流通股本,  10000*a.总资产,  10000*a.净资产,  10000*a.营业总收入,  10000*a.营业收入,  10000*a.主营业务收入,
    10000*a.净利润,  10000*a.利润总额,  10000*a.息税前利润,  10000*a.支付各项税费,  10000*a.固定资产折旧,  10000*a.固定资产累计折旧,  10000*a.应付职工薪酬,
    (1*r.每股收益) as 每股收益,(1*r.净资产收益率) as 净资产收益率,(1*r.加权净资产收益率) as 加权净资产收益率,
    (100*高管薪酬总和/员工薪酬总和) as 高管薪酬占比,year
    from RZ_Company_Salary_0000 a, RZ_Company_Stock_0000 b, RZ_Company_Size_0000 r, RZ_Company_Genre_0000 g, RZ_Area c, RZ_HangYe d
    where a.股票代码=b.股票代码 and b.地域全称=c.地域全称 and g.行业名称=d.行业名称 and b.股票代码=r.股票代码 and b.股票代码=g.股票代码;

UPDATE RZ_Company SET 板块 = "主板"   WHERE (股票代码 LIKE '60%') OR (股票代码 LIKE '000%') OR (股票代码 LIKE '001%');
UPDATE RZ_Company SET 板块 = "中小板" WHERE (股票代码 LIKE '002%');
UPDATE RZ_Company SET 板块 = "创业板" WHERE (股票代码 LIKE '300%');

DELETE FROM RZ_Salary WHERE 年份=year;
INSERT INTO RZ_Salary
select 股票代码,高管姓名,a.职位,职位秩序,职位内容,(10000*年薪) AS 年薪,兼职,year
    from RZ_Salary_0000 a, RZ_Job_All b where a.职位=b.职位 group by 股票代码,高管姓名,职位秩序;

DELETE FROM RZ_Stock WHERE 年份=year;
INSERT INTO RZ_Stock
select 股票代码,高管姓名,a.职位,职位秩序,职位内容,(10000*持股数量) AS 持股数量,(10000*持股市值) AS 持股市值,(1*持股比例) AS 持股比例,year
    from RZ_Stock_0000 a, RZ_Job_All b where a.职位=b.职位 group by 股票代码,高管姓名,职位秩序;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SplitData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_SplitData`(IN `year` integer)
BEGIN




DROP TABLE IF EXISTS `RZ_Salary_1`;
CREATE TABLE RZ_Salary_1
SELECT * FROM RZ_Salary WHERE 年份=year;
ALTER TABLE RZ_Salary_1 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);

DROP TABLE IF EXISTS `RZ_Salary_11`;
CREATE TABLE RZ_Salary_11
SELECT * FROM RZ_Salary WHERE 年份=year-1;
ALTER TABLE RZ_Salary_11 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);


DROP TABLE IF EXISTS `RZ_Stock_1`;
CREATE TABLE RZ_Stock_1
SELECT * FROM RZ_Stock WHERE 年份=year;
ALTER TABLE RZ_Stock_1 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);

DROP TABLE IF EXISTS `RZ_Stock_11`;
CREATE TABLE RZ_Stock_11
SELECT * FROM RZ_Stock WHERE 年份=year-1;
ALTER TABLE RZ_Stock_11 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);


DROP TABLE IF EXISTS `RZ_Company_All`;
CREATE TABLE RZ_Company_All
SELECT * FROM RZ_Company WHERE 年份=year;
ALTER TABLE RZ_Company_All ADD INDEX (`股票代码`);

DROP TABLE IF EXISTS `RZ_Database_2012`;
CREATE TABLE RZ_Database_2012
SELECT 股票代码,高管姓名,职位内容,年薪,0 AS 持股数量 FROM RZ_Salary_1
ORDER BY 股票代码,职位内容,年薪 DESC;
ALTER TABLE RZ_Database_2012 ADD INDEX (`股票代码`,`高管姓名`);
UPDATE RZ_Database_2012 a, RZ_Stock_1 b SET a.持股数量=b.持股数量 WHERE a.股票代码=b.股票代码 AND a.高管姓名=b.高管姓名;

delete a from RZ_Salary_1 a left join RZ_Company_All b on a.股票代码=b.股票代码 where a.股票代码 is not null and b.股票代码 is null;
delete a from RZ_Stock_1 a left join RZ_Company_All b on a.股票代码=b.股票代码 where a.股票代码 is not null and b.股票代码 is null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-14 14:52:01
