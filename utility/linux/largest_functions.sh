#!/bin/bash

# Цвета
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

if [[ "$1" == "-h" || $# -eq 0 ]]; then
    echo "Usage: $0 <ELF file>"
    echo "Displays a list of functions sorted by size in kB."
    exit 0
fi

if [[ ! -f "$1" ]]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

echo "Functions sorted by size in $1:"
echo -e "${ORANGE}Size (kB)${RESET}\tAddress\t\t${BLUE}Function${RESET}"
echo "---------------------------------------------"
arm-none-eabi-nm --print-size --size-sort --radix=d --demangle "$1" | grep " T " | \
awk -v orange="$ORANGE" -v blue="$BLUE" -v reset="$RESET" '{printf orange "%-10.3f" reset " %-12s " blue "%s" reset "\n", $2 / 1024, $1, $4}'
