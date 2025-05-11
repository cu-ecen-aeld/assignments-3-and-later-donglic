#!/bin/bash

# Check if both arguments are provided
if [ $# -lt 2 ]; then
  echo "Error: Missing arguments. Usage: finder.sh <filesdir> <searchstr>"
  exit 1
fi

filesdir=$1
searchstr=$2

# Check if filesdir is a valid directory
if [ ! -d "$filesdir" ]; then
  echo "Error: '$filesdir' is not a valid directory."
  exit 1
fi

# Count number of files
num_files=$(find "$filesdir" -type f | wc -l)

# Count number of matching lines
num_matches=$(grep -r "$searchstr" "$filesdir" | wc -l)

# Output the result
echo "The number of files are $num_files and the number of matching lines are $num_matches"
