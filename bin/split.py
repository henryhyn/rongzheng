#!/usr/bin/python
#coding=utf8
# 拆分

import sys
# import shutil
# import datetime

# shift_year = 1
# if len(sys.argv) == 2:
#     shift_year = int(sys.argv[1])
# today = datetime.date.today()
# year = today.year - shift_year

def split(read, write):
    fwrite = open(write,'w')
    fread  = open(read,'r')
    for line in fread:
        lst = line.strip('\n').split('|')
        i_split = lst[3].replace('兼',',').replace('及',',').replace('/',',').replace('、',',').replace('﹑',',').replace(';',',').replace('，',',').replace('\\',',')
        for i in i_split.split(','):
            lst[3] = i
            fwrite.write('|'.join(lst) + '\n')
    fread.close()
    fwrite.close()

read  = sys.argv[1]
write = sys.argv[2]
print "Split %s into %s" % (read, write)
split(read, write)

# shutil.copy2("总表1-基本信息-薪酬-%s.csv" % year, "RZ_Company_Salary_%s.csv" % year)
# shutil.copy2("总表1-基本信息-持股-%s.csv" % year, "RZ_Company_Stock_%s.csv" % year)
# shutil.copy2("总表1-基本信息-规模-%s.csv" % year, "RZ_Company_Size_%s.csv" % year)
# split("总表2-薪酬明细-%s.csv" % year, "RZ_Salary_%s.csv" % year)
# split("总表3-持股明细-%s.csv" % year, "RZ_Stock_%s.csv" % year)