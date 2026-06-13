#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to colorize timing based on duration
colorize_time() {
    local time=$1
    # Use awk for floating point comparison (more portable than bc)
    if awk "BEGIN {exit !($time >= 10.0)}"; then
        echo -e "${RED}${time}ms${NC}"
    elif awk "BEGIN {exit !($time >= 5.0)}"; then
        echo -e "${YELLOW}${time}ms${NC}"
    elif awk "BEGIN {exit !($time >= 1.0)}"; then
        echo -e "${CYAN}${time}ms${NC}"
    else
        echo -e "${GREEN}${time}ms${NC}"
    fi
}

# Generate startup log file
LOG_FILE=$(mktemp)

echo -e "${CYAN}🔄 Generating Neovim startup profile...${NC}"

# Run nvim with startup profiling
nvim --startuptime "$LOG_FILE" -c "qall!" > /dev/null 2>&1

# Check if the log file was created successfully
if [ ! -f "$LOG_FILE" ] || [ ! -s "$LOG_FILE" ]; then
    echo -e "${RED}Error: Failed to generate startup log file${NC}"
    echo -e "${RED}Make sure nvim is installed and accessible${NC}"
    rm -f "$LOG_FILE"
    exit 1
fi

echo -e "${GREEN}✅ Startup profile generated successfully${NC}"
echo

echo -e "${WHITE}🚀 Neovim Plugin Startup Times${NC}"
echo -e "${BLUE}================================${NC}"
echo

# Create temporary files for processing
TEMP_FILE=$(mktemp)
PLUGIN_LIST=$(mktemp)

# Extract plugin timing data
grep "sourcing.*\.nvim\|sourcing.*pack.*opt\|require.*\.nvim" "$LOG_FILE" | while IFS= read -r line; do
    # Extract elapsed time (second column)
    elapsed=$(echo "$line" | awk '{print $2}' | grep -oE '[0-9]+\.[0-9]+')
    
    # Skip if no elapsed time found
    if [ -z "$elapsed" ]; then
        continue
    fi
    
    # Extract plugin name from path
    plugin_name=""
    
    # Check for pack/opt pattern
    if echo "$line" | grep -q "pack.*opt"; then
        plugin_name=$(echo "$line" | sed -n 's/.*pack.*opt\/\([^\/]*\).*/\1/p')
    fi
    
    # Check for .nvim in path
    if [ -z "$plugin_name" ] && echo "$line" | grep -q "\.nvim"; then
        plugin_name=$(echo "$line" | sed -n 's/.*\/\([^\/]*\.nvim\).*/\1/p')
    fi
    
    # Check for require statements with plugin names
    if [ -z "$plugin_name" ] && echo "$line" | grep -q "require"; then
        plugin_name=$(echo "$line" | sed -n "s/.*require.*['\(]\([^'\/\)]*\)['\)].*/\1/p" | head -1)
        # Filter out generic vim modules
        if echo "$plugin_name" | grep -qE "^(vim\.|plenary|telescope|nvim-)"; then
            plugin_name=$(echo "$plugin_name" | sed 's/vim\.//')
        fi
    fi
    
    # Only process if we found a plugin name and it looks like a plugin
    if [ -n "$plugin_name" ] && [ "$plugin_name" != "vim" ] && [ "$plugin_name" != "nvim" ]; then
        echo "$plugin_name $elapsed" >> "$TEMP_FILE"
    fi
done

# Get unique plugin names
cut -d' ' -f1 "$TEMP_FILE" | sort -u > "$PLUGIN_LIST"

# Calculate totals for each plugin using a simple approach
RESULTS_FILE=$(mktemp)
while IFS= read -r plugin; do
    total=$(grep "^$plugin " "$TEMP_FILE" | awk '{sum += $2} END {print sum}')
    if [ -n "$total" ] && [ "$total" != "0" ]; then
        echo "$total $plugin" >> "$RESULTS_FILE"
    fi
done < "$PLUGIN_LIST"

# Sort by time (descending) and display
if [ -s "$RESULTS_FILE" ]; then
    echo -e "${PURPLE}Plugin Name                    Total Time${NC}"
    echo -e "${BLUE}----------------------------------------${NC}"
    
    rank=1
    sort -nr "$RESULTS_FILE" | while IFS= read -r line; do
        time=$(echo "$line" | awk '{print $1}')
        plugin=$(echo "$line" | cut -d' ' -f2-)
        
        if [ $rank -le 3 ]; then
            case $rank in
                1) medal="🥇" ;;
                2) medal="🥈" ;;
                3) medal="🥉" ;;
            esac
        else
            medal="  "
        fi
        
        printf "%s %-25s %s\n" "$medal" "$plugin" "$(colorize_time "$time")"
        rank=$((rank + 1))
    done
else
    echo -e "${YELLOW}No plugin timing data found in the log file.${NC}"
    echo -e "${YELLOW}Make sure you're using a proper nvim startup profile log.${NC}"
fi

echo
echo -e "${BLUE}Color Legend:${NC}"
echo -e "  $(colorize_time "15.0") - Slow (>= 10ms)"
echo -e "  $(colorize_time "7.5")  - Medium (>= 5ms)"  
echo -e "  $(colorize_time "2.5")  - Fast (>= 1ms)"
echo -e "  $(colorize_time "0.5")  - Very Fast (< 1ms)"

# Calculate total startup time
total_time=$(tail -1 "$LOG_FILE" | grep -oE '[0-9]+\.[0-9]+' | tail -1)
if [ -n "$total_time" ]; then
    echo
    echo -e "${WHITE}Total Startup Time: $(colorize_time "$total_time")${NC}"
fi

# Cleanup
rm -f "$TEMP_FILE" "$PLUGIN_LIST" "$RESULTS_FILE" "$LOG_FILE"
