#!/bin/bash

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

for input in "$@"; do
    [ -e "$input" ] || continue
    output_dir="$(dirname "$input")"
    filename="$(basename "$input")"
    base="${filename%.*}"
    ext="${filename##*.}"
    output="${output_dir}/${base}-stream-ready.${ext}"

    ffmpeg -i "$input" -c:v libx264 -preset slow -crf 18 -c:a copy -pix_fmt yuv420p "$output"
    echo "Created: $output"
done