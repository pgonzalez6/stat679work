#!/bin/bash 
exec >out.csv


### At first get hmax from each file
for i in {1..9};do 
grep "hmax" log/timetest0${i}_snaq.log 
grep "hmax" out/timetest0${i}_snaq.out	


### print the CPU time 
ps -e -o %cpu | awk '{s+=$1} END {print s}' 

done




