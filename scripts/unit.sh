#!/bin/bash

# Check if both arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <scriptname> <input-file> <output-file>"
    echo "Example: $0 openAI code.als english.md"
    exit 1
fi


SCRIPT=$1
INPUT=$2
OUTPUT=$3

python ./scripts/wrapper.py ./prompts/alloy-english-prefix.txt ${INPUT} ./prompts/alloy-english-suffix.txt ./temp/tmp.txt

python ./scripts/${SCRIPT}.py ./temp/tmp.txt ${OUTPUT}