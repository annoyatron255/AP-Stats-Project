#!/bin/bash

num_trials=50

make_dir=./icebreaker-fizzbuzz/fizzbuzz
data_file=fizzbuzz.csv

pcf_file=$(find . -type f -name *.pcf | head -n 1)
asc_file=$(find . -type f -name *.asc | head -n 1)

echo '"'$make_dir'"," ",' > $data_file

echo '"make execution time (sec)","PNR design speed (MHz)",' >> $data_file

for i in `seq 1 $num_trials`;
do
	make -C $make_dir clean
	SECONDS=0
	make -C $make_dir
	printf $SECONDS, >> $data_file
	cat ./icebreaker-fizzbuzz/fizzbuzz/fizzbuzz.rpt | \
		grep -o -P '(?<=\().*(?=MHz)' | tr ' ' ',' >> $data_file
done
