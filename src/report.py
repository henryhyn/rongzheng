# encoding=utf-8
import pymysql
import numpy as np
import pandas as pd


def print_info(title, sql):
    print('==> %s %s' % (title, sql))


def export_data(sql):
    db = pymysql.connect(host='localhost', user='root', passwd='mysql', db='rongzheng', use_unicode=True,
                         charset='utf8')
    data = pd.read_sql(sql, con=db)
    data.index = pd.Series(data=range(1, len(data) + 1), name='排名')
    db.close()
    return data


def write_data(title, sql):
    print_info(title, sql)
    data = export_data(sql)
    data.to_excel(writer, sheet_name=title)


this_year = 2018
num_company = 3566
# 计算高管薪酬占比平均值的样本数, 可以根据结果求和反推
num_rate = 3536
sql = 'select 职位内容,职位秩序 from RZ_Job where 职位秩序<=32'
iterator = export_data(sql)
sql = 'select 行业名称,行业编码 from RZ_HangYe'
hangye = export_data(sql)

writer = pd.ExcelWriter(r'/tmp/a.xlsx')

# 有效样本数
## 年薪有效样本数
title = '本项研究之年薪有效样本数(总样本数{})'.format(num_company)
sql = 'select * from RZ_Valid_Case_Salary'
print_info(title, sql)
data = export_data(sql)
data_salary, data_index = data, data.pop('类别')
data_salary.index = data_index
data_salary.loc['未披露'] = num_company - data_salary.sum()
data_salary.to_excel(writer, sheet_name=title)

## 持股有效样本数
title = '本项研究之持股有效样本数(总样本数{})'.format(num_company)
sql = 'select * from RZ_Valid_Case_Stock'
print_info(title, sql)
data = export_data(sql)
data_stock, data_index = data, data.pop('类别')
data_stock.index = data_index
data_stock.loc['未披露'] = num_company - data_stock.sum()
data_stock.to_excel(writer, sheet_name=title)

# 最值分析
## 高管年薪排行前 20 位
title = '{}年国资委央企最高年薪排行前20位(有效样本{}家)'.format(this_year, data_salary['最高年薪']['有效样本'])
sql = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,年薪 AS `年薪(元)`,职位,高管姓名 AS 姓名 from RZ_Rank_Top limit 30'
write_data(title, sql)

title = '{}年最高年薪排行前20位(有效样本{}家)'.format(this_year, data_salary['最高年薪']['有效样本'])
sql = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,年薪 AS `年薪(元)`,职位,高管姓名 AS 姓名 from RZ_Rank_Top limit 30,30'
write_data(title, sql)

title = '{}年最高年薪排行后10位(有效样本{}家)'.format(this_year, data_salary['最高年薪']['有效样本'])
sql = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,年薪 AS `年薪(元)`,职位,高管姓名 AS 姓名 from RZ_Rank_Top limit 60,15'
write_data(title, sql)

for i in range(1, 7):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '{}年{}年薪排行前20位(有效样本{}家)'.format(this_year, 职位内容, data_salary[职位内容]['有效样本'])
    template = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,高管姓名 AS {},年薪 AS `年薪(元)` from RZ_Rank_Salary where 职位秩序={}'
    sql = template.format(职位内容, 职位秩序)
    write_data(title, sql)

## 高管持股市值排行前 20 位
for i in range(1, 6):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '{}年{}持股市值排行前20位(有效样本{}家)'.format(this_year, 职位内容, data_stock[职位内容]['有效样本'])
    template = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,高管姓名 AS {},持股数量 AS `年末持股数量(股)`,持股市值 AS `年末持股市值(元)` from RZ_Rank_Stock where 职位秩序={}'
    sql = template.format(职位内容, 职位秩序)
    write_data(title, sql)

## 最有价值独立董事排行前 20 位
title = '{}年最有价值独立董事年薪排行前20位(有效样本{})'.format(this_year, data_salary['独立董事']['有效样本'])
sql = 'select 高管姓名,股票简称,年薪 AS `年薪(元)`,合计年薪 AS `合计年薪(元)` from RZ_Salary_9 limit 200'
write_data(title, sql)

## 年薪最大升幅排行榜前 20 位
for i in [1, 2, 4]:
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '{}年{}年薪最大升幅排行前20位(有效样本{}家)'.format(this_year, 职位内容, data_salary[职位内容]['有效样本'])
    template = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,今年年薪 AS `今年年薪(元)`,去年年薪 AS `去年年薪(元)`,升幅 AS `升幅(%)`,高管姓名 AS {} from RZ_Salary_Increase where 职位秩序={} order by 升幅 desc limit 200'
    sql = template.format(职位内容, 职位秩序)
    write_data(title, sql)

## 年薪最大升值排行榜前 20 位
for i in [1, 2, 4]:
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '{}年{}年薪最大升值排行前20位(有效样本{}家)'.format(this_year, 职位内容, data_salary[职位内容]['有效样本'])
    template = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,今年年薪 AS `今年年薪(元)`,去年年薪 AS `去年年薪(元)`,升值 AS `升值(元)`,高管姓名 AS {} from RZ_Salary_Increase where 职位秩序={} order by 升值 desc limit 120'
    sql = template.format(职位内容, 职位秩序)
    write_data(title, sql)

## 年薪最大降幅排行榜前 20 位
for i in [1, 2, 4]:
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '{}年{}年薪最大降幅排行前20位(有效样本{}家)'.format(this_year, 职位内容, data_salary[职位内容]['有效样本'])
    template = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,今年年薪 AS `今年年薪(元)`,去年年薪 AS `去年年薪(元)`,升幅 AS `降幅(%)`,高管姓名 AS {} from RZ_Salary_Increase where 职位秩序={} order by 升幅 limit 120'
    sql = template.format(职位内容, 职位秩序)
    write_data(title, sql)

## 年薪最大降值排行榜前 20 位
for i in [1, 2, 4]:
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '{}年{}年薪最大降值排行前20位(有效样本{}家)'.format(this_year, 职位内容, data_salary[职位内容]['有效样本'])
    template = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,今年年薪 AS `今年年薪(元)`,去年年薪 AS `去年年薪(元)`,升值 AS `降值(元)`,高管姓名 AS {} from RZ_Salary_Increase where 职位秩序={} order by 升值 limit 120'
    sql = template.format(职位内容, 职位秩序)
    write_data(title, sql)

## 身兼多职高管年薪排行前 20 位
title = '{}年董秘兼财务总监年薪排行前20位'.format(this_year)
sql = 'select substr(股票代码,1,6) AS 股票代码,股票简称,地域,行业编码,高管姓名,年薪 from RZ_Salary_All a group by a.股票代码,高管姓名 having sum(职位秩序)=24 order by 年薪 desc limit 35'
write_data(title, sql)

# 平均值分析
title = '上市公司高管薪酬及持股市值均值(本年度总样本数{}家)'.format(num_company)
template = 'select 职位内容 AS 类别, round(本年平均值) AS 本年平均值, 样本数 AS 已披露样本数, {}-样本数 AS 未披露样本数 from RZ_Salary_Stock'
sql = template.format(num_company)
print_info(title, sql)
data = export_data(sql)
data_avg, data_index = data, data.pop('类别')
data_avg.index = data_index
data_avg.to_excel(writer, sheet_name=title)

## 分行业名称高管年薪平均值及排序
title = '分行业名称最高年薪平均值及排序(有效样本{}家)'.format(data_salary['最高年薪']['有效样本'])
sql = 'select 行业名称, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_Top group by 行业名称 order by `均值(元)` desc'
print_info(title, sql)
data = export_data(sql)
data_avg = pd.merge(data, hangye, on='行业名称')
data_avg.index = pd.Series(data=range(1, len(data_avg) + 1), name='排名')
data_avg[['行业名称', '行业编码', '样本数(家)', '均值(元)']].to_excel(writer, sheet_name=title)

for i in range(1, 7):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分行业名称{}年薪平均值及排序(有效样本{}家)'.format(职位内容, data_salary[职位内容]['有效样本'])
    template = 'select 行业名称, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_One where 职位秩序={} group by 行业名称 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    print_info(title, sql)
    data = export_data(sql)
    data_avg = pd.merge(data, hangye, on='行业名称')
    data_avg.index = pd.Series(data=range(1, len(data_avg) + 1), name='排名')
    data_avg[['行业名称', '行业编码', '样本数(家)', '均值(元)']].to_excel(writer, sheet_name=title)

## 分行业名称高管持股市值平均值及排序
for i in range(1, 6):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分行业名称{}持股市值平均值及排序(有效样本{}家)'.format(职位内容, data_stock[职位内容]['有效样本'])
    template = 'select 行业名称, count(1) AS `样本数(家)`, round(avg(持股市值)) AS `均值(元)` from RZ_Stock_One where 职位秩序={} group by 行业名称 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    print_info(title, sql)
    data = export_data(sql)
    data_avg = pd.merge(data, hangye, on='行业名称')
    data_avg.index = pd.Series(data=range(1, len(data_avg) + 1), name='排名')
    data_avg[['行业名称', '行业编码', '样本数(家)', '均值(元)']].to_excel(writer, sheet_name=title)

## 分地域高管年薪平均值及排序
title = '分地域最高年薪平均值及排序(有效样本{}家)'.format(data_salary['最高年薪']['有效样本'])
sql = 'select 地域, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_Top group by 地域 order by `均值(元)` desc'
write_data(title, sql)

for i in range(1, 7):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分地域{}年薪平均值及排序(有效样本{}家)'.format(职位内容, data_salary[职位内容]['有效样本'])
    template = 'select 地域, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_One where 职位秩序={} group by 地域 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    write_data(title, sql)

## 分地域高管持股市值平均值及排序
for i in range(1, 6):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分地域{}持股市值平均值及排序(有效样本{}家)'.format(职位内容, data_stock[职位内容]['有效样本'])
    template = 'select 地域, count(1) AS `样本数(家)`, round(avg(持股市值)) AS `均值(元)` from RZ_Stock_One where 职位秩序={} group by 地域 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    write_data(title, sql)

## 分企业属性高管年薪平均值及排序
title = '分企业属性最高年薪平均值及排序(有效样本{}家)'.format(data_salary['最高年薪']['有效样本'])
sql = 'select 企业属性, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_Top group by 企业属性 order by `均值(元)` desc'
write_data(title, sql)

for i in range(1, 7):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分企业属性{}年薪平均值及排序(有效样本{}家)'.format(职位内容, data_salary[职位内容]['有效样本'])
    template = 'select 企业属性, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_One where 职位秩序={} group by 企业属性 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    write_data(title, sql)

## 分企业属性高管持股市值平均值及排序
for i in range(1, 6):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分企业属性{}持股市值平均值及排序(有效样本{}家)'.format(职位内容, data_stock[职位内容]['有效样本'])
    template = 'select 企业属性, count(1) AS `样本数(家)`, round(avg(持股市值)) AS `均值(元)` from RZ_Stock_One where 职位秩序={} group by 企业属性 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    write_data(title, sql)

## 分板块高管年薪平均值及排序
title = '分板块最高年薪平均值及排序(有效样本{}家)'.format(data_salary['最高年薪']['有效样本'])
sql = 'select 板块, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_Top group by 板块 order by `均值(元)` desc'
write_data(title, sql)

for i in range(1, 7):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分板块{}年薪平均值及排序(有效样本{}家)'.format(职位内容, data_salary[职位内容]['有效样本'])
    template = 'select 板块, count(1) AS `样本数(家)`, round(avg(年薪)) AS `均值(元)` from RZ_Salary_One where 职位秩序={} group by 板块 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    write_data(title, sql)

## 分板块高管持股市值平均值及排序
for i in range(1, 6):
    职位内容 = iterator['职位内容'][i]
    职位秩序 = iterator['职位秩序'][i]
    title = '分板块{}持股市值平均值及排序(有效样本{}家)'.format(职位内容, data_stock[职位内容]['有效样本'])
    template = 'select 板块, count(1) AS `样本数(家)`, round(avg(持股市值)) AS `均值(元)` from RZ_Stock_One where 职位秩序={} group by 板块 order by `均值(元)` desc'
    sql = template.format(职位秩序)
    write_data(title, sql)

## 高管薪酬占比平均值分析
title = '分行业名称高管薪酬占比平均值及排序(有效样本{}家)'.format(num_rate)
sql = 'select 行业名称,行业编码,count(1) AS `样本数(家)`,avg(高管薪酬占比) as `均值(%)` from RZ_Company_All where 高管薪酬占比>0 group by 行业编码 order by `均值(%)` desc'
write_data(title, sql)

title = '分地域高管薪酬占比平均值及排序(有效样本{}家)'.format(num_rate)
sql = 'select 地域,count(1) AS `样本数(家)`,avg(高管薪酬占比) as `均值(%)` from RZ_Company_All where 高管薪酬占比>0 group by 地域 order by `均值(%)` desc'
write_data(title, sql)

title = '分企业属性高管薪酬占比平均值及排序(有效样本{}家)'.format(num_rate)
sql = 'select 企业属性,count(1) AS `样本数(家)`,avg(高管薪酬占比) as `均值(%)` from RZ_Company_All where 高管薪酬占比>0 group by 企业属性 order by `均值(%)` desc'
write_data(title, sql)

title = '分板块高管薪酬占比平均值及排序(有效样本{}家)'.format(num_rate)
sql = 'select 板块,count(1) AS `样本数(家)`,avg(高管薪酬占比) as `均值(%)` from RZ_Company_All where 高管薪酬占比>0 group by 板块 order by `均值(%)` desc'
write_data(title, sql)

writer.close()
