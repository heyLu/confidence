#!/bin/sh

set -u

working_time=$1
csv_file=$2

today=$(date --iso-8601=date)

touch $csv_file
sed -n '$p' $csv_file | grep $today &> /dev/null || echo >> $csv_file
sed -i "\$s/.*/$today,$working_time/" $csv_file
