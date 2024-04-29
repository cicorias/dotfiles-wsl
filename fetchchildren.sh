#!/bin/bash

# Directory containing the subfolders
main_directory="/path/to/main/directory"

# Navigate to each subfolder and check for git repositories
for subfolder in "$main_directory"/*; do
    if [ -d "$subfolder" ]; then
        cd "$subfolder"
        # Check if the directory is a git repository
        if git rev-parse --git-dir > /dev/null 2>&1; then
            echo "Updating Git repository in $subfolder"
            git fetch --all
            git pull
        else
            echo "$subfolder is not a Git repository"
        fi
    fi
done

