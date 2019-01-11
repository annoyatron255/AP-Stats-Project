#!/bin/bash

for i in `seq 1 10`;
do
	make clean
	make
	icetime -tmd hx8k -p $(find *.pcf | head -n 1) -P tq144 $(find *.asc | head -n 1) | grep -o -P '(?<=\().*(?=MHz)' | tr ' ' ',' >> timing.csv
done
