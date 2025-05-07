export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

if [ -z "$1" ]; then 
	echo "Usage: $0 <directory>"
	exit 1
fi

cd "$1" || { echo "Cannot cd to $1"; exit 1; }

command -v ffmpeg >/dev/null 2>&1 || { echo "ffmpeg not found. Please install it."; exit 1; }

shopt -s nullglob
mp4files=(./*.MP4)
if [ ${#mp4files[@]} -eq 0 ]; then 
	echo "No .mp4 files found in $1"
	exit 1
fi

rm -f videos2bmerged.txt

firstfile=""
for f in ./*.MP4; do
  echo "file '$f'" >> videos2bmerged.txt
  if [ -z "$firstfile" ]; then
    firstfile="$f"
  fi
done

DATE=$(stat -f %B "$firstfile" 2>/dev/null | xargs -I {} date -j -f %s {} +"%d-%m-%Y")
if [ -z "$DATE" ]; then 
	echo "Could not get creation date for $firstfile"
	exit 1
fi


final_filename="${DATE}.MP4"

ffmpeg -f concat -safe 0 -i videos2bmerged.txt -c copy "$final_filename"

rm videos2bmerged.txt