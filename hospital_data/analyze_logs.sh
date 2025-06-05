#!/bin/bash

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

    # Check if log file exists
    if [ ! -f "$log_file" ]; then
        echo "Error: $log_file not found!"
        return 1
    fi

    if [ ! -s "$log_file" ]; then
        echo "Warning: $log_file is empty!"
        return 1
    fi

    echo "Analyzing $log_type..."

    # Create reports directory if it doesn't exist
    mkdir -p reports

    # Generate timestamp for report
    report_time=$(date "+%Y-%m-%d %H:%M:%S")

    # Append analysis header to report
    echo "===========================================" >> reports/analysis_report.txt
    echo "Analysis Report - $log_type" >> reports/analysis_report.txt
    echo "Generated: $report_time" >> reports/analysis_report.txt
    echo "===========================================" >> reports/analysis_report.txt

    # Extract device names and count occurrences
    echo "Device Statistics:" >> reports/analysis_report.txt
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
    }' "$log_file" >> reports/analysis_report.txt

    # Add summary statistics
    total_entries=$(wc -l < "$log_file")
    echo "Summary:" >> reports/analysis_report.txt
    echo "  Total log entries: $total_entries" >> reports/analysis_report.txt
    echo "  Log file: $log_file" >> reports/analysis_report.txt
    echo "" >> reports/analysis_report.txt

    echo "Analysis completed! Results appended to reports/analysis_report.txt"
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
            analyze_log "/Coding-lab_Group6/hospital_data/active_logs/heart_rate_log.log" "Heart Rate Log"
            ;;
        2)
            analyze_log "/Coding-lab_Group6/hospital_data/active_logs/temperature_log.log" "Temperature Log"
            ;;
        3)
            analyze_log "/Coding-lab_Group6/hospital_data/active_logs/water_usage_log.log" "Water Usage Log"
            ;;
    esac
}

# Run main function
main
