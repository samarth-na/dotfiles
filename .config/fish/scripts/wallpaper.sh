#!/bin/bash
# save as ~/.local/bin/random-wallpaper.sh

WALLPAPER_DIR="$HOME/Desktop/custom/wallpapers/"

# Find random image (supports jpg, png, jpeg, webp, gif)
PICTURE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Check if a picture was found
if [ -z "$PICTURE" ]; then
    echo "No pictures found in $WALLPAPER_DIR"
    exit 1
fi

# Set wallpaper (works on Fedora 43 with GNOME)
gsettings set org.gnome.desktop.background picture-uri "file://$PICTURE"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$PICTURE"

# Optional: Show notification
notify-send "Wallpaper Changed" "New wallpaper: $(basename "$PICTURE")" -t 3000
