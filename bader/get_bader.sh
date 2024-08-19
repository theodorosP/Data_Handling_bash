#!/bin/bash

CHGSUM_PATH="/u/trahman/shared/bader/chgsum.pl"
BADER_PATH="/u/trahman/shared/bader/bader"

$CHGSUM_PATH AECCAR0 AECCAR2

# Check if CHGCAR_sum was created successfully
if [ ! -f "CHGCAR_sum" ]; then
    echo "Error: CHGCAR_sum file was not created."
    exit 1
fi

$BADER_PATH CHGCAR -ref CHGCAR_sum

if [ $? -ne 0 ]; then
    echo "Error: Bader analysis failed."
    exit 1
fi

echo "Bader analysis completed successfully."
