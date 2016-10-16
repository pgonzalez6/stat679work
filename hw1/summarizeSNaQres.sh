#!/bin/bash 

echo analysis,Hmax,CPU,Nruns,Nfails,fabs,frel,xtolAbs,xtolRel,Seed,under3460> output.csv
for i in log/*.log;
do
	echo "i=$i" 
	analysis=$(echo $i | grep -o -E "[^/]+\.log" | grep -o -E "[^.log]+")
	h=$(grep "hmax" $i | head -n1 | grep -o -E "[0-9]")
	CPU=$(grep -E "Elapsed time. \d+" -o out/$analysis.out | grep -o -E "[0-9]+")	
	Nruns=$(grep -o -E "BEGIN: *[0-9]." $i | head -n1 | grep -o -E "[0-9]+") 
	Nfails=$(grep "max number of failed proposals" $i | cut -d , -f1 | grep -o -E "[0-9]+")
	fabs=$(grep -E "ftolAbs" $i | head -n1 | cut -d , -f2 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?")
	frel=$(grep -E "ftolRel" $i | head -n1 | cut -d , -f1 | grep -E -o "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?")
	xtolAbs=$(grep -E "xtolAbs" $i | head -n1 | cut -d , -f1 | grep -E -o "[0-9]\.[0-9]+")
	xtolRel=$(grep -E "xtolRel" $i | head -n1 | cut -d , -f2 | grep -E -o "[0-9]\.[0-9]+")
	Seed=$(sed -n '9p' $i | head -n1 | grep -o -E "[0-9]+")
	under3460=$(sed -nE 's/.*-loglik=([0-9,]+).*/\1/p' $i echo | for i in $i do echo "i=$i" if [ $i -lt "3460" ] then echo "1" else echo "0" fi done)
	echo "analysis=$analysis ; h=$h ; CPU=$CPU ; Nruns=$Nruns ; Nfails=$Nfails ; fabs=$fabs ; frel=$frel ; xtolAbs=$xtolAbs ; xtolRel=$xtolRel ; Seed=$Seed ; under3460=$under3460"
    echo "$analysis,$h,$CPU,$Nruns,$Nfails,$fabs,$frel,$xtolAbs,$xtolRel,$Seed,$under3460" >> output.csv	

done


###  for i in log/*.log do echo fi done



