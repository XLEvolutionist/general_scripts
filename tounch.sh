#!/usr/bin/bash

for i in {1..523};  do
		if [ -f scaffold_$i.bed ] 
			then echo "Found" 
			else echo "Not Found"; touch scaffold.$i.bed 
		fi
		done