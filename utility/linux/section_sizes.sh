#!/bin/bash

if [[ "$1" == "-h" || $# -eq 0 ]]; then
    echo "Usage: $0 <ELF file>"
    echo "Displays the sizes of all sections in the ELF file."
    exit 0
fi

if [[ ! -f "$1" ]]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

echo "Section sizes in $1:"
arm-none-eabi-objdump -h "$1" | awk '
/^[ ]+[0-9]+[ ]+/ {
    printf "%-15s %-10s bytes\n", $2, $3
}'