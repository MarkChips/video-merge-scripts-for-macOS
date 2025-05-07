export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

firstfile="$1"

DATE=$(stat -f %SB -t "%d-%m-%Y" "$firstfile")

output_dir="$(dirname "$firstfile")"
output_name="${DATE}.MP4"
output_path="${output_dir}/${output_name}"

tmpfile=$(mktemp)
for f in "$@"; do 
	echo "file '$f'" >> "$tmpfile"
done

ffmpeg -f concat -safe 0 -i "$tmpfile" -c copy "$output_path"

rm "$tmpfile"