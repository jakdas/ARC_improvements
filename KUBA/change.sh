#! /bin/sh

CONTRACT_NAMES="contract_names.txt"
awk   'BEGIN {
while (getline < "'"$CONTRACT_NAMES"'") {
  split ($0, ft,"\t");
  Ar[ft[1]]=ft[2];
} 
close("'"$CONTRACT_NAMES"'")

}

NR==1 {
 for (i=1;i<NF;i++) {
  if ($i=="ContractReference") {COLUMNS[i]=1};
  if ($i=="FacilityReference") {COLUMNS[i]=1};
 }

}

NR > 1 {
for (kolumna in COLUMNS) {
 $kolumna=Ar[$kolumna]
}
 print $0
}


END {
#for (var in COLUMNS) {
# print var,COLUMNS[var];
#}
}
' FS="\t" OFS="\t"
