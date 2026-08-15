#!/bin/bash

read -p "Enter project/directory name: " input   # Ask user for project name

project_dir="attendance_tracker_$input"   # store project directory 

# Function to execute cleanup when ctrl + c is pressed
cleanup() {
    echo
    echo "Setup interrupted. Creating archive..."

    tar -czf "${project_dir}_archive.tar.gz" "$project_dir"    # create archive zip of project directory

    rm -rf "$project_dir"     # force delete incomplete project directory and its contents

    echo "Archive created: ${project_dir}_archive.tar.gz"
    echo "Incomplete project deleted."
    exit 1 
}

trap cleanup SIGINT    # trigger cleanup when user presses ctrl + c

# Create directories
mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"

# Copy source files
cp attendance_checker.py "$project_dir/"
cp assets.csv "$project_dir/Helpers/"
cp config.json "$project_dir/Helpers/"
cp reports.log "$project_dir/reports/"


read -p "Update attendance thresholds? (y/n): " choice

if [[ "$choice" == "y" ]]; then

    read -p "Enter new Warning value: " warning
    read -p "Enter new Failure value: " failure

    sed -i "s/75/$warning/" $project_dir/Helpers/config.json
    sed -i "s/50/$failure/" $project_dir/Helpers/config.json

    echo "Configuration updated."

else
    echo "Using default values: Warning = 75, Failure = 50."
fi

# Check if python is installed
if python3 --version > /dev/null 2>&1; then   # hide actual version output and/or error message from user
    echo "Python3 is installed."
else
    echo "Warning: Python3 is not installed."
fi

# Confirm project structure is accurate
if [[ -f "$project_dir/attendance_checker.py" &&
      -f "$project_dir/Helpers/assets.csv" &&
      -f "$project_dir/Helpers/config.json" &&
      -f "$project_dir/reports/reports.log" ]]; then

    echo "Project structure verified."
    echo "Setup complete!"

else
    echo "Warning: Project structure is incomplete."
fi
