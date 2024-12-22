#!/bin/bash

ROOT_DIR=`pwd`
for dir1 in "$ROOT_DIR"/*/; do
	if [[ ! -f "$dir1/ICONST" ]]; then
		continue
	fi

    ICONST_CONTENT=$(<"$dir1/ICONST")

    for dir2 in "$ROOT_DIR"/*/; do
        if [[ "$dir1" == "$dir2" ]]; then
            continue
        fi

        if [[ -f "$dir2/ICONST" ]]; then
            OTHER_ICONST_CONTENT=$(<"$dir2/ICONST")
            if [[ "$ICONST_CONTENT" == "$OTHER_ICONST_CONTENT" ]]; then
                echo "Duplicate ICONST found:"
                echo "$dir1/ICONST"
                echo "$dir2/ICONST"
				echo ""
            fi
        fi
    done
done
