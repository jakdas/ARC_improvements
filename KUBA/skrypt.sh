wc -l *.almGenericFile | awk '$1 > 1 {print $2}' | grep  almGenericFile > plikiAlmGenericFile.txt
#cat plikiAlmGenericFile.txt | sed -e "s/^/awk \'NR==1 \&\& \$0 ~ \/ContractReference\/ {print FILENAME}\' /" > files_to_be_processed.sh
#chmod 755 files_to_be_processed.sh

#BACKUP
cat plikiAlmGenericFile.txt |  awk '{print "cp "$0" "$0"_BACKUP"}' > backup_files.sh
chmod 755 backup_files.sh 
./backup_files.sh 

#HEADER FILES
cat plikiAlmGenericFile.txt | awk '{print "cat "$0"_BACKUP | head -1 > "$0}' > header_files.sh
cat plikiAlmGenericFile.txt | awk '{print "cat "$0"_BACKUP | head -1 > MOD_"$0}' >> header_files.sh
chmod 755 header_files.sh 
./header_files.sh 

# generuje liste kontraktow i facility
#cat Contracts.almGenericFile_BACKUP | ./generate.sh U+CI3006_BINTG_00001_I65346  > contract_references.txt
cat Contracts.almGenericFile_BACKUP | ../generate.sh $1 > contract_references.txt

#generuje polecenie przekopiowania tylko wierszy dla wymaganych kontraktow do poczatkowych plikow
cat plikiAlmGenericFile.txt |  awk '{print "egrep \"`cat contract_references.txt`\" "$0"_BACKUP >> "$0}' > only_selected_data.sh
chmod 755 only_selected_data.sh 
./only_selected_data.sh 

cat Contracts.almGenericFile | awk 'NR==1 {for (i=1;i<NF;i++) {if ($i=="ContractReference") {numer=i;next;}}} NR>1 {print $numer;}' FS="\t" | awk 'Ar[$1] == 1 {next} {Ar[$1]=1;} END {for (var in Ar) print var}' | awk '{print $1"\tContract_"NR}' > contract_names.txt



#zmienia nazwy kontraktow
cat plikiAlmGenericFile.txt |  awk '{print "cat "$0" | ../change.sh >> MOD_"$0}' > files_with_renamned_contracts.sh
chmod 755 files_with_renamned_contracts.sh
./files_with_renamned_contracts.sh

#kopiuje pliki we wlasciwe miejsce
cat plikiAlmGenericFile.txt |  awk '{print "cp MOD_"$0" "$0}' > copy_files.sh
chmod 755 copy_files.sh 
./copy_files.sh 


#generuje pliki bez pustych kolumn
cat plikiAlmGenericFile.txt |  awk '{print "cat "$0" | ../removeEmptyColumns.sh > NEC_"$0}' > files_without_empty_columns.sh
chmod 755 files_without_empty_columns.sh 
./files_without_empty_columns.sh 

rm ./backup_files.sh
rm ./header_files.sh
rm ./MOD_*
#rm ./contract_references.txt
rm ./only_selected_data.sh
rm ./files_without_empty_columns.sh

