#!/bin/bash 

### Get the root



### At first get hmax from each file

find . -name 't*.log'
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(echo $i | grep -o -E "[^/]+\.log" | grep -o -E "[^.log]+")
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]")
	echo "h=$h ; analysis=$analysis"
	#CPU_Time=$(grep "Elapsed time" out/*.out)	
	echo "$h,$analysis" >> out1.csv
done



exec >out.csv

