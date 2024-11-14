#!/bin/bash

# Define the URLs you want to test
URLS=(
    "https://www.abc.com/"
    "https://www.abc.com/te/andhra-pradesh"
    "https://www.abc.com/bn/west-bengal"
    "https://www.abc.com/kn/karnataka"
)

# Define the base path for the reports
REPORT_BASE_PATH="/root/speedtest_results"

# Ensure the base path exists and is writable
mkdir -p $REPORT_BASE_PATH
chmod 777 $REPORT_BASE_PATH

# Loop through each URL and run the test
for URL in "${URLS[@]}"; do
    # Extract the hostname and path from the URL
    HOSTNAME=$(echo $URL | awk -F/ '{print $3}')
    PATH_PART=$(echo $URL | awk -F/ '{print $5}')

    # Default to 'etvbharat' for the hostname
    HOSTNAME_DIR="etvbharat"

    # Create a directory for the report using the hostname and path
    if [ -z "$PATH_PART" ]; then
        REPORT_PATH="${REPORT_BASE_PATH}/${HOSTNAME_DIR}"
    else
        REPORT_PATH="${REPORT_BASE_PATH}/${HOSTNAME_DIR}/${PATH_PART}"
    fi

    # Create the report directory if it doesn't exist
    mkdir -p $REPORT_PATH
    chmod 777 $REPORT_PATH

    # Log the paths and command
    echo "Running test for URL: $URL"
    echo "Report will be saved to: $REPORT_PATH"

    # Run the Sitespeed.io Docker container with the correct volume mount
    docker run --rm -v "${REPORT_PATH}:/sitespeed.io/sitespeed-result" sitespeedio/sitespeed.io:34.3.1 $URL --outputFolder /sitespeed.io/sitespeed-result

    # Check if the report was created
    if [ "$(ls -A $REPORT_PATH)" ]; then
        echo "Report generated successfully for $URL"
    else
        echo "Failed to generate report for $URL"
    fi
done

