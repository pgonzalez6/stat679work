#!/bin/bash

for i in {1..13};do 
grep "hmax" log/timetest${i}_snaq.log 
grep "hmax" out/timetest${i}_snaq.out	
done




