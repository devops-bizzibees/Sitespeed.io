Speed Test Automation with Sitespeed.io
This repository contains a Bash script designed to automate the process of running performance tests on specified URLs using Sitespeed.io, a popular open-source tool for web performance testing and monitoring. The script executes each test within a Docker container, saving the results in a specified directory structure for easy access.

Prerequisites
Docker: Ensure that Docker is installed and running on the system where the script is executed. The script uses a Docker image of Sitespeed.io to run the tests.
Permissions: The script creates a directory structure at /root/speedtest_results and grants permissions to read, write, and execute in this location.
Script Overview
The script tests the performance of a list of URLs defined within an array, generating and saving performance reports for each URL in an organized directory structure.

Key Variables
URLS: An array of URLs that will be tested. Each URL will be processed independently.
REPORT_BASE_PATH: The base path for storing test results. By default, it is set to /root/speedtest_results.
Directory Structure
The script organizes test reports by the hostname and path of each URL. For instance:

Results for https://www.abc.com/ will be saved in:
/root/speedtest_results/abc/

Results for https://www.abc.com/te/xyz will be saved in:
/root/speedtest_results/abc/xyz/


Usage
1.Clone the repository (or place this script on your server as needed).
2.Configure URLs: Update the URLS array within the script to include the URLs you wish to test.
3.Run the Script:  ./speedtest.sh

The script will iterate over each URL in the URLS array, running a performance test for each and saving the results in the specified directory structure.
