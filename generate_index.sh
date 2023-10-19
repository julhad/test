#!/bin/bash

# Use the find command to list all subdirectories, excluding .git and .github
# The -type d option specifies that we are looking for directories.
# The -name option is used to exclude directories with specific names.
subdirectories=$(find . -mindepth 1 -type d \( -name ".git" -o -name ".github" \) -prune -o -type d -print)

# Loop through the subdirectories
for subdir in $subdirectories; do
    echo "Generating index file for $subdir"
    cd $subdir
    ls | grep -v "index.json" | jq -R -n '[inputs] | { "reports": . }' > index.json 
    cd ..
done