#!/bin/bash


if [ "$1" = "help" ]
then
echo "-----------------------------"
echo "list - list databases"
echo "drop - drops a database. TRZEBA PODAC NAZWE BAZY DO USUNIECIA"
echo "exp  - exports a database"
echo "imp  - imports a database"
echo "size - displays sizes of all the tables"
echo "DBsize - displays size of the ables"
echo "set  - sets HOST / USER / PASSWORD / DBNAME"
echo "show - displays current settings"
echo "showSD - displays existing Situation Dates"
echo "today  - displays tables with some entries for a given Situation Date"
echo "generate - builds SQL to gather cardinality of all tables with SITUATION_DATE column"
echo "snapshot - gathers current statitics for all the tables"
echo "compare  - compares two most recent statitics for all the tables"
echo "last     - displays last N messages from the LOG_MESSAGE table"
echo "SourceS  - displays source systems and their corresponding partition IDs"


if  [ "$2" = "all" ]
then
echo "list_backups      - displays all the backups and their sizes"
echo "delete_backup     - deletes a given backup"
echo "compress_backup   - compresses a given backup"
echo "uncompress_backup - uncompresses a given backup"
echo ""
echo "---   KGR MARKET DATA ---"
echo "FX_DEFS   - displays all existing FX definitions from the rate database"
echo "FX_DATES  - displays all the dates for a given FX pair from the rate database"
echo "FX_POINTS - displays a given FX pair on a given date"
echo "ASSETS_DEFS   - displays all existing ASSET definitions from the rate database"
echo "ASSETS_DATES  - displays all the dates for a given ASSET from the rate database"
echo "ASSETS_POINTS - displays a given ASSET on a given date"
fi

echo "-----------------------------"
  exit 1

fi

if [ "$1" =  "list" ]
then
	docker exec -it DBA /tmp/skrypt.sh list
fi

if [ "$1" =  "drop" ]
then
	docker exec -it DBA /tmp/skrypt.sh drop $2
fi

if [ "$1" =  "set" ]
then
	docker exec -it DBA /tmp/skrypt.sh set $2 $3
fi

if [ "$1" =  "exp" ]
then
	docker exec -it DBA /tmp/skrypt.sh exp 
fi

if [ "$1" =  "imp" ]
then
	docker exec -it DBA /tmp/skrypt.sh imp 
fi

if [ "$1" =  "show" ]
then
	docker exec -it DBA /tmp/skrypt.sh show 
fi

if [ "$1" =  "showSD" ]
then
	docker exec -it DBA /tmp/skrypt.sh showSD 
fi

if [ "$1" =  "size" ]
then
	docker exec -it DBA /tmp/skrypt.sh size 
fi

if [ "$1" =  "partitions" ]
then
	docker exec -it DBA /tmp/skrypt.sh partitions 
fi

if [ "$1" =  "DBsize" ]
then
	docker exec -it DBA /tmp/skrypt.sh DBsize 
fi

if [ "$1" =  "generate" ]
then
	docker exec -it DBA /tmp/skrypt.sh generate
fi

if [ "$1" =  "snapshot" ]
then
	docker exec -it DBA /tmp/skrypt.sh snapshot 
fi

if [ "$1" =  "today" ]
then
	docker exec -it DBA /tmp/skrypt.sh today $2 
fi

if [ "$1" =  "compare" ]
then
	docker exec -it DBA /tmp/skrypt.sh compare
fi

if [ "$1" =  "last" ]
then
	docker exec -it DBA /tmp/skrypt.sh last $2 
fi

if [ "$1" =  "list_backups" ]
then
	docker exec -it sql1 ls -l /var/opt/mssql/data | egrep -v "(model)|(master)|(msdb)|(mastlog)|(templog)" | egrep -v "^total" | awk '{print $NF"\t\t\t"$5}' | grep -v "\.mdf"
fi

if [ "$1" =  "delete_backup" ]
then
	docker exec -it sql1 rm -f /var/opt/mssql/data/$2
fi

if [ "$1" =  "compress_backup" ]
then
	docker exec -it sql1 gzip /var/opt/mssql/data/$2
fi


if [ "$1" =  "uncompress_backup" ]
then
	docker exec -it sql1 gzip -d /var/opt/mssql/data/$2
fi

if [ "$1" =  "FX_DEFS" ]
then
	docker exec -it DBA /tmp/skrypt.sh FX_DEFS 
fi

if [ "$1" =  "FX_DATES" ]
then
	docker exec -it DBA /tmp/skrypt.sh FX_DATES $2
fi

if [ "$1" =  "FX_POINTS" ]
then
	docker exec -it DBA /tmp/skrypt.sh FX_POINTS $2 $3
fi
if [ "$1" =  "ASSET_DEFS" ]
then
	docker exec -it DBA /tmp/skrypt.sh ASSET_DEFS 
fi

if [ "$1" =  "ASSET_DATES" ]
then
	docker exec -it DBA /tmp/skrypt.sh ASSET_DATES $2
fi

if [ "$1" =  "ASSET_POINTS" ]
then
	docker exec -it DBA /tmp/skrypt.sh ASSET_POINTS $2 $3
fi

