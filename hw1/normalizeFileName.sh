#!/bin/bash

for i in {1..9};do  
cp timetest${i}_snaq.out timetest0${i}_snaq.out
rm timetest${i}_snaq.out
done
