#!/bin/bash

icetime -tmd hx8k -p top.pcf -P tq144 $(find *.asc | head -n 1) | grep -o -P '(?<=\().*(?=MHz)' | tr ' ' ',' >> timing.csv
