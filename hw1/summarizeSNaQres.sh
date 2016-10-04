#!/bin/bash

### At first get hmax from each file
for i in {1..13};do 
grep "hmax" log/timetest${i}_snaq.log 
grep "hmax" out/timetest${i}_snaq.out	

### print the CPU time 
ps -e -o %cpu | awk '{s+=$1} END {print s}' 
>outputs.csv
done




