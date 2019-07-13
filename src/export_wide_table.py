# encoding=utf-8
import pymysql
import numpy as np
import pandas as pd


def export_job(db, job, rank):
    print("%s => %s" % (job, rank))
    sql = "select 股票代码,高管姓名,年薪,持股数量 from RZ_Database_2012 where 职位内容='%s' order by 年薪 desc" % job
    df = pd.read_sql(sql, con=db)
    return df.groupby('股票代码').nth(rank)


if __name__ == '__main__':
    db = pymysql.connect(host='localhost', user='root', passwd='mysql', db='rongzheng', use_unicode=True,
                         charset='utf8')
    # 基本信息
    sql = 'select * from RZ_Company_All'
    res = pd.read_sql(sql, con=db, index_col='股票代码')
    res = res.drop(['年份'], axis=1)

    # 董事长
    ceo = export_job(db, '董事长', 0)
    ceo['兼总经理'] = np.array([False] * len(ceo))
    res = pd.merge(res, ceo, on='股票代码', how='outer')

    # 其他职位
    res = pd.merge(res, export_job(db, '总经理', 0), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董秘', 0), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '财务总监', 0), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 0), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 1), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 2), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 3), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 4), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 5), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 6), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 7), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 8), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 9), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 10), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 11), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 12), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 13), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '副总经理', 14), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 0), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 1), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 2), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 3), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 4), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 5), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 6), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 7), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '独立董事', 8), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 0), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 1), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 2), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 3), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 4), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 5), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 6), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 7), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 8), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '董事', 9), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 0), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 1), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 2), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 3), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 4), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 5), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 6), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 7), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 8), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 9), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 10), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 11), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 12), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 13), on='股票代码', how='outer')
    res = pd.merge(res, export_job(db, '监事', 14), on='股票代码', how='outer')

    db.close()

    # 将结果写入 Excel
    writer = pd.ExcelWriter(r'/tmp/a.xlsx')
    res.to_excel(writer, sheet_name='数据总表')
    writer.close()
