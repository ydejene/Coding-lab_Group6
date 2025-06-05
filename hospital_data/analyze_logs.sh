#!/bin/bash

# --- Get the directory of the current script ---
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" 

#Base path for your hospital_data relative to SCRIPT_DIR
HOSPITAL_DATA_BASE_PATH="${SCRIPT_DIR}"

# Define directories for active logs and archive logs
ACTIVE_LOGS_DIR="${HOSPITAL_DATA_BASE_PATH}/active_logs"

# Function to display menu
show_menu() {
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate_log.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    echo -n "Enter choice (1-3): "
}

# Function to analyze log file
analyze_log() {
    local log_file=$1
    local log_type=$2

    local full_source_file="${ACTIVE_LOGS_DIR}/${log_file}"
    local full_reports_dir="${HOSPITAL_DATA_BASE_PATH}/reports"
    

    # Check if log file exists
    if [ ! -f "$full_source_file" ]; then
        echo "Error: $full_source_file not found!"
        return 1
    fi

    if [ ! -s "$full_source_file" ]; then
        echo "Warning: $full_source_file is empty!"
        return 1
    fi

    echo "Analyzing $full_source_file..."

    # Create reports directory if it doesn't exist
    mkdir -p "$full_reports_dir"

    # Generate timestamp for report
    report_time=$(date "+%Y-%m-%d %H:%M:%S")

    # Append analysis header to report
    echo "===========================================" >> $full_reports_dir/analysis_report.txt
    echo "Analysis Report - $full_source_file" >> $full_reports_dir/analysis_report.txt
    echo "Generated: $report_time" >> $full_reports_dir/analysis_report.txt
    echo "===========================================" >> $full_reports_dir/analysis_report.txt

    # Extract device names and count occurrences
    echo "Device Statistics:" >> $full_reports_dir/analysis_report.txt
    awk -F' - ' '{
        if (NF >= 2) {
            device = $2
            gsub(/:.*/, "", device)  # Remove everything after ":"
            count[device]++
            if (!first_seen[device]) {
                first_seen[device] = $1
            }
            last_seen[device] = $1
        }
    } END {
        for (device in count) {
            printf "Device: %s\n", device
            printf "  Total entries: %d\n", count[device]
            printf "  First entry: %s\n", first_seen[device]
            printf "  Last entry: %s\n", last_seen[device]
            printf "\n"
        }
    }' "$full_source_file" >> $full_reports_dir/analysis_report.txt

    # Add summary statistics
    total_entries=$(wc -l < "$full_source_file")
    echo "Summary:" >> $full_reports_dir/analysis_report.txt
    echo "  Total log entries: $total_entries" >> $full_reports_dir/analysis_report.txt
    echo "  Log file: $full_source_file" >> $full_reports_dir/analysis_report.txt
    echo "" >> $full_reports_dir/analysis_report.txt

    echo "Analysis completed! Results appended to $full_reports_dir/analysis_report.txt"
}

# Function to validate input
validate_input() {
    local choice=$1
    if [[ "$choice" =~ ^[1-3]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Main script
main() {
    show_menu
    read -r choice

    if ! validate_input "$choice"; then
        echo "Error: Invalid choice. Please enter 1, 2, or 3."
        exit 1
    fi

    case $choice in
        1)
            analyze_log "heart_rate_log.log" "Heart Rate Log"
            ;;
        2)
            analyze_log "temperature_log.log" "Temperature Log"
            ;;
        3)
            analyze_log "water_usage_log.log" "Water Usage Log"
            ;;
    esac
}

# Run main function
main
