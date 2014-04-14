#!/bin/bash

shift_year=1
if [ ! -z $1 ]; then
    shift_year=$1
fi

this_year=`echo $(date +"%Y")`
year=`expr $this_year - $shift_year`
files="*_$year.csv"

> temp.sql
for file in $files; do
    name=${file%.*}
    echo "DROP TABLE IF EXISTS $name;"                          >> temp.sql
    echo "CREATE TABLE $name LIKE ${name%_*}_0000;"             >> temp.sql
    echo "LOAD DATA LOCAL INFILE '$file' INTO TABLE \`$name\`"  >> temp.sql
    echo "    CHARACTER SET UTF8"                               >> temp.sql
    echo "    FIELDS TERMINATED BY '|' ENCLOSED BY '\"'"        >> temp.sql
    echo "    LINES TERMINATED BY '\n'"                         >> temp.sql
    echo "    IGNORE 1 LINES;"                                  >> temp.sql
    echo ""                                                     >> temp.sql
done
echo "DELETE FROM RZ_Salary_$year WHERE 职位='';" >> temp.sql
echo "DELETE FROM RZ_Stock_$year  WHERE 职位='';" >> temp.sql
grep DROP rongzheng.sql >> temp.sql

mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source rongzheng.sql'
mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source data.sql'
mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source temp.sql'

rm -fr temp.sql