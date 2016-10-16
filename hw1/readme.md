this is how I got the data, from the home directory:
```
cd
cp -r Desktop/coursedata/hw1-snaqTimeTests/out stat679work/hw1/ 
cp -r Desktop/coursedata/hw1-snaqTimeTests/log stat679work/hw1/ 
'''

## Excercice 1

vi normalizeFileName.sh
cp normalizeFileName.sh out
for i in {1..9};
	do  
	mv timetest${i}_snaq.out timetest0${i}_snaq.out
done

cd out
./normalizeFileName.sh
bash normalizeFileName
cd ..
cp normalizeFileName.sh log
for i in {1..9};
 	do  
	mv timetest${i}_snaq.log timetest0${i}_snaq.log
done
'''

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
''''
git tag v1.2

## Exercise 3

#### New script with the new variables

#!/bin/bash 

echo analysis,Hmax,CPU,Nruns,Nfails,fabs,frel,xtolAbs,xtolRel,Seed,under3460> output.csv
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(echo $i | grep -o -E "[^/]+\.log" | grep -o -E "[^.log]+")
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]")
	CPU=$(grep -E "Elapsed time. \d+" -o out/$analysis.out)	
	Nruns=$(grep -o -E "BEGIN: *[0-9]." $i | head -n1 | grep -o -E "[0-9]+") 
	Nfails=$(grep "max number of failed proposals" $i | cut -d , -f1 | grep -o -E "[0-9]+")
	fabs=$(grep -E "ftolAbs" $i | head -n1 | cut -d , -f2 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?")
	frel=$(grep -E "ftolRel" $i | head -n1 | cut -d , -f1 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?")
	xtolAbs=$(grep -E "xtolAbs" $i | head -n1 | cut -d , -f1 | grep -E -o "[0-9]\.[0-9]+")
	xtolRel=$(grep -E "xtolRel" $i | head -n1 | cut -d , -f2 | grep -E -o "[0-9]\.[0-9]+")
	Seed=$(sed -n '9p' $i | head -n1 | grep -o -E "[0-9]+")
	under3460=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i | for i in $i do if [ $under3460 -lt 3460 ] then echo "A" fi done)
	echo "analysis=$analysis ; h=$h ; CPU=$CPU ; Nruns=$Nruns ; Nfails=$Nfails ; fabs=$fabs ; frel=$frel ; xtolAbs=$xtolAbs ; xtolRel=$xtolRel ; Seed=$Seed ; under3460=$under3460"
    echo "$analysis,$h,$CPU,$Nruns,$Nfails,$fabs,$frel,$xtolAbs,$xtolRel,$Seed,$under3460" >> output.csv	

done

