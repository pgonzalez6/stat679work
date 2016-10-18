this is how I got the data, from the home directory:
```
cd
cp -r Desktop/coursedata/hw1-snaqTimeTests/out stat679work/hw1/ 
cp -r Desktop/coursedata/hw1-snaqTimeTests/log stat679work/hw1/ 
#

## Excercice 1

vi normalizeFileName.sh
cp normalizeFileName.sh out
for i in {1..9};do  
cp timetest${i}_snaq.out timetest0${i}_snaq.out
rm timetest${i}_snaq.out
done

cd out
./normalizeFileName.sh
bash normalizeFileName
cd ..
cp normalizeFileName.sh log
for i in {1..9};do  
cp timetest${i}_snaq.log timetest0${i}_snaq.log
rm timetest${i}_snaq.log
done


## Exercice 2

vi summarizeSNaQres.sh

### Script summarizeSNaQres.sh

#!/bin/bash 

echo analysis,Hmax,CPU > output.csv
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(echo $i | grep -o -E "[^/]+\.log" | grep -o -E "[^.log]+")
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]")
	CPU=$(grep -E "Elapsed time. \d+" -o out/$analysis.out)	
	echo "analysis=$analysis ; h=$h ; CPU=$CPU"
    echo "$analysis,$h,$CPU" >> output.csv	
done

git tag v1.2

git push origin v1.2

## Exercise 3

