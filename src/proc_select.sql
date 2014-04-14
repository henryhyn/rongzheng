/* 提取分析数据 */

-- 高管的全部薪酬信息
DROP TABLE IF EXISTS `RZ_Salary_1`;
CREATE TABLE RZ_Salary_1
SELECT * FROM RZ_Salary WHERE 年份=2012;
ALTER TABLE RZ_Salary_1 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);

DROP TABLE IF EXISTS `RZ_Salary_11`;
CREATE TABLE RZ_Salary_11
SELECT * FROM RZ_Salary WHERE 年份=2011;
ALTER TABLE RZ_Salary_11 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);

-- 高管的全部持股信息
DROP TABLE IF EXISTS `RZ_Stock_1`;
CREATE TABLE RZ_Stock_1
SELECT * FROM RZ_Stock WHERE 年份=2012;
ALTER TABLE RZ_Stock_1 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);

DROP TABLE IF EXISTS `RZ_Stock_11`;
CREATE TABLE RZ_Stock_11
SELECT * FROM RZ_Stock WHERE 年份=2011;
ALTER TABLE RZ_Stock_11 ADD INDEX (`股票代码`,`高管姓名`,`职位秩序`);

-- 派生平均值分析表
DROP TABLE IF EXISTS `RZ_Company_All`;
CREATE TABLE RZ_Company_All
SELECT * FROM RZ_Company WHERE 年份=2012;
ALTER TABLE RZ_Company_All ADD INDEX (`股票代码`);

DROP TABLE IF EXISTS `RZ_Database_2012`;
CREATE TABLE RZ_Database_2012
SELECT 股票代码,高管姓名,职位内容,年薪,年薪 AS 持股数量 FROM RZ_Salary_1
ORDER BY 股票代码,职位内容,年薪 DESC;
ALTER TABLE RZ_Database_2012 ADD INDEX (`股票代码`,`高管姓名`);
UPDATE RZ_Database_2012 a, RZ_Stock_1 b SET a.持股数量=b.持股数量 WHERE a.股票代码=b.股票代码 AND a.高管姓名=b.高管姓名;

/* 数 * 据 * 源 * 准 * 备 * 就 * 绪 */

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



