#!/bin/bash

find ./sample -name "*.csv" -type f | xargs paste -d '' > data_summary.csv
