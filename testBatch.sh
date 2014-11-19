#!/bin/bash -l
#SBATCH -D /home/sbyfield/HapMap2Teo/ZeaLastZ/batch
#SBATCH -J Lastz
#SBATCH -o /home/sbyfield/HapMap2Teo/ZeaLastZ/batch/Lastzout-%j.txt
#SBATCH -e /home/sbyfield/HapMap2Teo/ZeaLastZ/batch/Lastzerror-%j.txt
#SBATCH --mem=8000
#SBATCH --array=1-523


#usage: This file needs to be executed from within the directory where all the fasta
#files you want compare are.
#you should use something like:
#sbatch -p serial <script.sh> 

echo "Starting Job:"
date

#find all the files you we want to analyse, those ending in .fasta
shopt -s nullglob
files=(*.fasta)

echo "Analysing: "
echo ${files[1]}

lastz /home/sbyfield/HapMap2Teo/ZeaLastZ/Zea_mays_main_refgv3_chromosomes.fasta[multiple] \
~/CNVer/refZea/fasta_files_folder/${files[1]} --hspthresh=5000 --format=axt \
> /home/sbyfield/HapMap2Teo/ZeaLastZ/batch/${files[1]}_v_all.txt

echo "Job Done:"
date

