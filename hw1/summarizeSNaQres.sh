#!/bin/bash 

### Get the root



### At first get hmax from each file

echo -n > out1.csv
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(echo $i | grep -o -E "[^/]+\.log" | grep -o -E "[^.log]+")
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]")
	CPU_Time=$(grep "Elapsed time" out/analysis.out)	
	echo "h=$h ; analysis=$analysis"
echo "$h,$analysis" >> out1.csv	
done



