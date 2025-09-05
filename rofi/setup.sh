#!/usr/bin/env zsh

# Rofi Launcher Scripts Setup

echo "🚀 Setting up rofi launcher scripts..."

mkdir -p ~/.local/bin
mkdir -p ~/.local/share

# Copy symbols.txt if it exists
if [[ -f ./symbols.txt ]]; then
    cp ./symbols.txt ~/.local/share/symbols.txt
    echo "📋 Copied symbols.txt to ~/.local/share"
else
    echo "⚠️  Warning: symbols.txt not found in current directory"
fi

# rofi-run
printf '#!/bin/bash\nrofi -show run -modi "run" -display-run ""\n' > ~/.local/bin/rofi-run
chmod +x ~/.local/bin/rofi-run
echo "📝 Created rofi-run"

# rofi-files
printf '#!/bin/bash\nrofi -show filebrowser -modi "filebrowser" -display-filebrowser ""\n' > ~/.local/bin/rofi-files
chmod +x ~/.local/bin/rofi-files
echo "📁 Created rofi-files"

# rofi-apps
printf '#!/bin/bash\nrofi -show drun -modi "drun,window"\n' > ~/.local/bin/rofi-apps
chmod +x ~/.local/bin/rofi-apps
echo "🎯 Created rofi-apps"

# emoji-picker
printf '#!/bin/bash\ncat ~/.local/share/symbols.txt | rofi -dmenu -p "Emoji" -i | awk '\''{\''print $1}'\'' | tr -d '\''\n'\'' | xclip -selection clipboard\n' > ~/.local/bin/emoji-picker
chmod +x ~/.local/bin/emoji-picker
echo "😀 Created emoji-picker"

echo ""
echo "✅ All rofi launcher scripts created successfully!"
echo ""
echo "📋 Next steps: Set up keyboard shortcuts:"
echo "   Alt + Space → ~/.local/bin/rofi-apps"
echo "   Win + R     → ~/.local/bin/rofi-run" 
echo "   Win + F     → ~/.local/bin/rofi-files"
echo "   Win + .     → ~/.local/bin/emoji-picker"
echo ""


