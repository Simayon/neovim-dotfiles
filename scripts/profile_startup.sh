#!/bin/bash

# Script to profile Neovim startup time

echo "Profiling Neovim startup time..."

# Run Neovim with startup time logging
nvim --startuptime startup.log -c q

# Display the results
echo -e "\nStartup Time Summary:"
echo "====================="

# Total startup time (last line of the log)
total_time=$(tail -n 1 startup.log | awk '{print $1}')
echo "Total startup time: ${total_time}ms"

# Top 10 slowest operations
echo -e "\nTop 10 slowest operations:"
echo "========================"
sort -k2 -nr startup.log | head -n 10 | while read -r line; do
    time=$(echo "$line" | awk '{print $2}')
    operation=$(echo "$line" | cut -d: -f2-)
    printf "%.2fms: %s\n" "$time" "$operation"
done

# Categorize operations
echo -e "\nTime by category:"
echo "================="
echo "Plugin loading:" $(grep -i "sourcing.*plugin" startup.log | awk '{sum += $2} END {print sum "ms"}')
echo "Syntax highlighting:" $(grep -i "syntax" startup.log | awk '{sum += $2} END {print sum "ms"}')
echo "File I/O:" $(grep -i "reading\|writing" startup.log | awk '{sum += $2} END {print sum "ms"}')

echo -e "\nStartup log saved to: startup.log"
