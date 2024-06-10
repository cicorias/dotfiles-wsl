#!/bin/bash

# Check if the date argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <since-date> <branch-name>"
    echo "Example: $0 '2023-01-01' 'main'"
    exit 1
fi

since_date="$1"
branch_name="$2"

# Get the list of contributors
contributors=$(git shortlog -s -n -e --since="$since_date" --branches="$branch_name" | awk '{$1=""; print $0}')

echo "Contributor, Commits, Lines Added, Lines Deleted"

# Loop through each contributor
echo "$contributors" | while read -r contributor; do
    email=$(echo "$contributor" | grep -o '<.*>' | tr -d '<>')

    # Get commit count
    commits=$(git log --since="$since_date" --author="$email" --branches="$branch_name" --pretty=oneline | wc -l)

    # Get lines added and deleted
    lines=$(git log --since="$since_date" --author="$email" --branches="$branch_name" --pretty=tformat: --numstat | awk '{add+=$1; del+=$2} END {print add "," del}')

    # Output the result
    echo "$contributor, $commits, $lines"
done
