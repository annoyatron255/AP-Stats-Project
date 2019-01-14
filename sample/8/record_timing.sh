#!/bin/bash

num_trials=50

make_dir=./pmods/lcd_test
data_file=lcd_test.csv

pcf_file=./pmods/lcd_test/lcd_test.pcf
asc_file=./pmods/lcd_test/lcd_test.asc

echo '"'$make_dir'"," ",' > $data_file

echo '"make execution time (sec)","PNR design speed (MHz)",' >> $data_file

for i in `seq 1 $num_trials`;
do
	make -C $make_dir clean
	SECONDS=0
	make -C $make_dir lcd_test.asc
	printf $SECONDS, >> $data_file
	icetime -tmd hx8k -p $pcf_file -P tq144 $asc_file | \
		grep -o -P '(?<=\().*(?=MHz)' | tr ' ' ',' >> $data_file
done
