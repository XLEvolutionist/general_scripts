#!/bin/bash -l
#SBATCH -D /home/sbyfield/HapMap2Teo/ZeaLastZ/batch
#SBATCH -J batchLastz
#SBATCH -o /home/sbyfield/HapMap2Teo/ZeaLastZ/batch/out-%j.txt
#SBATCH -e /home/sbyfield/HapMap2Teo/ZeaLastZ/batch/error-%j.txt
#SBATCH --array=1-10

##
##Simon Renny-Byfield, UC Davis, November 12 2014
##Usage: sbatch -p queue <file.sh> <first.list> <second.list>

##The <first.list> and <second.list> are files that contain the names of fasta files to be 
##compared by Lastz. In my case, in total, they constitute all unique binary combos of 
##the ~500 files (sequences) provided in the maize ref_v3 assembly.


echo "Starting Job:"
date

index=0
while read line; do
   file1[index]="$line"
   let "index++"
done < $1 

index=0
while read line; do
   file2[index]="$line"
   let "index++"
done < $2 

target=${file1[$SLURM_ARRAY_TASK_ID]}
query=${file2[$SLURM_ARRAY_TASK_ID]}

lastz ~/CNVer/refZea/fasta_files_folder/$target ~/CNVer/refZea/fasta_files_folder/$query \
	 --hspthresh=5000 --format=axt > $target.$query.txt

echo "Job Done:"
date
