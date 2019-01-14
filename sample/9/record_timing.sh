#!/bin/bash

num_trials=50

make_dir=./verilog_tutorials_BB/project_18
data_file=project_18.csv

pcf_file=./verilog_tutorials_BB/project_18/iCE40.pcf
asc_file=./verilog_tutorials_BB/project_18/timing.asc

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
