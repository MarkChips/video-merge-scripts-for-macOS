#!/bin/bash

# Ensure ffmpeg is found (adjust for your system if needed)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Check if the first argument ($1) is empty; if so, print usage instructions and exit
if [ -z "$1" ]; then 
	echo "Usage: $0 <directory>"
	exit 1
fi

# Attempt to change directory to the one specified by $1; if it fails, print an error and exit
cd "$1" || { echo "Cannot cd to $1"; exit 1; }

# Check if ffmpeg is installed and available in the PATH; if not, print an error and exit
command -v ffmpeg >/dev/null 2>&1 || { echo "ffmpeg not found. Please install it."; exit 1; }

# Create an array of all .MP4 files in the current directory; if empty, print an error and exit
shopt -s nullglob
mp4files=(./*.MP4)
if [ ${#mp4files[@]} -eq 0 ]; then 
	echo "No .mp4 files found in $1"
	exit 1
fi

# Remove videos2bmerged.txt if already present in folder
rm -f videos2bmerged.txt

# Build the concat list and find the first mp4 file
firstfile=""
for f in ./*.MP4; do
	echo "file '$f'" >> videos2bmerged.txt
	if [ -z "$firstfile" ]; then
		firstfile="$f"
	fi
done

# Get the filesystem creation date of the first file (DD-MM-YYYY)
DATE=$(stat -f %B "$firstfile" 2>/dev/null | xargs -I {} date -j -f %s {} +"%d-%m-%Y")
if [ -z "$DATE" ]; then 
	echo "Could not get creation date for $firstfile"
	exit 1
fi

# Output file name
final_filename="${DATE}.MP4"

# Concatenate the videos
ffmpeg -f concat -safe 0 -i videos2bmerged.txt -c copy "$final_filename"

# Clean up
rm videos2bmerged.txt