#!/bin/bash

search_pairs() {
  local pairs=("$@")
  local pattern=""
  local not_found=()

  for pair in "${pairs[@]}"; do
    set -- $pair
    local first=$(( $1 + 1 ))
    local second=$(( $2 + 1 ))
    pattern+="(${first}.*${second}|${second}.*${first})|"
  done
  pattern=${pattern%|}

  local dirs=$(ls -d */ 2>/dev/null | sort -V)
  if [[ -z "$dirs" ]]; then
    echo "No directories found!"
    return
  fi

  for dir in $dirs; do
    dir="${dir%/}"
    if [[ -d "$dir" ]]; then
      cd "$dir" || continue
      echo "Processing directory: $dir"
      local var=$(grep -E "$pattern" ICONST 2>/dev/null)
      if [[ -n "$var" ]]; then
        pwd
        echo "$var"
      fi
      cd ../
    else
      echo "Directory not found: $dir"
    fi
  done

  for pair in "${pairs[@]}"; do
    set -- $pair
    local first=$(( $1 + 1 ))
    local second=$(( $2 + 1 ))
    local found=false
    for dir in $dirs; do
      dir="${dir%/}"
      if [[ -d "$dir" ]]; then
        cd "$dir" || continue
        if grep -qE "(${first}.*${second}|${second}.*${first})" ICONST 2>/dev/null; then
          found=true
          cd ../
          break
        fi
        cd ../
      fi
    done
    if ! $found; then
      not_found+=("[ $1, $2 ]")
    fi
  done

  if [[ ${#not_found[@]} -gt 0 ]]; then
    echo "Pairs not found: ${not_found[*]}"
  fi
}

echo -e "\e[43mStarting Search...\e[0m"
search_pairs "82 124" "82 135" "86 148" "86 170" "92 156" "92 160" "97 164" "97 183" "70 119" "73 125"
