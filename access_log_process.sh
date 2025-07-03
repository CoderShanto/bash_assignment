#!/bin/bash

echo "📄 Processing access.log..."

# 1. Extract all unique IP addresses
echo -e "\n Unique IP Addresses:"
awk '{print $1}' access.log | sort | uniq

# 2. Count how many times each IP has appeared
echo -e "\n IP Address Request Counts:"
awk '{print $1}' access.log | sort | uniq -c | sort -nr

# 3. IP address with the most requests
echo -e "\n IP Address with Most Requests:"
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -1

# 4. Extract all endpoints
echo -e "\n Unique Endpoints:"
awk -F\" '{print $2}' access.log | awk '{print $2}' | sort | uniq

# 5. Count requests per endpoint and sort (ascending)
echo -e "\n Endpoint Request Counts (Ascending):"
awk -F\" '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -n
