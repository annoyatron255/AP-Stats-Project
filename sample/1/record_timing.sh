#!/bin/bash

num_trials=50

make_dir=./fpga/top/icestick
data_file=irda.csv

pcf_file=./fpga/top/icestick/irda.pcf
asc_file=./fpga/top/icestick/irda.blif.txt

echo '"'$make_dir'"," ",' > $data_file

echo '"make execution time (sec)","PNR design speed (MHz)",' >> $data_file

for i in `seq 1 $num_trials`;
do
	make -C $make_dir clean
	SECONDS=0
	make -C $make_dir
	printf $SECONDS, >> $data_file
	cat ./fpga/top/icestick/irda-time.txt | grep -o -P '(?<=\().*(?=MHz)' | tr ' ' ',' >> $data_file
done
