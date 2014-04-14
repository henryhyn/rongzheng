#!/bin/bash

if [ -z $1 ]; then
    echo "Usage: ./main.sh SHIFT_YEAR"
    exit
fi
shift_year=$1
this_year=`echo $(date +"%Y")`
year=`expr $this_year - $shift_year`

dir_root=`pwd`
dir_home=$dir_root/..
dir_data=$dir_home/dat/$year
dir_rnw=$dir_home/rnw
dir_out=$dir_home/out
dir_src=$dir_home/src
dir_bin=$dir_home/bin
export PATH=$dir_bin:$PATH

#### initialize database ####
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source init_db.sql'

cd $dir_data
#### xlsx2csv ####
# files="总表*.xlsx"
# for file in $files; do
#     name=${file%.*}
#     echo "Convert $file to $name.csv"
#     # xlsx2csv -d'|' -s1 $file | perl -pe 's/_x000D_\r?\n//g' | sed 'N;$d;P;D' > $name.csv
# done
#### split ####
# split.py "总表2-薪酬明细.csv" "RZ_Salary.csv"
# split.py "总表3-持股明细.csv" "RZ_Stock.csv"
# rm -fr 总表2-薪酬明细.csv
# rm -fr 总表3-持股明细.csv
# mv 总表1-基本信息-薪酬.csv RZ_Company_Salary.csv
# mv 总表1-基本信息-持股.csv RZ_Company_Stock.csv
# mv 总表1-基本信息-规模.csv RZ_Company_Size.csv
#### load data ####
# > temp.sql
# files="RZ_[CS]*.csv"
# for file in $files; do
#     name=${file%.*}_0000
#     echo "LOAD DATA LOCAL INFILE '$file' INTO TABLE \`$name\`"  >> temp.sql
#     echo "    CHARACTER SET UTF8"                               >> temp.sql
#     echo "    FIELDS TERMINATED BY '|' ENCLOSED BY '\"'"        >> temp.sql
#     echo "    LINES TERMINATED BY '\n'"                         >> temp.sql
#     echo "    IGNORE 1 LINES;"                                  >> temp.sql
#     echo ""                                                     >> temp.sql
# done
# echo "DELETE FROM RZ_Salary_0000 WHERE 职位='';" >> temp.sql
# echo "DELETE FROM RZ_Stock_0000  WHERE 职位='';" >> temp.sql
# cp -fa $dir_src/rongzheng.sql .
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source rongzheng.sql'
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source temp.sql'
# rm -fr rongzheng.sql
# rm -fr temp.sql
#### export job all ####
# cp -fa $dir_src/export_joball.sql .
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source export_joball.sql'
# mv /tmp/RZ_Job_All_0000.csv RZ_Job_All_$year.csv
# rm -fr export_joball.sql
#### import job all ####
# xlsx2csv -d'|' -s1 RZ_Job_All_$year.xlsx > RZ_Job_All_0000.csv
# cp -fa $dir_src/import_joball.sql .
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source import_joball.sql'
# rm -fr import_joball.sql
# rm -fr RZ_Job_All_0000.csv
cd -

#### data analysis ####
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source proc_rongzheng.sql'
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e "call sp_MergeData($year)"
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source proc_select.sql'
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source sp_valid.sql'
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source sp_rank.sql'
# mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source sp_average.sql'

#### generate report ####
cd $dir_rnw
# ./make
./clean
mv main.pdf  $dir_out
mv main.docx $dir_out
cd -












