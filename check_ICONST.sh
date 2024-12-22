#!/bin/bash

# Define the root directory (modify as needed)
ROOT_DIR=`pwd`

# Traverse all subdirectories in the root directory
for dir1 in "$ROOT_DIR"/*/; do
    # Skip if no ICONST file exists in the current subdirectory
    if [[ ! -f "$dir1/ICONST" ]]; then
        continue
    fi

    # Read the contents of the ICONST file in the current subdirectory
    ICONST_CONTENT=$(<"$dir1/ICONST")

    # Compare with ICONST files in other subdirectories
    for dir2 in "$ROOT_DIR"/*/; do
        # Skip the current directory itself
        if [[ "$dir1" == "$dir2" ]]; then
            continue
        fi

        # Check if ICONST exists in the other directory
        if [[ -f "$dir2/ICONST" ]]; then
            # Read the contents of the ICONST file in the other subdirectory
            OTHER_ICONST_CONTENT=$(<"$dir2/ICONST")

            # Compare the contents
            if [[ "$ICONST_CONTENT" == "$OTHER_ICONST_CONTENT" ]]; then
                # Print paths of the matching ICONST files
                echo "Duplicate ICONST found:"
                echo "$dir1/ICONST"
                echo "$dir2/ICONST"
				echo ""
            fi
        fi
    done
done
