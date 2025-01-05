#!/bin/bash

search_triplets() {
  local triplets=("$@")
  local not_found_triplets=()

  for triplet in "${triplets[@]}"; do
    set -- $triplet
    local first=$(( $1 + 1 ))
    local second=$(( $2 + 1 ))
    local third=$(( $3 + 1 ))

    local pattern1="${first}.*${second}|${second}.*${first}"
    local pattern2="${first}.*${third}|${third}.*${first}"

    local dirs=$(ls -d */ 2>/dev/null | sort -V)
    if [[ -z "$dirs" ]]; then
      echo "No directories found!"
      return
    fi

    local found=false
    for dir in $dirs; do
      dir="${dir%/}"
      local found_first_line=false
      local found_second_line=false
      if [[ -d "$dir" ]]; then
        cd "$dir" || continue
        if grep -qE "$pattern1" ICONST 2>/dev/null; then
          found_first_line=true
        fi
        if grep -qE "$pattern2" ICONST 2>/dev/null; then
          found_second_line=true
        fi

        if $found_first_line && $found_second_line; then
          echo "Processing directory: $dir"
          echo "Found full triplet: [ $1, $2, $3 ]"
          found=true
        fi
        cd ../
      fi
    done

    if ! $found; then
      not_found_triplets+=("[ $1, $2, $3 ]")
    fi
  done

  if [[ ${#not_found_triplets[@]} -gt 0 ]]; then
    echo "Triplets not found: ${not_found_triplets[*]}"
  fi
}

echo -e "\e[43mStarting Search...\e[0m"
search_triplets " 75 116 187" "96 162 186" "74 120 189" "96 162 190" "75 145 187" "103 178 195" "103 178 195" "96 162 197" "95 126 196" "95 167 196" " 12 3 4"
