#!/bin/bash

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

process_file() {
    input="$1"
    output_dir="$(dirname "$input")"
    filename="$(basename "$input")"
    base="${filename%.*}"
    ext="${filename##*.}"
    output="${output_dir}/${base}-stream-ready.${ext}"

    ffmpeg -i "$input" -c:v libx264 -preset slow -crf 18 -c:a copy -pix_fmt yuv420p "$output"
    echo "Created: $output"
}

for input in "$@"; do
    [ -e "$input" ] || continue
    if [ -d "$input" ]; then
        # It's a directory: process all .mp4/.MP4 files inside
        shopt -s nullglob
        for vid in "$input"/*.mp4 "$input"/*.MP4; do
            [ -e "$vid" ] || continue
            process_file "$vid"
        done
        shopt -u nullglob
    else
        # It's a file: process directly
        process_file "$input"
    fi
done