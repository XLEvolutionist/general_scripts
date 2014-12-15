#/usr/bin/bash

files=$(ls *fasta.axt)

for i in ${files}; do
	sed -i -e 's/Chr//' $i
done

rename s/.fasta// *.fasta.axt

