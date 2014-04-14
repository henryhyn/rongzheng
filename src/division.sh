#!/bin/bash

if [ -z $1 ]; then
    echo "Need action: export or import"
    exit
fi
action=$1
year=2012

if [ $action = "export" ]; then
    perl -pe 's/0000/2012/g' export_joball.sql > temp.sql
    mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source temp.sql'
    mv /tmp/RZ_Job_All_$year.csv .
else
    xlsx2csv -d'|' -s1 RZ_Job_All_$year.xlsx > RZ_Job_All_$year.csv
    perl -pe 's/0000/2012/g' import_joball.sql > temp.sql
    mysql -uroot -pmysql -h127.0.0.1 --default-character-set=utf8 rongzheng -e 'source temp.sql'
fi
rm -fr temp.sql