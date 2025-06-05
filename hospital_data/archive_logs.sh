#!/bin/bash

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
    local source_file=$2
    local archive_dir=$3
    local display_name=$4

    # Check if source file exists and has content
    if [ ! -f "$source_file" ]; then
        echo "Error: $source_file not found!"
        return 1
    fi

    if [ ! -s "$source_file" ]; then
        echo "Warning: $source_file is empty!"
    fi

    # Create archive directory if it doesn't exist
    mkdir -p "$archive_dir"

    # Generate timestamp
    timestamp=$(date "+%Y-%m-%d_%H:%M:%S")

    # Create archive filename
    archive_file="${archive_dir}/${log_type}_${timestamp}.log"

    # Move the file to archive
    if mv "$source_file" "$archive_file"; then
        echo "Archiving $display_name..."
        echo "Successfully archived to $archive_file"

        # Create new empty log file
        touch "$source_file"
        echo "Created new empty log file: $source_file"
    else
        echo "Error: Failed to archive $source_file"
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
                       "/Coding-lab_Group6/hospital_data/active_logs/heart_rate_log.log" \
                       "/Coding-lab_Group6/hospital_data/archive_logs/heart_data_archive" \
                       "Heart Rate"
            ;;
        2)
            archive_log "temperature" \
                       "/Coding-lab_Group6/hospital_data/active_logs/temperature_log.log" \
                       "/Coding-lab_Group6/hospital_data/archive_logs/temperature_data_archive" \
                       "Temperature"
            ;;
        3)
            archive_log "water_usage" \
                       "/Coding-lab_Group6/hospital_data/active_logs/water_usage_log.log" \
                       "/Coding-lab_Group6/hospital_data/archive_logs/water_data_archive" \
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
