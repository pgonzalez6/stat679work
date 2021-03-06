#!/bin/bash 

echo analysis,Hmax,CPU,Nruns,Nfails,fabs,frel,xtolAbs,xtolRel,Seed,under3440,under3450,under3460> output.csv
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
#the objective here is generate the count variables for under3440,3450 and 3460
    sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i > t1.txt
	under3440=0
    under3450=0
    under3460=0
    for i in $(cat t1.txt)
    do
      if [ $i -lt 3440 ] 
      then
        ((under3440=under3440+1))
        ((under3450=under3450+1))
        ((under3460=under3460+1))
      elif [ $i -lt 3450 ]
      then
        ((under3440=under3440+1))
        ((under3450=under3450+1))
      elif [ $i -lt 3460 ]
      then
        ((under3440=under3440+1))
      fi
    done

	echo "analysis=$analysis ; h=$h ; CPU=$CPU ; Nruns=$Nruns ; Nfails=$Nfails ; fabs=$fabs ; frel=$frel ; xtolAbs=$xtolAbs ; xtolRel=$xtolRel ; Seed=$Seed ; a=$under3440 ; b=$under3450 ; c=$under3460 "
    echo "$analysis,$h,$CPU,$Nruns,$Nfails,$fabs,$frel,$xtolAbs,$xtolRel,$Seed,$under3440,$under3450,$under3460" >> output.csv	

done




