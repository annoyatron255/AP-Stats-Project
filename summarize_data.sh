#!/bin/bash

find . -name "*.csv" -type f | xargs paste -d '' > data_summary.csv
