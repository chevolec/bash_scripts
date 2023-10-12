#!/bin/bash

############################################################
# Rename file replacing spaces with underscore if no       #
# argument is send                                         #
############################################################

# Check if at least one argument is provided (file name)
if [ $# -lt 1 ]; then
    echo "Usage: $0 <file_name> [character_to_replace] [replacement_character]"
    exit 1
fi

# Get the file name from the first command-line argument
file="$1"

# Check if replacement characters are provided, otherwise use default values
if [ $# -ge 3 ]; then
    replace_char="$2"
    replace_with="$3"
else
    # If no parameters are provided, set default replacement character to space and replacement with character to underscore
    replace_char=" "
    replace_with="_"
fi

# Function to replace characters in the file name
function replace_characters {
    local file="$1"
    local new_name=$(echo "$file" | tr "$replace_char" "$replace_with")
    mv "$file" "$new_name"
    echo "$new_name"
}

# Check if the specified file exists
if [ -e "$file" ]; then
    replace_characters "$file"
else
    echo "Error: File '$file' not found."
fi

