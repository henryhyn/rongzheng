荣正项目操作指南

-   提取如下数据
     1  总表1-基本信息-持股.xlsx
     2  总表1-基本信息-薪酬.xlsx
     3  总表1-基本信息-行业.xlsx
     4  总表1-基本信息-规模.xlsx
     5  总表2-薪酬明细.xlsx
     6  总表3-持股明细.xlsx
-   导入上一年的备份数据
-   执行导入 至 导出职位数据部分
-   确认职位划分
-   如果编辑过文件, 就需要执行 delete 语句, delete from RZ_Company_Genre_0000 limit 2;
-   执行职位导入到结束


ln -s htex.plain htex

chap01.Rnw
num.company=2808
num.rate=2743
this.year=2015
last.year=2014

chap13.Rnw
sql = "select '2015' as 年度,