#!/bin/bash

# Определение цветов
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

if [[ "$1" == "-h" || $# -eq 0 ]]; then
    echo -e "Usage: $0 <ELF file>"
    echo -e "Displays memory usage by section."
    exit 0
fi

if [[ ! -f "$1" ]]; then
    echo -e "Error: File '$1' does not exist."
    exit 1
fi

echo "Memory usage by section in $1:"
echo -e "${ORANGE}Size (bytes)${RESET}\t${BLUE}Section${RESET}"
echo "---------------------------------------"
arm-none-eabi-size -A "$1" | tail -n +2 | awk -v orange="$ORANGE" -v blue="$BLUE" -v reset="$RESET" \
'{printf orange "%-12s" reset "\t" blue "%s" reset "\n", $2, $1}'
