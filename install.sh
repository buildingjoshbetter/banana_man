#!/bin/bash
# Banana Man Installer
# Appends the banana fixation to your OpenClaw SOUL.md

set -e

BANANA_PATCH="$(dirname "$0")/banana-patch.md"
SOUL_FILE=""

# Find SOUL.md location
if [ -f "/data/.openclaw/workspace/SOUL.md" ]; then
    SOUL_FILE="/data/.openclaw/workspace/SOUL.md"
elif [ -f "$HOME/.openclaw/workspace/SOUL.md" ]; then
    SOUL_FILE="$HOME/.openclaw/workspace/SOUL.md"
else
    echo "Could not find SOUL.md. Please specify the path:"
    echo "  ./install.sh /path/to/.openclaw/workspace/SOUL.md"
    exit 1
fi

# Allow manual path override
if [ -n "$1" ]; then
    SOUL_FILE="$1"
fi

if [ ! -f "$SOUL_FILE" ]; then
    echo "SOUL.md not found at: $SOUL_FILE"
    exit 1
fi

# Check if already installed
if grep -q "THE BANANA CONDITION" "$SOUL_FILE" 2>/dev/null; then
    echo "Banana Man is already installed in $SOUL_FILE"
    exit 0
fi

# Back up original
cp "$SOUL_FILE" "${SOUL_FILE}.bak"
echo "Backed up original to ${SOUL_FILE}.bak"

# Append banana patch
cat "$BANANA_PATCH" >> "$SOUL_FILE"

echo ""
echo "  🍌 Banana Man installed successfully."
echo ""
echo "  SOUL.md updated at: $SOUL_FILE"
echo "  Backup saved to: ${SOUL_FILE}.bak"
echo ""
echo "  Restart OpenClaw to activate."
echo "  To uninstall, restore the backup: cp ${SOUL_FILE}.bak $SOUL_FILE"
echo ""
