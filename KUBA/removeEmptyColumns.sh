

awk ' 
 {for (i=1; i<=NF; i++) # for every field in every line i
   {LG[i] = LG[i] * ($i=="") + (NR==1) # test if $i is empty, except for line 1 
   Ar[NR, i] = $i # save field by line and fld No. 
 } } 
 END {for (j=1; j<=NR; j++) # go through all lines of entire file 
        {for (i=1; i<=NF; i++) # with all saved fields 
          if (!LG[i]) rec = rec OFS Ar[j,i] # compose output record unless field was empty in all lines 
         printf "%s\n", rec; rec =" "  # print it \
  } } ' FS="\t" OFS="\t" 
