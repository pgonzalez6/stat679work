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