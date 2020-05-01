## 先决条件

-   R
    -   前往官方网站: <https://cran.r-project.org/bin/macosx>, 下载最新版 pkg, 并按提示完成安装.
    -   在终端输入 R, 进入 R 交互式环境, 并安装如下依赖包 `install.packages(c("knitr", "RMySQL", "xtable", "plyr", "RSQLite", "sqldf"))`
-   Python3
    -   安装依赖包 `pip3 install numpy pandas pymysql openpyxl`
    -   配置 MySQL 的 `sql_mode`, 取消 `ONLY_FULL_GROUP_BY`, 编辑 `my.cnf`, 然后重启

## 荣正项目操作指南

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

从 Excel 导入数据, 不走 xlsx2csv, 采用 import_xlsx.py, 尝试, 尚未完成

前两章统计结果用 `python3 report.py`, 输出结果在 `/tmp` 下, 不用 word 形式了


ln -s htex.plain htex

chap01.Rnw
num.company=2808
num.rate=2743
this.year=2015
last.year=2014

chap13.Rnw
sql = "select '2015' as 年度,

董秘兼财务总监 样本数

SELECT count(DISTINCT 股票代码) FROM (
    select 股票代码 from RZ_Salary_All a group by a.股票代码,高管姓名 having sum(职位秩序)=24
) a;

## 操作步骤 2020

1. 导入上一年的数据
1. 执行 `python3 import_xlsx.py`
5. 执行 `./main.sh 1`
    2. 执行 `source export_joball.sql`
    2. 执行 `source routines.sql`
    3. 执行 `call sp_MergeData(2019);`
    3. 执行 `call sp_SplitData(2019);`
    4. 执行 `source sp_main.sql`
5. 执行 `python3 report.py`
