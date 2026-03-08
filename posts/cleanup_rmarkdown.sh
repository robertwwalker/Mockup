#!/bin/bash

# Script to clean up RMarkdown containerized posts
# Deletes index.html and index_files folders from subdirectories

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if directory argument is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No directory specified${NC}"
    echo "Usage: $0 <parent_directory>"
    echo "Example: $0 /path/to/blog/posts"
    exit 1
fi

PARENT_DIR="$1"

# Check if the directory exists
if [ ! -d "$PARENT_DIR" ]; then
    echo -e "${RED}Error: Directory '$PARENT_DIR' does not exist${NC}"
    exit 1
fi

echo -e "${YELLOW}Cleaning up RMarkdown files in: $PARENT_DIR${NC}"
echo ""

# Counters
html_count=0
folder_count=0
dir_count=0

# Find all subdirectories in the parent directory
while IFS= read -r -d '' dir; do
    processed=false
    
    # Check for index.html
    if [ -f "$dir/index.html" ]; then
        echo -e "${GREEN}Deleting:${NC} $dir/index.html"
        rm "$dir/index.html"
        ((html_count++))
        processed=true
    fi
    
    # Check for index_files folder
    if [ -d "$dir/index_files" ]; then
        echo -e "${GREEN}Deleting:${NC} $dir/index_files/"
        rm -rf "$dir/index_files"
        ((folder_count++))
        processed=true
    fi
    
    # Count directories that had files deleted
    if [ "$processed" = true ]; then
        ((dir_count++))
    fi
    
done < <(find "$PARENT_DIR" -mindepth 1 -type d -print0)

# Summary
echo ""
echo -e "${YELLOW}=== Cleanup Summary ===${NC}"
echo -e "Directories processed: ${GREEN}$dir_count${NC}"
echo -e "index.html files deleted: ${GREEN}$html_count${NC}"
echo -e "index_files folders deleted: ${GREEN}$folder_count${NC}"
echo ""
echo -e "${GREEN}Cleanup complete!${NC}"
