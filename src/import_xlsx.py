# encoding=utf-8
import re
import pandas as pd
from sqlalchemy import create_engine


def clean_column_name(fields):
    for i in range(len(fields)):
        fields[i] = re.sub('\r?\n.*', '', fields[i])
        fields[i] = re.sub('[(（].*', '', fields[i])
        fields[i] = re.sub('所属证监会', '', fields[i])


engine = create_engine('mysql://root:mysql@127.0.0.1:3306/test?charset=utf8')

file_name = '/Users/Henry/Documents/Project/H20140504RongZheng/dat/2017/2017白皮书源数据/总表1-基本信息-行业.xlsx'
data = pd.read_excel(file_name, index_col='证券代码', skip_footer=2)
clean_column_name(data.columns.values)
print(data.head(1).T)
data.to_sql('rz_company_hangye', engine, if_exists='append', chunksize=5000)

file_name = '/Users/Henry/Documents/Project/H20140504RongZheng/dat/2017/2017白皮书源数据/总表1-基本信息-规模.xlsx'
data = pd.read_excel(file_name, index_col='证券代码', skip_footer=2)
clean_column_name(data.columns.values)
print(data.head(1).T)
data.to_sql('rz_company_size', engine, if_exists='append', chunksize=5000)

file_name = '/Users/Henry/Documents/Project/H20140504RongZheng/dat/2017/2017白皮书源数据/总表1-基本信息-薪酬.xlsx'
data = pd.read_excel(file_name, index_col='股票代码', skip_footer=2)
clean_column_name(data.columns.values)
print(data.head(1).T)
data.to_sql('rz_company_salary', engine, if_exists='append', chunksize=5000)

file_name = '/Users/Henry/Documents/Project/H20140504RongZheng/dat/2017/2017白皮书源数据/总表1-基本信息-持股.xlsx'
data = pd.read_excel(file_name, index_col='股票代码', skip_footer=2)
clean_column_name(data.columns.values)
print(data.head(1).T)
data.to_sql('rz_company_stock', engine, if_exists='append', chunksize=5000)

file_name = '/Users/Henry/Documents/Project/H20140504RongZheng/dat/2017/2017白皮书源数据/总表2-薪酬明细.xlsx'
data = pd.read_excel(file_name, skip_footer=2)
data['年薪(万元)'] *= 10000
clean_column_name(data.columns.values)
print(data.head(1).T)
data.to_sql('rz_salary', engine, if_exists='append', chunksize=5000, index=False)

file_name = '/Users/Henry/Documents/Project/H20140504RongZheng/dat/2017/2017白皮书源数据/总表3-持股明细.xlsx'
data = pd.read_excel(file_name, skip_footer=2)
data['持股数量(万股)'] *= 10000
data['持股市值(万元)'] *= 10000
clean_column_name(data.columns.values)
print(data.head(1).T)
data.to_sql('rz_stock', engine, if_exists='append', chunksize=5000, index=False)
