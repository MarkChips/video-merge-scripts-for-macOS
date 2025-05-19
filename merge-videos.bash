#!/bin/bash

# Ensure ffmpeg is found (adjust for your system if needed)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

process_files() {
    local files=("$@")
    local firstfile="${files[0]}"
    local DATE

    # Get the filesystem creation date (DD-MM-YYYY)
    DATE=$(stat -f %SB -t "%d-%m-%Y" "$firstfile")

    local output_dir
    output_dir="$(dirname "$firstfile")"
    local output_name="${DATE}.MP4" # Output file name
    local output_path="${output_dir}/${output_name}"

    # Prevent overwrite
    local count=1
    while [[ -e "$output_path" ]]; do
        output_name="${DATE}_$count.MP4"
        output_path="${output_dir}/${output_name}"
        ((count++))
    done

    # Create a temporary file list for ffmpeg
    local tmpfile
    tmpfile=$(mktemp)
    for f in "${files[@]}"; do 
        echo "file '$f'" >> "$tmpfile"
    done

    # Combine the files
    ffmpeg -f concat -safe 0 -i "$tmpfile" -c copy "$output_path"
    rm "$tmpfile"
    echo "Created: $output_path"
}

for input in "$@"; do
    [ -e "$input" ] || continue
    if [ -d "$input" ]; then
        # It's a directory: process all .MP4 files inside
        shopt -s nullglob
        vids=("$input"/*.MP4)
        if [[ ${#vids[@]} -gt 0 ]]; then
            process_files "${vids[@]}"
        fi
        shopt -u nullglob
    else
        # It's a file: process directly
        process_files "$input"
    fi
done