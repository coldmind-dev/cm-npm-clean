#!/usr/bin/env bash

# CM Node Module - Find/Remove
#
# License: GPL v2
# License URL: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
#
# Author: Patrik Forsberg <patrik.forsberg@coldmind.com>
# Date: 2022-10-12
#
# Website: https://www.coldmind.com
# Git Repository: https://github.com/coldmind-devhub/cm-npm-clean.git
#
# Please consider supporting the project by visiting the website or donating:
# Donate: https://www.paypal.com/donate/?hosted_button_id=N3T9FJWUQT44N
#

# Function to print usage information
print_usage() {
  echo "Usage:"
  echo "  $0 -f [-d /path/to/directory]          Find and list 'node_modules' directories and their sizes"
  echo "  $0 -r [-d /path/to/directory]          Remove 'node_modules' directories and show a summary of deleted space"
}

# Check if there are enough arguments
if [ $# -lt 1 ]; then
  print_usage
  exit 1
fi

# Initialize variables
action=""
target_dir="."

# Parse arguments
while [ "$#" -gt 0 ]; do
  case $1 in
    -f|-r)
      action=$1
      ;;
    -d)
      shift
      target_dir=$1
      ;;
    *)
      print_usage
      exit 1
      ;;
  esac
  shift
done

# Check if action is provided
if [ -z "$action" ]; then
  print_usage
  exit 1
fi

# Function to find and process 'node_modules' directories
process_node_modules() {
  local action=$1
  local target_dir=$2
  local total_size=0
  local count=0

  while IFS= read -r -d '' dir; do
    if [ "$action" = "-f" ]; then
      size=$(du -sh "$dir" | cut -f1)
      echo "$size - $dir"
    elif [ "$action" = "-r" ]; then
      size=$(du -sb "$dir" | cut -f1)
      rm -rf "$dir"
    fi

    total_size=$((total_size + size))
    count=$((count + 1))
  done < <(find "$target_dir" -name 'node_modules' -type d -prune -print0)

  if [ "$action" = "-f" ]; then
    echo "Total size: $(echo "$total_size" | awk '{ sum = $1 / 1024^2; unit = "M"; if (sum >= 1024) { sum /= 1024; unit = "G" }; printf "%.2f %sB\n", sum, unit }')"
  elif [ "$action" = "-r" ]; then
    echo "Deleted $(echo "$total_size" | awk '{ sum = $1 / 1024^2; unit = "M"; if (sum >= 1024) { sum /= 1024; unit = "G" }; printf "%.2f %sB\n", sum, unit }') from $count directories"
  fi
}

# Display action and directory
if [ "$action" = "-f" ]; then
  echo "Find and list 'node_modules' directories and their sizes in '$target_dir'"
elif [ "$action" = "-r" ]; then
  echo "Remove 'node_modules' directories and show a summary of deleted space in '$target_dir'"
fi

# Confirmation prompt
read -p "Continue? [Y/n] " response
if [[ ! "$response" =~ ^[Yy]$ ]] && [[ ! -z "$response" ]]; then
  exit 0
fi

# Execute the action
process_node_modules "$action" "$target_dir"
