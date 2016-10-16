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
	fabs=$(grep -E "ftolAbs" $i | head -n1 | cut -d , -f2 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?")
	frel=$(grep -E "ftolRel" $i | head -n1 | cut -d , -f1 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?")
	xtolAbs=$(grep -E "xtolAbs" $i | head -n1 | cut -d , -f1 | grep -E -o "[0-9]\.[0-9]+")
	xtolRel=$(grep -E "xtolRel" $i | head -n1 | cut -d , -f2 | grep -E -o "[0-9]\.[0-9]+")
	Seed=$(sed -n '9p' $i | head -n1 | grep -o -E "[0-9]+") ## Use of sed function to take information from line 9 and thhen grep the seed number
#My objective of this part is to get the information loglik using sed and then generate a loop with functions for and if you allow me to classify each of 
#the values in smaller or greater than 3460, 3450 and 3460 (something like if [$ i -lt 3460] then I echo "1" else echo "0" fi]). This way you could get a 
#new variable from 0 and 1, by adding the 1's could get the number of "successes" in each row. The first part works fine and I get all loglik values per row,
#however I am having trouble posting the required information. I appreciate if someone can help me with this.
#   under3460=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i echo | for i in $i do echo "i=$i" if [ $i -lt "3460" ] then echo "1" else echo "0" fi done)
#   under3460=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i echo | for i in $i do echo "i=$i" if [ $i -lt "3460" ] then echo "1" else echo "0" fi done)
#   under3460=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i echo | for i in $i do echo "i=$i" if [ $i -lt "3460" ] then echo "1" else echo "0" fi done)
	echo "analysis=$analysis ; h=$h ; CPU=$CPU ; Nruns=$Nruns ; Nfails=$Nfails ; fabs=$fabs ; frel=$frel ; xtolAbs=$xtolAbs ; xtolRel=$xtolRel ; Seed=$Seed"
    echo "$analysis,$h,$CPU,$Nruns,$Nfails,$fabs,$frel,$xtolAbs,$xtolRel,$Seed" >> output.csv	

done




