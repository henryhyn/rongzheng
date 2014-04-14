/* 提取分析数据 */

-- 高管的全部薪酬信息
DROP TABLE IF EXISTS `RZ_Salary_1`;
create table RZ_Salary_1
select 股票代码,高管姓名,a.职位,职位秩序,职位内容,(10000*年薪) AS 年薪,兼职 
    from RZ_Salary_2012 a, RZ_Job_All b where a.职位=b.职位 group by 股票代码,高管姓名,职位秩序;

DROP TABLE IF EXISTS `RZ_Salary_11`;
create table RZ_Salary_11
select 股票代码,高管姓名,a.职位,职位秩序,职位内容,(10000*年薪) AS 年薪,兼职 
    from RZ_Salary_2011 a, RZ_Job_All b where a.职位=b.职位 group by 股票代码,高管姓名,职位秩序;
    
DROP TABLE IF EXISTS `RZ_Database_2012`;
CREATE TABLE `RZ_Database_2012` (
  `股票代码` char(9) NOT NULL DEFAULT '',
  `职位内容` varchar(4) NOT NULL DEFAULT '',
  `高管姓名` varchar(64) DEFAULT NULL,  
  `年薪` double DEFAULT NULL,
  `持股数量` double DEFAULT NULL,
  KEY `股票代码` (`股票代码`,`高管姓名`)
);
insert into RZ_Database_2012 (股票代码,高管姓名,职位内容,年薪)
select 股票代码,高管姓名,职位内容,年薪 from RZ_Salary_1
order by 股票代码,职位内容,年薪 desc;
    
-- 高管按职位划分, 董事长, 董事长兼总经理, 总经理
DROP TABLE IF EXISTS `RZ_Salary_3`;
create table RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=1;
insert into RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=2;

DROP TABLE IF EXISTS `RZ_Salary_4`;
create table RZ_Salary_4 
select 股票代码,职位秩序,max(年薪) as 年薪 from RZ_Salary_3 group by 股票代码,职位秩序;

alter table RZ_Salary_3 add index(股票代码,职位秩序,年薪);
DROP TABLE IF EXISTS `RZ_Salary_5`;
create table RZ_Salary_5
select a.* from RZ_Salary_3 a, RZ_Salary_4 b 
    where a.股票代码=b.股票代码 and a.职位秩序=b.职位秩序 and a.年薪=b.年薪
    group by a.股票代码,a.职位秩序,a.年薪;

DROP TABLE IF EXISTS `RZ_Salary_2`;
create table RZ_Salary_2
select 股票代码,高管姓名,sum(职位秩序) as 职位秩序,年薪 from RZ_Salary_5 group by 股票代码,高管姓名;

-- 每家公司, 提取最高年薪
DROP TABLE IF EXISTS `RZ_Salary_6`;
create table RZ_Salary_6
select 股票代码,max(年薪) as 年薪 from RZ_Salary_1 group by 股票代码;

alter table RZ_Salary_1 add index(股票代码,年薪);
DROP TABLE IF EXISTS `RZ_Salary_7`;
create table RZ_Salary_7
select a.* from RZ_Salary_1 a, RZ_Salary_6 b 
    where a.股票代码=b.股票代码 and a.年薪=b.年薪
    group by a.股票代码,a.年薪;

-- 年薪变化排行榜
DROP TABLE IF EXISTS `RZ_Salary_12`;
create table RZ_Salary_12    
select a.股票代码,a.高管姓名,a.职位,a.职位秩序,a.年薪 as 今年年薪,b.年薪 as 去年年薪,(a.年薪-b.年薪) as 升值,100*(a.年薪-b.年薪)/b.年薪 as 升幅
    from RZ_Salary_1 a, RZ_Salary_11 b where a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名 and a.年薪>0 and b.年薪>0
    group by a.股票代码,a.高管姓名;
    
DROP TABLE IF EXISTS `RZ_Salary_Increase`;
create table RZ_Salary_Increase
select a.高管姓名,a.职位,a.职位秩序,a.今年年薪,a.去年年薪,a.升值,a.升幅, b.*
    from RZ_Salary_12 a,RZ_Company_All b
    where a.股票代码=b.股票代码 and a.职位秩序 not in (32,64);

/*    
select substr(股票代码,1,6) as 股票代码,股票简称,地域,行业编码,今年年薪,去年年薪,升值,升幅,职位,高管姓名 
    into outfile '/tmp/incs.csv' 
    from RZ_Salary_Increase
    order by 升值 desc;*/
    
-- 每家公司, 每位高管, 按职位提取记录
DROP TABLE IF EXISTS `RZ_Salary_3`;
create table RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=1;
alter table RZ_Salary_3 add index(股票代码,高管姓名);
delete r from RZ_Salary_1 r, RZ_Salary_3 s where r.股票代码=s.股票代码 and r.高管姓名=s.高管姓名;

alter table RZ_Salary_3 disable keys;
insert into RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=2;
alter table RZ_Salary_3 enable keys;
delete r from RZ_Salary_1 r, RZ_Salary_3 s where r.股票代码=s.股票代码 and r.高管姓名=s.高管姓名;

alter table RZ_Salary_3 disable keys;
insert into RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=4;
insert into RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=8;
insert into RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=16;
alter table RZ_Salary_3 enable keys;
delete r from RZ_Salary_1 r, RZ_Salary_3 s where r.股票代码=s.股票代码 and r.高管姓名=s.高管姓名;

insert into RZ_Salary_3
select * from RZ_Salary_1 where 职位秩序=32;

-- 每家公司, 每个职位, 提取最高年薪
DROP TABLE IF EXISTS `RZ_Salary_4`;
create table RZ_Salary_4 
select 股票代码,职位秩序,max(年薪) as 年薪 from RZ_Salary_3 group by 股票代码,职位秩序;

alter table RZ_Salary_3 add index(股票代码,职位秩序,年薪);
DROP TABLE IF EXISTS `RZ_Salary_5`;
create table RZ_Salary_5
select a.* from RZ_Salary_3 a, RZ_Salary_4 b 
    where a.股票代码=b.股票代码 and a.职位秩序=b.职位秩序 and a.年薪=b.年薪
    group by a.股票代码,a.职位秩序,a.年薪;

-- 高管的全部持股信息
DROP TABLE IF EXISTS `RZ_Stock_1`;
create table RZ_Stock_1
select 股票代码,高管姓名,a.职位,职位秩序,职位内容,(10000*持股数量) AS 持股数量,(10000*持股市值) AS 持股市值,(1*持股比例) AS 持股比例 
    from RZ_Stock_2012 a, RZ_Job_All b where a.职位=b.职位 group by 股票代码,高管姓名,职位秩序;
    
DROP TABLE IF EXISTS `RZ_Stock_11`;
create table RZ_Stock_11
select 股票代码,高管姓名,a.职位,职位秩序,职位内容,(10000*持股数量) AS 持股数量,(10000*持股市值) AS 持股市值,(1*持股比例) AS 持股比例 
    from RZ_Stock_2011 a, RZ_Job_All b where a.职位=b.职位 group by 股票代码,高管姓名,职位秩序;
    
update RZ_Database_2012 a, RZ_Stock_1 b set a.持股数量=b.持股数量 where a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名;

-- 每家公司, 每位高管, 按职位提取记录
DROP TABLE IF EXISTS `RZ_Stock_3`;
create table RZ_Stock_3
select * from RZ_Stock_1 where 职位秩序=1;
alter table RZ_Stock_3 add index(股票代码,高管姓名);
delete r from RZ_Stock_1 r, RZ_Stock_3 s where r.股票代码=s.股票代码 and r.高管姓名=s.高管姓名;

alter table RZ_Stock_3 disable keys;
insert into RZ_Stock_3
select * from RZ_Stock_1 where 职位秩序=2;
alter table RZ_Stock_3 enable keys;
delete r from RZ_Stock_1 r, RZ_Stock_3 s where r.股票代码=s.股票代码 and r.高管姓名=s.高管姓名;

alter table RZ_Stock_3 disable keys;
insert into RZ_Stock_3
select * from RZ_Stock_1 where 职位秩序=4;
insert into RZ_Stock_3
select * from RZ_Stock_1 where 职位秩序=8;
insert into RZ_Stock_3
select * from RZ_Stock_1 where 职位秩序=16;
alter table RZ_Stock_3 enable keys;
delete r from RZ_Stock_1 r, RZ_Stock_3 s where r.股票代码=s.股票代码 and r.高管姓名=s.高管姓名;

insert into RZ_Stock_3
select * from RZ_Stock_1 where 职位秩序=32;
    
-- 每家公司, 每个职位, 提取最高持股
DROP TABLE IF EXISTS `RZ_Stock_4`;
create table RZ_Stock_4 
select 股票代码,职位秩序,max(持股市值) as 持股市值 from RZ_Stock_3 group by 股票代码,职位秩序;

alter table RZ_Stock_3 add index(股票代码,职位秩序,持股市值);
DROP TABLE IF EXISTS `RZ_Stock_5`;
create table RZ_Stock_5
select a.* from RZ_Stock_3 a, RZ_Stock_4 b 
    where a.股票代码=b.股票代码 and a.职位秩序=b.职位秩序 and a.持股市值=b.持股市值
    group by a.股票代码,a.职位秩序,a.持股市值; 
    
-- 派生平均值分析表
DROP TABLE IF EXISTS `RZ_Company_All`;
CREATE TABLE `RZ_Company_All` (
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
  PRIMARY KEY (`股票代码`)
);
insert into RZ_Company_All
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
    (100*高管薪酬总和/员工薪酬总和) as 高管薪酬占比
    from RZ_Company_Salary_2012 a, RZ_Company_Stock_2012 b, RZ_Company_Size_2012 r, RZ_Area c, RZ_HangYe d
    where a.股票代码=b.股票代码 and b.地域全称=c.地域全称 and b.行业分类=d.行业名称 and b.股票代码=r.股票代码;
/*是按照股票代码区分的，主板是600、000打头的，中小板是002打头的、创业板是300打头的。*/
UPDATE RZ_Company_All SET 板块 = "主板"   WHERE (股票代码 LIKE '600%') OR (股票代码 LIKE '000%');
UPDATE RZ_Company_All SET 板块 = "中小板" WHERE (股票代码 LIKE '002%');
UPDATE RZ_Company_All SET 板块 = "创业板" WHERE (股票代码 LIKE '300%');

DROP TABLE IF EXISTS `RZ_Salary_Top`;
create table RZ_Salary_Top
select a.高管姓名,a.职位,a.职位秩序,a.职位内容,a.年薪,a.兼职, b.*
    from RZ_Salary_7 a,RZ_Company_All b
    where a.股票代码=b.股票代码 and a.年薪>0;
DROP TABLE IF EXISTS `RZ_Salary_One`;
create table RZ_Salary_One
select a.高管姓名,a.职位,a.职位秩序,a.职位内容,a.年薪,a.兼职, b.*
    from RZ_Salary_5 a,RZ_Company_All b
    where a.股票代码=b.股票代码 and a.年薪>0;
DROP TABLE IF EXISTS `RZ_Stock_One`;
create table RZ_Stock_One
select a.高管姓名,a.职位,a.职位秩序,a.职位内容,a.持股数量,a.持股市值,a.持股比例, b.*
    from RZ_Stock_5 a,RZ_Company_All b
    where a.股票代码=b.股票代码 and a.持股市值>0;
    
DROP TABLE IF EXISTS `RZ_Stock_Group`;
create table RZ_Stock_Group
select a.* from RZ_Stock_One a,
    (select 股票代码,count(*) as cnt from RZ_Stock_One where 职位秩序<=16 group by 股票代码 having cnt=5) b 
    where a.股票代码=b.股票代码 and 职位秩序<=16;
    
DROP TABLE IF EXISTS `RZ_Salary_All`;
create table RZ_Salary_All
select a.高管姓名,a.职位,a.职位秩序,a.职位内容,a.年薪,a.兼职, b.*
    from RZ_Salary_3 a,RZ_Company_All b
    where a.股票代码=b.股票代码 and a.年薪>0;
DROP TABLE IF EXISTS `RZ_Stock_All`;
create table RZ_Stock_All
select a.高管姓名,a.职位,a.职位秩序,a.职位内容,a.持股数量,a.持股市值,a.持股比例, b.*
    from RZ_Stock_3 a,RZ_Company_All b
    where a.股票代码=b.股票代码 and a.持股市值>0;
    
DROP TABLE IF EXISTS `RZ_Salary_8`;
create table RZ_Salary_8
select * from RZ_Salary_All where 职位秩序=32 group by 股票代码,高管姓名;

DROP TABLE IF EXISTS `RZ_Salary_9`;
create table RZ_Salary_9
select 股票代码,股票简称,地域,行业编码,年薪,职位,a.高管姓名,合计年薪 from RZ_Salary_8 a,
    (select 高管姓名,sum(年薪) as 合计年薪 from RZ_Salary_8 group by 高管姓名 order by 合计年薪 desc limit 30) b
    where a.高管姓名=b.高管姓名 order by 合计年薪 desc;
    


