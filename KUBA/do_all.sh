cd brcimport_day1		
../skrypt.sh $1
cd ../brcimport_day2		
../skrypt.sh $1
cd ../brcimport_day3		
../skrypt.sh $1
cd ../brcimport_day4
../skrypt.sh $1
cd ..

#zmiany w Cashflowach
find . -name "NEC_Cash*.*" -exec awk  'BEGIN {OFS="\t"} NR > 1 {payDate = substr($3,7,4)"/"substr($3,4,2)"/"substr($3,1,2);$3=payDate;} {print FILENAME,$0}' {} \; | sort -k 2,2 -k 4,4 -k 5,5 | awk 'BEGIN {previousF2="";previousF3="";previousF4="";previousF5="";previousF6=""} (previousF2!=$2 || previousF3!=$3 || previousF4!=$4 || previousF5!=$5 || previousF6!=$6) && ( $2$4$5 == previous_row_key)     {print previous_row;print $0} {previousF2=$2;previousF3=$3;previousF4=$4;previousF5=$5;previousF6=$6; previous_row=$0;previous_row_key=$2$4$5}' > cashflow_changes.txt

#AdditionalPayments summary
find . -name "NEC_AdditionalP*" -exec awk 'BEGIN {OFS="\t"} NR > 1 {payDate = substr($9,7,4)"/"substr($9,4,2)"/"substr($9,1,2);$9=payDate;matDate = substr($10,7,4)"/"substr($10,4,2)"/"substr($10,1,2);$10=matDate;} {print FILENAME,$0}' FS="\t" OFS="\t" {} \;  | sort -k 1,1 -k 5,5 -k 7,7 > summary_AP.txt

find . -name "NEC_AdditionalP*" -exec awk 'BEGIN {OFS="\t"} NR > 1 {payDate = substr($9,7,4)"/"substr($9,4,2)"/"substr($9,1,2);$9=payDate;matDate = substr($10,7,4)"/"substr($10,4,2)"/"substr($10,1,2);$10=matDate;} {print FILENAME,$0}' FS="\t" OFS="\t" {} \; | sort -k 5,5 -k 2,2 -k 6,6 -k 3,3 -k 1,1  | ./show_diff.sh  | egrep -B 1 "(\-\-\-\-\-)|(ContractReference)" > summary_AP1.txt


