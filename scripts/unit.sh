#!/bin/bash

set -e

# Check if all arguments are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: $0 <scriptname> <input-file> <output-file>"
    echo "Example: $0 openAI code.als english.md"
    exit 1
fi


SCRIPT=$1
INPUT=$2
OUTPUT=$3

python3 ./scripts/wrapper.py ./prompts/alloy-english-prefix.txt "$INPUT" ./prompts/alloy-english-suffix.txt - \
    | python3 "./scripts/${SCRIPT}.py" - "$OUTPUT"