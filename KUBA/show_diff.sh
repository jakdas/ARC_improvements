
awk '
{ sub(/\r/,"");
  for (i=1; i<=NF; i++)
    Ar[NR, i] = $i
}

END {
rec="";
previous_key="";
for (i=2; i<=NR; i++)
{
 if (previous_key != Ar[i,3]""Ar[i,6]""Ar[i,6])
 {
  #nowa sekcja
  for (j=1; j<=NF; j++) rec = rec OFS Ar[i,j]
 }
 if (previous_key == Ar[i,3]""Ar[i,6]""Ar[i,6])
 {
  #ta sama sekcja
  for (j=1; j<=NF; j++) 
  {
    if ((Ar[i-1,j] != Ar[i,j]) && (Ar[1,j] != "Accrued") && (j!=1)) 
    {
	 rec = rec OFS  "-----" Ar[i,j] "-----";
    }
    else
    {
	 rec = rec OFS Ar[i,j];
    }
  } 
 }

#print rec;
printf "%s\n",rec;
rec=" ";

previous_key = Ar[i,3]""Ar[i,6]""Ar[i,6]
#print previous_key;
#print Ar[i,1]"+++"Ar[i,2]"+++"Ar[i,3]"+++"Ar[i,4]"+++"Ar[i,5]"+++"Ar[i,6]"+++"Ar[i,7]"+++"Ar[i,8];
}
}
' FS="\t" OFS="\t"
  

