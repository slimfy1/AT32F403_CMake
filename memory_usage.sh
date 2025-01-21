#!/bin/bash

# Enter the memory sizes of your microcontroller
FLASH_SIZE=16384  # Flash size in bytes
RAM_SIZE=2048     # RAM size in bytes

# Function to display help
show_help() {
    echo "Usage: $0 [options] <ELF file>"
    echo ""
    echo "Options:"
    echo "  -h       Show this help message"
    echo ""
    echo "Arguments:"
    echo "  <ELF file>  Path to the ELF file to analyze"
    echo ""
    echo "Example:"
    echo "  $0 Testgg.elf"
    exit 0
}

# Check arguments
if [[ "$1" == "-h" || $# -eq 0 ]]; then
    show_help
fi

# Check if the file exists
if [[ ! -f "$1" ]]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

# Execute the arm-none-eabi-size command
OUTPUT=$(arm-none-eabi-size "$1" | tail -n 1)
read -r TEXT DATA BSS _ <<<$(echo $OUTPUT)

# Calculations
FLASH_USAGE=$(echo "scale=2; ($TEXT + $DATA) / $FLASH_SIZE * 100" | bc)
RAM_USAGE=$(echo "scale=2; ($DATA + $BSS) / $RAM_SIZE * 100" | bc)

# Output the results
echo "Flash Usage: $FLASH_USAGE% of $FLASH_SIZE bytes"
echo "RAM Usage: $RAM_USAGE% of $RAM_SIZE bytes"
