# encoding=utf-8
import re
import sys

import numpy as np
import pandas as pd
import pymysql
from sqlalchemy import create_engine, types

pymysql.install_as_MySQLdb()
year = sys.argv[1]


def clean_column_name(fields):
    for i in range(len(fields)):
        fields[i] = re.sub('\r?\n', '', fields[i])
        fields[i] = re.sub('\[.*', '', fields[i])
        fields[i] = re.sub('\((万元|万股|%)\)', '', fields[i])
        fields[i] = re.sub('所属证监会', '', fields[i])
        fields[i] = re.sub('证券代码.*', '股票代码', fields[i])
        fields[i] = re.sub('证券简称', '股票简称', fields[i])


engine = create_engine('mysql://root:mysql@127.0.0.1:3306/rongzheng?charset=utf8')
with engine.begin() as conn:
    conn.execute('drop table if exists RZ_Company_Genre_0000')
    conn.execute('drop table if exists RZ_Company_Size_0000')
    conn.execute('drop table if exists RZ_Company_Salary_0000')
    conn.execute('drop table if exists RZ_Company_Stock_0000')
    conn.execute('drop table if exists RZ_Salary_0000')
    conn.execute('drop table if exists RZ_Stock_0000')
dtypes = {
    '股票代码': types.CHAR(length=9),
    '股票简称': types.VARCHAR(length=16),
    '行业代码': types.VARCHAR(length=2),
    '行业名称': types.VARCHAR(length=16),
    '企业属性': types.VARCHAR(length=8),
    '地域全称': types.VARCHAR(length=8),
    '高管姓名': types.VARCHAR(length=64),
    '职位': types.VARCHAR(length=64)
}
file_path = '/Users/Henry/Documents/Project/H20140504RongZheng/dat/{}/'.format(year)

file_name = file_path + '总表1-基本信息-行业.xlsx'
data = pd.read_excel(file_name, skipfooter=2)
clean_column_name(data.columns.values)
data = data.set_index('股票代码')
print('=> {}'.format(file_name))
print(data.head(1).T)
data.to_sql('RZ_Company_Genre_0000', engine, if_exists='append', chunksize=5000, dtype=dtypes)

file_name = file_path + '总表1-基本信息-规模.xlsx'
data = pd.read_excel(file_name, skipfooter=2)
clean_column_name(data.columns.values)
data = data.set_index('股票代码')
data.rename(columns={
    '每股收益EPS-扣除/期末股本摊薄': '每股收益',
    '净资产收益率ROE(扣除/摊薄)': '净资产收益率',
    '净资产收益率ROE(扣除/加权)': '加权净资产收益率'
}, inplace=True)
print('=> {}'.format(file_name))
print(data.head(1).T)
data.to_sql('RZ_Company_Size_0000', engine, if_exists='append', chunksize=5000, dtype=dtypes)

file_name = file_path + '总表1-基本信息-薪酬.xlsx'
data = pd.read_excel(file_name, index_col='股票代码', skipfooter=2)
clean_column_name(data.columns.values)
data.rename(columns={
    '独董薪酬总额': '独董薪酬总和',
    '独董总人数': '独董人数',
    '员工薪酬': '员工薪酬总和',
    '董监高管薪酬总和': '董监薪酬总和',
    '董监高总人数': '董监人数',
    '领薪董监高人数': '领薪董监人数',
    '董监高人均薪酬': '董监人均薪酬',
    '行业': '行业名称',
    '地域': '地域全称'
}, inplace=True)
print('=> {}'.format(file_name))
print(data.head(1).T)
data.to_sql('RZ_Company_Salary_0000', engine, if_exists='append', chunksize=5000, dtype=dtypes)

file_name = file_path + '总表1-基本信息-持股.xlsx'
data = pd.read_excel(file_name, index_col='股票代码', skipfooter=2)
clean_column_name(data.columns.values)
data.rename(columns={
    '高管人均持股数': '高管人均持股数量',
    '董监高持股总数': '董监持股总数',
    '董监高总人数': '董监人数',
    '持股董监高人数': '持股董监人数',
    '董监高人均持股数': '董监人均持股数量',
    '董监高人均持股市值': '董监人均持股市值',
    '董监高持股总数占比': '董监持股总数占比',
    '行业': '行业名称',
    '地域': '地域全称'
}, inplace=True)
print('=> {}'.format(file_name))
print(data.head(1).T)
data.to_sql('RZ_Company_Stock_0000', engine, if_exists='append', chunksize=5000, dtype=dtypes)

file_name = file_path + '总表2-薪酬明细.xlsx'
data = pd.read_excel(file_name, skipfooter=2)
data['年薪(万元)'] *= 10000
clean_column_name(data.columns.values)
split_job = data['职务'].str.split('[兼及/、﹑\;，,]', expand=True).stack().reset_index(level=1, drop=True) \
    .rename('职位').str.strip().replace('', np.nan).dropna()
data = data.join(split_job)
data.index = pd.Series(data=range(1, len(data) + 1), name='id')
data.rename(columns={
    '是否在其它单位领取报酬': '兼职'
}, inplace=True)
print('=> {}'.format(file_name))
print(data.head(1).T)
data.to_sql('RZ_Salary_0000', engine, if_exists='append', chunksize=5000, dtype=dtypes)

file_name = file_path + '总表3-持股明细.xlsx'
data = pd.read_excel(file_name, skipfooter=2)
data['持股数量(万股)'] *= 10000
data['持股市值(万元)'] *= 10000
clean_column_name(data.columns.values)
split_job = data['职务'].str.split('[兼及/、﹑\;，,]', expand=True).stack().reset_index(level=1, drop=True) \
    .rename('职位').str.strip().replace('', np.nan).dropna()
data = data.join(split_job)
data.index = pd.Series(data=range(1, len(data) + 1), name='id')
print('=> {}'.format(file_name))
print(data.head(1).T)
data.to_sql('RZ_Stock_0000', engine, if_exists='append', chunksize=5000, dtype=dtypes)

with engine.begin() as conn:
    conn.execute('alter table RZ_Salary_0000 add index `ix_职位`(`职位`)')
    conn.execute('alter table RZ_Salary_0000 add index `ix_股票代码`(`股票代码`)')
    conn.execute('alter table RZ_Stock_0000 add index `ix_职位`(`职位`)')
    conn.execute('alter table RZ_Stock_0000 add index `ix_股票代码`(`股票代码`)')
