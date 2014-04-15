DROP TABLE IF EXISTS `RZ_Rank_Top`;
create table RZ_Rank_Top
select 股票代码,股票简称,地域,行业编码,年薪,职位,高管姓名
	from RZ_Salary_Top where 股票代码 in (select 股票代码 from RZ_Company_All where 企业属性="国资委央企") order by 年薪 desc limit 20;

insert into RZ_Rank_Top
select 股票代码,股票简称,地域,行业编码,年薪,职位,高管姓名
    from RZ_Salary_Top where 股票代码 in (select 股票代码 from RZ_Company_All where 企业属性!="国资委央企") order by 年薪 desc limit 20;

insert into RZ_Rank_Top
select * from (
    select 股票代码,股票简称,地域,行业编码,年薪,职位,高管姓名
    from RZ_Salary_Top where 股票代码 in (select 股票代码 from RZ_Company_All where 企业属性!="国资委央企") order by 年薪 limit 10) a
order by 年薪 desc;




DROP TABLE IF EXISTS `RZ_Rank_Salary`;
create table RZ_Rank_Salary
select 股票代码,股票简称,地域,行业编码,年薪,职位,高管姓名
	from RZ_Salary_All limit 0;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.年薪,a.职位,a.高管姓名
    from RZ_Salary_All a left join RZ_Rank_Salary b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=1;
create table RZ_Rank_Temp_2
select 股票代码,max(年薪) as 年薪 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Salary
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.年薪=b.年薪
    group by a.股票代码,a.年薪
    order by a.年薪 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.年薪,a.职位,a.高管姓名
    from RZ_Salary_All a left join RZ_Rank_Salary b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=2;
create table RZ_Rank_Temp_2
select 股票代码,max(年薪) as 年薪 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Salary
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.年薪=b.年薪
    group by a.股票代码,a.年薪
    order by a.年薪 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.年薪,a.职位,a.高管姓名
    from RZ_Salary_All a left join RZ_Rank_Salary b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=4;
create table RZ_Rank_Temp_2
select 股票代码,max(年薪) as 年薪 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Salary
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.年薪=b.年薪
    group by a.股票代码,a.年薪
    order by a.年薪 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.年薪,a.职位,a.高管姓名
    from RZ_Salary_All a left join RZ_Rank_Salary b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=8;
create table RZ_Rank_Temp_2
select 股票代码,max(年薪) as 年薪 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Salary
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.年薪=b.年薪
    group by a.股票代码,a.年薪
    order by a.年薪 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.年薪,a.职位,a.高管姓名
    from RZ_Salary_All a left join RZ_Rank_Salary b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=16;
create table RZ_Rank_Temp_2
select 股票代码,max(年薪) as 年薪 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Salary
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.年薪=b.年薪
    group by a.股票代码,a.年薪
    order by a.年薪 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.年薪,a.职位,a.高管姓名
    from RZ_Salary_All a left join RZ_Rank_Salary b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=32;
create table RZ_Rank_Temp_2
select 股票代码,max(年薪) as 年薪 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Salary
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.年薪=b.年薪
    group by a.股票代码,a.年薪
    order by a.年薪 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;








DROP TABLE IF EXISTS `RZ_Rank_Stock`;
create table RZ_Rank_Stock
select 股票代码,股票简称,地域,行业编码,持股数量,持股市值,职位,高管姓名
	from RZ_Stock_All limit 0;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.持股数量,a.持股市值,a.职位,a.高管姓名
    from RZ_Stock_All a left join RZ_Rank_Stock b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=1;
create table RZ_Rank_Temp_2
select 股票代码,max(持股市值) as 持股市值 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Stock
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.持股市值=b.持股市值
    group by a.股票代码,a.持股市值
    order by a.持股市值 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.持股数量,a.持股市值,a.职位,a.高管姓名
    from RZ_Stock_All a left join RZ_Rank_Stock b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=2;
create table RZ_Rank_Temp_2
select 股票代码,max(持股市值) as 持股市值 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Stock
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.持股市值=b.持股市值
    group by a.股票代码,a.持股市值
    order by a.持股市值 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.持股数量,a.持股市值,a.职位,a.高管姓名
    from RZ_Stock_All a left join RZ_Rank_Stock b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=4;
create table RZ_Rank_Temp_2
select 股票代码,max(持股市值) as 持股市值 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Stock
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.持股市值=b.持股市值
    group by a.股票代码,a.持股市值
    order by a.持股市值 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.持股数量,a.持股市值,a.职位,a.高管姓名
    from RZ_Stock_All a left join RZ_Rank_Stock b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=8;
create table RZ_Rank_Temp_2
select 股票代码,max(持股市值) as 持股市值 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Stock
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.持股市值=b.持股市值
    group by a.股票代码,a.持股市值
    order by a.持股市值 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.持股数量,a.持股市值,a.职位,a.高管姓名
    from RZ_Stock_All a left join RZ_Rank_Stock b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=16;
create table RZ_Rank_Temp_2
select 股票代码,max(持股市值) as 持股市值 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Stock
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.持股市值=b.持股市值
    group by a.股票代码,a.持股市值
    order by a.持股市值 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;

create table RZ_Rank_Temp_1
select a.股票代码,a.股票简称,a.地域,a.行业编码,a.持股数量,a.持股市值,a.职位,a.高管姓名
    from RZ_Stock_All a left join RZ_Rank_Stock b on a.股票代码=b.股票代码 and a.高管姓名=b.高管姓名
    where b.股票代码 is null and 职位秩序=32;
create table RZ_Rank_Temp_2
select 股票代码,max(持股市值) as 持股市值 from RZ_Rank_Temp_1 group by 股票代码;
insert into RZ_Rank_Stock
select a.* from RZ_Rank_Temp_1 a, RZ_Rank_Temp_2 b
    where a.股票代码=b.股票代码 and a.持股市值=b.持股市值
    group by a.股票代码,a.持股市值
    order by a.持股市值 desc limit 20;
DROP TABLE IF EXISTS `RZ_Rank_Temp_2`;
DROP TABLE IF EXISTS `RZ_Rank_Temp_1`;
