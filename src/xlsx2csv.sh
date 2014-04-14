#!/bin/bash
# Usage: ./xlsx2csv [SHIFT_YEAR]
# - SHIFT_YEAR 按当前年号向前平移, 默认值为 1.
# - Dependency: xlsx2csv (sudo easy_install xlsx2csv)
#
# Function: 将以 *-YEAR.xlsx 命名的文件转为 CSV 文件:
# - 仅转换第一个 Sheet;
# - 以竖线分隔;
# - 标题行只占一行, 取消标题行内换行;
# - 删除末尾两行.

shift_year=1
if [ ! -z $1 ]; then
    shift_year=$1
fi

rm -frv *.csv

this_year=`echo $(date +"%Y")`
year=`expr $this_year - $shift_year`
files="*-$year.xlsx"

for file in $files; do
    name=${file%.*}
    echo "Convert $file to $name.csv"
    xlsx2csv -d'|' -s1 $file | perl -pe 's/_x000D_\r?\n//g' | sed 'N;$d;P;D' > $name.csv
done