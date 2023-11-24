#!/bin/bash

# Set the path to the file that will store the run count in /var/run directory
count_file="run_count.txt"

# Initialize the count file if it doesn't exist
if [ ! -f "$count_file" ]; then
  echo "0" > "$count_file"
fi

# Read the current run count from the file
run_count=$(<"$count_file")

# Increment the run count
((run_count++))

# Write the updated run count back to the file
echo "$run_count" > "$count_file"

# Check if it's the third run and exit with an error if true
if [ "$((run_count % 3))" -gt 0 ]; then
  echo "Failing on the  run!"
  exit 1
fi

# Your script logic goes here
echo "Script is running successfully on run $run_count"
