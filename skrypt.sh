#!/bin/bash
if [ "$1" == "help" ]
then
echo "-----------------------------"
echo "list - list databases"
echo "drop - drops a database. TRZEBA PODAC NAZWE BAZY DO USUNIECIA"
echo "exp  - exports a database"
echo "imp  - imports a database"
echo "size - displays sizes of all the tables"
echo "DBsize - displays size of the database [MB]"
echo "set  - sets HOST / USER / PASSWORD / DBNAME"
echo "show - displays current settings"
echo "showSD - displays existing Situation Dates"
echo "today  - displays tables with some entries for a given Situation Date"
echo "generate - builds SQL to gather cardinality of all tables with SITUATION_DATE column"
echo "snapshot - gathers current statitics for all the tables"
echo "compare  - compares two most recent statitics for all the tables"
echo "last     - displays last N messages from the LOG_MESSAGE table"
echo "SourceS  - displays source systems and their corresponding partition IDs"
echo "FX_DEFS   - displays all existing FX definitions from the rate database"
echo "FX_DATES  - displays all the dates for a given FX pair from the rate database"
echo "FX_POINTS - displays a given FX pair on a given date"
echo "ASSETS_DEFS   - displays all existing ASSET definitions from the rate database"
echo "ASSETS_DATES  - displays all the dates for a given ASSET from the rate database"
echo "ASSETS_POINTS - displays a given ASSET on a given date"
echo "-----------------------------"
  exit 1
fi

HOST=`cat /tmp/settings.txt | awk -F":" 'NR==1 {print $2}'`
USER=`cat /tmp/settings.txt | awk -F":" 'NR==2 {print $2}'`
PASSWORD=`cat /tmp/settings.txt | awk -F":" 'NR==3 {print $2}'`
DBNAME=`cat /tmp/settings.txt | awk -F":" 'NR==4 {print $2}'`
#clear
#echo "-----------------------------"
#echo "$HOST"
#echo "$USER"
#echo "$PASSWORD"
#echo "$DBNAME"
#echo "-----------------------------"
#echo ""

if [ "$1" == "list" ]
then
/opt/mssql-tools/bin/sqlcmd -i /tmp/dbs.sql -S $HOST -U $USER -P $PASSWORD 
  exit 1
fi

if [ "$1" == "drop" ]
then
sed  -e  "s/AAAA/$2/" /tmp/dropdb.sql > /tmp/dropdb1.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/dropdb1.sql -S $HOST -U $USER -P $PASSWORD
  exit 1
fi

if [ "$1" = "size" ]
then
sed  -e  "s/AAAA/$DBNAME/" /tmp/table_size.sql > /tmp/table_size1.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/table_size1.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
  exit 1
fi

if [ "$1" = "partitions" ]
then
sed  -e  "s/AAAA/$DBNAME/" /tmp/partitions.sql > /tmp/partitions1.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/partitions1.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
rm /tmp/partitions1.sql
  exit 1
fi

if [ "$1" = "DBsize" ]
then
sed  -e  "s/AAAA/$DBNAME/" /tmp/dbsize.sql > /tmp/dbsize1.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/dbsize1.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
rm /tmp/dbsize1.sql
  exit 1
fi

if [ "$1" = "showSD" ]
then
sed  -e  "s/AAAA/$DBNAME/" /tmp/showSD.sql > /tmp/showSD1.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/showSD1.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
rm /tmp/showSD1.sql
  exit 1
fi

if [ "$1" = "FX_DEFS" ]
then
#sed  -e  "s/AAAA/$DBNAME/" /tmp/table_size.sql > /tmp/table_size1.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/KGR/query_FX_1.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
  exit 1
fi

if [ "$1" = "FX_DATES" ]
then
sed  -e  "s/AAAA/$2/" /tmp/KGR/query_FX_2.sql > /tmp/KGR/query_FX_2a.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/KGR/query_FX_2a.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD | awk '{print $1}'
rm /tmp/KGR/query_FX_2a.sql
  exit 1
fi

if [ "$1" = "FX_POINTS" ]
then
sed  -e  "s/AAAA/$2/" /tmp/KGR/query_FX_3.sql > /tmp/KGR/query_FX_3a.sql
sed  -e  "s/BBBB/$3/" /tmp/KGR/query_FX_3a.sql > /tmp/KGR/query_FX_3b.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/KGR/query_FX_3b.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
rm /tmp/KGR/query_FX_3a.sql
rm /tmp/KGR/query_FX_3b.sql
  exit 1
fi

if [ "$1" = "ASSET_DEFS" ]
then
/opt/mssql-tools/bin/sqlcmd -i /tmp/KGR/query_ASSET_1.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
  exit 1
fi

if [ "$1" = "ASSET_DATES" ]
then
sed  -e  "s/AAAA/$2/" /tmp/KGR/query_ASSET_2.sql > /tmp/KGR/query_ASSET_2a.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/KGR/query_ASSET_2a.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD | awk '{print $1}'
rm /tmp/KGR/query_ASSET_2a.sql
  exit 1
fi

if [ "$1" = "ASSET_POINTS" ]
then
sed  -e  "s/AAAA/$2/" /tmp/KGR/query_ASSET_3.sql > /tmp/KGR/query_ASSET_3a.sql
sed  -e  "s/BBBB/$3/" /tmp/KGR/query_ASSET_3a.sql > /tmp/KGR/query_ASSET_3b.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/KGR/query_ASSET_3b.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD
rm /tmp/KGR/query_ASSET_3a.sql
rm /tmp/KGR/query_ASSET_3b.sql
  exit 1
fi

if [ "$1" = "generate" ]
then
sed  -e  "s/AAAA/$DBNAME/" /tmp/gen_stat_sql.sql > /tmp/gen_stat_sql1.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/gen_stat_sql1.sql  -S $HOST -U $USER -P $PASSWORD > /tmp/query.sql
sed -i -e "s/\"/\'/g" /tmp/query.sql
sed -i -e "1,3d" /tmp/query.sql
sed -i -e "1s/^/USE $DBNAME\nGO\n/" /tmp/query.sql
sed -i -e "/ZOBJECTS_HISTO/s/UNION ALL//" /tmp/query.sql
echo " ORDER BY TABNAME, SITUATION_DATE;" >> /tmp/query.sql
sed -i -e "/ORDER BY/s/$/\nGO\n/" /tmp/query.sql
  exit 1
fi

if [ "$1" = "snapshot" ]
then
/opt/mssql-tools/bin/sqlcmd -i  /tmp/query.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD > /tmp/db_full_counts_`date "+%Y%m%d%H%M"`.txt
sed -e "s/AAAA/$DBNAME/" /tmp/tables_count.sql > /tmp/tables_count1.sql
/opt/mssql-tools/bin/sqlcmd -i  /tmp/tables_count1.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD > /tmp/db_counts_`date "+%Y%m%d%H%M"`.txt
  exit 1
fi

if [ "$1" = "today" ]
then
/opt/mssql-tools/bin/sqlcmd -i  /tmp/query.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD | grep $2 
  exit 1
fi

if [ "$1" == "compare" ]
then
  clear
  /tmp/compare.sh
  exit 1
fi

if [ "$1" = "last" ]
then
sed  -e  "s/AAAA/$DBNAME/" /tmp/last_tasks.sql > /tmp/last_tasks1.sql
sed  -e  "s/BBBB/$2/" /tmp/last_tasks1.sql > /tmp/last_tasks2.sql
/opt/mssql-tools/bin/sqlcmd -i /tmp/last_tasks2.sql -y 25 -Y 25 -S $HOST -U $USER -P $PASSWORD |  awk 'NR<4 {print $0} (NR>3 && $1 !~ /^\(/) {print $0 | "sort -r"}'
  exit 1
fi

if [ "$1" == "exp" ]
then
echo "/sqlcmd  -Q BACKUP DATABASE [$DBNAME] TO DISK='${DBNAME}.bak' -S $HOST -U $USER -P $PASSWORD"
/opt/mssql-tools/bin/sqlcmd  -Q "BACKUP DATABASE [$DBNAME] TO DISK='${DBNAME}.bak'" -S $HOST -U $USER -P $PASSWORD
  exit 1
fi

if [ "$1" == "imp" ]
then
echo "/sqlcmd  -Q RESTORE DATABASE [$DBNAME] FROM DISK='${DBNAME}.bak' -S $HOST -U $USER -P $PASSWORD"
/opt/mssql-tools/bin/sqlcmd  -Q "RESTORE DATABASE [$DBNAME] FROM DISK='${DBNAME}.bak'" -S $HOST -U $USER -P $PASSWORD
  exit 1
fi

if [ "$1" == "show" ]
then
cat /tmp/settings.txt
  exit 1
fi

if [ "$1" == "set" ]
then
 if [ "$2" = "host" ]
 then
	sed -i -e "s/HOST:.*/HOST:$3/" /tmp/settings.txt
 fi
 if [ "$2" = "password" ]
 then
	sed -i -e "s/PASSWORD:.*/PASSWORD:$3/" /tmp/settings.txt
 fi
 if [ "$2" = "user" ]
 then
	sed -i -e "s/USER:.*/USER:$3/" /tmp/settings.txt
 fi
 if [ "$2" = "dbname" ]
 then
	sed -i -e "s/DBNAME:.*/DBNAME:$3/" /tmp/settings.txt
 fi
cat /tmp/settings.txt
  exit 1
fi
