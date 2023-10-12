#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

# Function to rename PDF files
rename_pdf_files() {
    local folder_path="$1"
    find "$folder_path" -type f -name "*.pdf" | while IFS= read -r file; do
        # Extract directory and file names
        dir=$(dirname "$file")
        base=$(basename -- "$file")
        extension="${base##*.}"
        filename="${base%.*}"

        # Remove commas from the filename
        filename=$(echo "$filename" | tr -d ',')

        # Extract parent folder name
        parent_folder=$(basename "$dir")

        # Pad the number with zeros if it is a number
        if [[ $filename =~ ^[0-9]+$ ]]; then
            filename=$(printf "%03d" "$filename")
        fi

        # Create new filename
        new_filename="$parent_folder $filename.$extension"

        # Rename the file
        mv "$file" "$dir/$new_filename"

        echo "$dir/$new_filename"
    done
}

# Call the function with the provided folder path
rename_pdf_files "$1"

