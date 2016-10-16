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

echo analysis,Hmax,CPU,Nruns,Nfails,fabs,frel,xtolAbs,xtolRel,Seed> output.csv
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(basename $i | cut -d. -f1)  ## Analysis using basename function
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]") 
	CPU=$(grep -E "Elapsed time. \d+" -o out/$analysis.out | grep -o -E "[0-9]+")	### Only the value of CPU
	Nruns=$(grep -o -E "BEGIN: *[0-9]." $i | head -n1 | grep -o -E "[0-9]+") 
	Nfails=$(grep "max number of failed proposals" $i | cut -d , -f1 | grep -o -E "[0-9]+")
	## The next two variables have complex number, for this reason the second grep is so extended, could be improved
	fabs=$(grep -E "ftolAbs" $i | head -n1 | cut -d , -f2 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?") 
	frel=$(grep -E "ftolRel" $i | head -n1 | cut -d , -f1 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?")
	xtolAbs=$(grep -E "xtolAbs" $i | head -n1 | cut -d , -f1 | grep -E -o "[0-9]\.[0-9]+")
	xtolRel=$(grep -E "xtolRel" $i | head -n1 | cut -d , -f2 | grep -E -o "[0-9]\.[0-9]+")
	Seed=$(sed -n '9p' $i | head -n1 | grep -o -E "[0-9]+") ## Use of sed function to take information from line 9 and thhen grep the      	                                                                  seed number
# My objective of this part is to get the information loglik using sed and then generate a loop with functions for and if you allow me to # classify each of the values in smaller or greater than 3460, 3450 and 3460 (something like if [$ i -lt 3460] then I echo "1" else echo  # "0" fi]). This way you could get a new variable from 0 and 1, by adding the 1's could get the number of "successes" in each row. The    # first part works fine and I get all loglik values per row,however I'm having trouble posting the required information. I appreciate if # someone can help me with this.
#   under3460=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i echo | for i in $i do echo "i=$i" if [ $i -lt "3460" ] then echo "1" else echo "0" fi done)
#   under3450=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i echo | for i in $i do echo "i=$i" if [ $i -lt "3450" ] then echo "1" else echo "0" fi done)
#   under3440=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i echo | for i in $i do echo "i=$i" if [ $i -lt "3440" ] then echo "1" else echo "0" fi done)
	echo "analysis=$analysis ; h=$h ; CPU=$CPU ; Nruns=$Nruns ; Nfails=$Nfails ; fabs=$fabs ; frel=$frel ; xtolAbs=$xtolAbs ; xtolRel=$xtolRel ; Seed=$Seed"
        echo "$analysis,$h,$CPU,$Nruns,$Nfails,$fabs,$frel,$xtolAbs,$xtolRel,$Seed" >> output.csv	
done

# When I solve this problem I'm planning to add the 3 variables to the script and get the complete table.




