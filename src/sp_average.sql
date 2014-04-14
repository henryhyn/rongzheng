DROP TABLE IF EXISTS `RZ_Salary_Stock`;
CREATE TABLE `RZ_Salary_Stock` (
  `职位内容` varchar(32) DEFAULT NULL,
  `本年平均值` double DEFAULT NULL,
  `样本数` bigint(21) NOT NULL DEFAULT '0'
);
insert into RZ_Salary_Stock
select '最高年薪',avg(年薪),count(*) from RZ_Salary_Top;

insert into RZ_Salary_Stock
select ELT(职位秩序,'董事长不兼总经理','总经理','董事长兼总经理'),avg(年薪),count(*)
    from RZ_Salary_2 where 年薪>0 and 职位秩序<>2 group by 职位秩序 order by 职位秩序 desc;

insert into RZ_Salary_Stock
select concat(职位内容,"年薪"),avg(年薪),count(*)
    from RZ_Salary_One group by 职位内容,职位秩序 order by 职位秩序;

insert into RZ_Salary_Stock
select concat(职位内容,"持股市值"),avg(持股市值),count(*)
    from RZ_Stock_One group by 职位内容,职位秩序 order by 职位秩序;
    

