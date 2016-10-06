#!/bin/bash 

### Get the root



### At first get hmax from each file

echo analysis,Hmax,cputime > out5.csv
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(echo $i | grep -o -E "[^/]+\.log" | grep -o -E "[^.log]+")
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]")
	CPU=$(grep -E "Elapsed time. \d+" -o out/$analysis.out)	
	echo "analysis=$analysis ; h=$h ; CPU=$CPU"
    echo "$analysis,$h,$CPU" >> out5.csv	
done


#for i in out/*.out;
#do
#	echo "i=$i" 
#	CPU=$(grep -E "Elapsed time. \d+" -o out/t*)	
#	echo "CPU=$CPU"
	
#done

