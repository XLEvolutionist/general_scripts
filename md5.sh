#/usr/bin/bash

files=$(find /dir/ -type f -name "*.txt")

for i in ${files}; do
	md5 $i
done