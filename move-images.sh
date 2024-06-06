#!/bin/sh

# Variables for directories
repo_url="https://github.com/odoo/documentation"
branch="16.0"
src_directory="./src"
input_directory="$src_directory/content"

# Delete the src directory if it exists to avoid conflicts
if [ -d "$src_directory" ]; then
    rm -rf "$src_directory"
fi

# Cloner le dépôt Odoo
git clone -b "$branch" "$repo_url" "$src_directory"

# Check if cloning was successful
if [ ! -d "$input_directory" ]; then
    echo "Error: Repository cloning failed or directory 'content' not found."
    exit 1
fi

echo "Repository cloning completed successfully."

# Specify the directory you want to search in and the output directory
DIR="src/content"
OUTPUT_DIR="img"

find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | while read FILE; do
    # Create the target directory if it doesn't exist
    mkdir -p "$(dirname "${FILE/$DIR/$OUTPUT_DIR}")"
    # Copy the file to the output directory, preserving the structure
    cp "$FILE" "${FILE/$DIR/$OUTPUT_DIR}"
done