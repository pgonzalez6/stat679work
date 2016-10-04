#!/bin/bash

for i in {1..9};do  
cp timetest${i}_snaq.log timetest0${i}_snaq.log
rm timetest${i}_snaq.log
done
