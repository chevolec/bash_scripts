#!/bin/bash

# Directory containing CDR files
cdr_directory="/tmp/cdr_files"

# Check if the directory exists
if [ ! -d "$cdr_directory" ]; then
    echo "Error: CDR directory not found."
    exit 1
fi

# Convert CDR files to JPG
for cdr_file in "$cdr_directory"/*.cdr; do
    if [ -f "$cdr_file" ]; then
        file_name=$(basename "$cdr_file" .cdr)
        output_file="$cdr_directory/$file_name.jpg"
        inkscape --export-type=png --export-filename="$output_file" "$cdr_file" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Converted $cdr_file to $output_file"
        else
            echo "Error converting $cdr_file"
        fi
    fi
done

