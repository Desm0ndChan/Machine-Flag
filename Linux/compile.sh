#!/bin/bash

# An array of machine names
machines=("machine1" "machine2" "machine3")

# Parse the file into a csv format with a for loop
for machine in "${machines[@]}"
do
    cat "$machine"/"$machine".bak | grep -v easy | awk -F "\t" '{print $2,$3,$4}' | sed "s/ /,/g" > "$machine"/"$machine".csv
    echo "content check of $machine:"
    cat "$machine"/"$machine".csv
    echo "$machine".csv line count:
    wc -l "$machine"/"$machine".csv
done