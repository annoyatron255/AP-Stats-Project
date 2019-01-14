#!/bin/bash

num_trials=50

make_dir=$(find . -mindepth 1 -maxdepth 1 -type d | head -n 1)
data_file=$make_dir.csv

pcf_file=./iceZ0mb1e/pinmap/hx8k.pcf
asc_file=./iceZ0mb1e/synthesis/_fpga.txt

echo '"'$make_dir'"," ",' > $data_file

echo '"make execution time (sec)","PNR design speed (MHz)",' >> $data_file

for i in `seq 1 $num_trials`;
do
	make -C $make_dir clean
	SECONDS=0
	make -C $make_dir firmware TARGET=8k
	make -C $make_dir fpga TARGET=8k
	printf $SECONDS, >> $data_file
	icetime -tmd hx8k -p $pcf_file -P ct256 $asc_file | \
		grep -o -P '(?<=\().*(?=MHz)' | tr ' ' ',' >> $data_file
done
