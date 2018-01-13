`ls -otr /tmp/db_counts*.txt | tail -2 | awk 'BEGIN {command="diff ";} {command=command $NF " "} END {print command;}'`  | egrep "[\>\<]" | awk 'NF==3 {print $0}' | awk '$1=="<" {TABLE=$2;BEF=$3} $1==">"  {printf "%-20s \t%6d\t%6d\t\tzmiana:%4d \n", TABLE, BEF,$3,$3-BEF}'
echo ""
echo ""
`ls -otr /tmp/db_full_counts*.txt | tail -2 | awk 'BEGIN {command="diff ";} {command=command $NF " "} END {print command;}'` | egrep "[\<\>]" | sort -k 2,3 | sed -e "1,2d" | awk '$1=="<" {KEY1=$2;KEY2=$3;BEF=$4} ($1==">" && KEY1=="") {KEY1=$2;KEY2=$3;BEF=0}  $1==">" {printf "%-25s\t%10s\t%6d\t\t%6d\n",KEY1,KEY2,BEF,$4;BEF="";KEY1="";KEY2=""}'


