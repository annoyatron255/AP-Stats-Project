#!/bin/bash

num_trials=50

#make_dir=$(find . -mindepth 1 -maxdepth 1 -type d | head -n 1)
make_dir=./hdl/syn
data_file=hdl.csv

pcf_file=./hdl/syn/top_level.pcf
asc_file=./hdl/syn/top_level.asc

echo '"'$make_dir'"," ",' > $data_file

echo '"make execution time (sec)","PNR design speed (MHz)",' >> $data_file

for i in `seq 1 $num_trials`;
do
	make -C $make_dir clean
	SECONDS=0
	make -C $make_dir
	printf $SECONDS, >> $data_file
	icetime -tmd hx8k -p $pcf_file -P tq144 $asc_file | \
		grep -o -P '(?<=\().*(?=MHz)' | tr ' ' ',' >> $data_file
done
