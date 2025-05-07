# Video Merge Scripts for macOS

This repository contains two Bash scripts for merging video files using FFmpeg on macOS:

- **merge-videos-in-folder.bash** - Merge all videos in a selected folder.
- **merge-selected-videos.bash** - Merge specific videos selected by the user.

Both scripts are designed for easy integration with Automator or Terminal usage and are compatible with `.MP4` files.

---

## Requirements

- [FFmpeg](https://ffmpeg.org/) (Install via [Homebrew](https://brew.sh/): `brew install ffmpeg`)
- macOS (tested on Monterey and later)

---

## Scripts Overview

### 1. `merge-videos-in-folder.bash`

**Description:**  
Merges all `.MP4` files in a specified folder into a single video file. The output file is named using the creation date of the first video in the folder.

**Usage:**

```bash
bash merge-videos-in-folder.bash /path/to/your/folder
```

**Features:**

- Automatically finds all `.MP4` files in the folder.
- Names the merged file using the creation date of the first video.
- Handles errors gracefully (missing folder, no videos, missing ffmpeg).
- Output is saved in the same folder.

---

### 2. `merge-selected-videos.bash`

**Description:**  
Merges a user-selected set of video files into one, in the order they are selected. The output file is named using the creation date of the first selected video.

**Usage:**

```bash
bash merge-selected-videos.bash /path/to/video1.MP4 /path/to/video2.MP4 ...
```

**Features:**

- Accepts multiple video files as arguments.
- Merges videos in the order provided.
- Names the merged file using the creation date of the first selected video.
- Output is saved in the same directory as the first selected file.

---

## Integration with Automator (Optional)

Both scripts can be used as Automator **Quick Actions** for seamless Finder integration:

- **merge-videos-in-folder.bash:**  
  Set to receive folders as input.
- **merge-selected-videos.bash:**  
  Set to receive files as input.

For a more full guide check out: [2b3pro/ffmpeg_merge_videos_in_folder.md](https://gist.github.com/2b3pro/39f473bc663fe49ce04530aded73cf0d)

**Tip:**  
Ensure the script is executable:

```bash
chmod +x merge-videos-in-folder.bash
chmod +x merge-selected-videos.bash
```

---

## Troubleshooting

- **FFmpeg not found:**  
  Make sure `/usr/local/bin` or `/opt/homebrew/bin` is in your PATH, or edit the script to use the full path to ffmpeg.
- **No output file:**  
  Check that your input files have compatible codecs and extensions (`.MP4`).
- **Unexpected errors:**  
  Review the debug log (if enabled) or run the script in Terminal for detailed error messages.

---

## License

MIT License

---

## Credits

Script and README by Mark Chipperfield.  
Inspired by: [2b3pro/ffmpeg_merge_videos_in_folder.md](https://gist.github.com/2b3pro/39f473bc663fe49ce04530aded73cf0d)
