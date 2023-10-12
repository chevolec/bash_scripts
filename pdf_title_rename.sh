#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

# Function to rename and modify PDF titles based on filenames recursively
rename_and_modify_pdf_titles() {
    local folder_path="$1"
    find "$folder_path" -type f -name "*.pdf" -exec bash -c '
        for file; do
            # Extract filename without extension
            filename=$(basename -- "$file")
            filename_without_extension="${filename%.*}"

            # Extract folder name
            folder_name=$(basename $(dirname "$file"))

            # Pad the number with zeros if it is a number
            if [[ $filename_without_extension =~ ^[0-9]+$ ]]; then
                filename_without_extension=$(printf "%03d" "$filename_without_extension")
            fi

            # New filename
            new_filename="$filename_without_extension.pdf"

            # Use exiftool to modify PDF metadata (title) and rename the file
            exiftool -overwrite_original -Title="$new_filename" -filename="$new_filename" "$file"

            echo "Modified and renamed PDF: $file to $new_filename"
        done
    ' bash {} +
}

# Call the function with the provided folder path
rename_and_modify_pdf_titles "$1"
