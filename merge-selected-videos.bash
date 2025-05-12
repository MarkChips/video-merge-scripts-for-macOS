#!/bin/bash

# Ensure ffmpeg is found (adjust for your system if needed)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Get the first selected file
firstfile="$1"

# Get the filesystem creation date (DD-MM-YYYY)
DATE=$(stat -f %SB -t "%d-%m-%Y" "$firstfile")

output_dir="$(dirname "$firstfile")"
output_name="${DATE}.MP4" # Output file name
output_path="${output_dir}/${output_name}"

# Create a temporary file list for ffmpeg
tmpfile=$(mktemp)
for f in "$@"; do 
	echo "file '$f'" >> "$tmpfile"
done

# Combine the files
ffmpeg -f concat -safe 0 -i "$tmpfile" -c copy "$output_path"

# Clean up
rm "$tmpfile"