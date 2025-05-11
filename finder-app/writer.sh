#!/bin/bash

# Check for required arguments
if [ $# -lt 2 ]; then
  echo "Error: Missing arguments. Usage: writer.sh <writefile> <writestr>"
  exit 1
fi

writefile=$1
writestr=$2

# Extract the directory path from the file path
dirpath=$(dirname "$writefile")

# Create the directory if it doesn't exist
mkdir -p "$dirpath"

# Try to write to the file
echo "$writestr" > "$writefile"
if [ $? -ne 0 ]; then
  echo "Error: Failed to create or write to file '$writefile'"
  exit 1
fi

exit 0

