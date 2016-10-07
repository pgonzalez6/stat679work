#!/bin/bash 

echo analysis,Hmax,CPU,xtolAbs > output.csv
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(echo $i | grep -o -E "[^/]+\.log" | grep -o -E "[^.log]+")
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]")
	CPU=$(grep -E "Elapsed time. \d+" -o out/$analysis.out)	
	xtolAbs=$(grep "xtolAbs" $i | head -n1 | grep -o -E "[0-9]+")
	echo "analysis=$analysis ; h=$h ; CPU=$CPU ; xtolAbs=$xtolAbs"
    echo "$analysis,$h,$CPU,$xtolAbs" >> output.csv	
done



