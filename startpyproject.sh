#!/bin/bash

# Check if an argument was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <git-url>"
    exit 1
fi

# Extract the repository name from the git URL
repo_name=$(basename "$1" .git)



# Check if directory exists
if [ ! -d "$repo_name" ]; then
  # If it doesn't exist, create it
  mkdir -p "$repo_name"
  echo "Directory '$repo_name' created."
else
  echo "Directory '$repo_name' already exists."
  exit 1 
fi

# Install virtualenv if not already installed
python3 -m pip install virtualenv


cd "$repo_name"

# Create the virtual environment
python3 -m venv "venv"

# Get the absolute path of the virtual environment
path=$(pwd)
# Activate the virtual environment
source "$path/venv/bin/activate"
echo "# {$repo_name}" >> README.md
git init
git branch -M main
git add README.md
git commit -m "first commit"
git remote add origin $1
git push -u origin main
