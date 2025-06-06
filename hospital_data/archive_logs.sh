#!/bin/bash

# --- Get the directory of the current script ---
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

#Base path for your hospital_data relative to SCRIPT_DIR
HOSPITAL_DATA_BASE_PATH="${SCRIPT_DIR}"

# Define directories for active logs and archive logs
ACTIVE_LOGS_DIR="${HOSPITAL_DATA_BASE_PATH}/active_logs"
ARCHIVE_LOGS_ROOT_DIR="${HOSPITAL_DATA_BASE_PATH}/archived_logs"

# Function to display menu
show_menu() {
    echo "Select log to archive:"
    echo "1) Heart Rate"
    echo "2) Temperature"
    echo "3) Water Usage"
    echo -n "Enter choice (1-3): "
}

# Function to archive log file
archive_log() {
    local log_type=$1
    local source_file_name=$2
    local archive_dir=$3
    local display_name=$4

# Construct the full, relative paths within the function
    local full_source_file="${ACTIVE_LOGS_DIR}/${source_file_name}"
    local full_archive_dir="${ARCHIVE_LOGS_ROOT_DIR}/${archive_dir}"

    # Check if source file exists and has content
    if [ ! -f "$full_source_file" ]; then
        echo "Error: $full_source_file not found!"
        return 1
    fi

    if [ ! -s "$full_source_file" ]; then
        echo "Warning: $full_source_file is empty!"
    fi

    # Create archive directory if it doesn't exist
    mkdir -p "$full_archive_dir"

    # Generate timestamp
    timestamp=$(date "+%Y-%m-%d_%H:%M:%S")

    # Create archive filename
    archive_file="${full_archive_dir}/${log_type}_${timestamp}.log"

    # Move the file to archive
    if mv "$full_source_file" "$archive_file"; then
        echo "Archiving $display_name..."
        echo "Successfully archived to $archive_file"

        # Create new empty log file
        touch "$full_source_file"
        echo "Created new empty log file: $full_source_file"
    else
        echo "Error: Failed to archive $full_source_file"
        return 1
    fi
}

# Main script
main() {
    show_menu
    read -r choice

    case $choice in
        1)
            archive_log "heart_rate" \
                       "heart_rate_log.log" \
                       "heart_data_archive" \
                       "Heart Rate"
            ;;
        2)
            archive_log "temperature" \
                       "temperature_log.log" \
                       "temperature_data_archive" \
                       "Temperature"
            ;;
        3)
            archive_log "water_usage" \
                       "water_usage_log.log" \
                       "water_data_archive" \
                       "Water Usage"
            ;;
        *)
            echo "Error: Invalid choice. Please enter 1, 2, or 3."
            exit 1
            ;;
    esac
}

# Run main function
main

