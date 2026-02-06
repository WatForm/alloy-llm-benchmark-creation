#!/bin/bash

# Check if name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <name>"
    echo "Example: $0 test"
    exit 1
fi

NAME=$1

python ./scripts/wrapper.py ./prompts/alloy-english-prefix.txt ./pipeline-test/original-models/${NAME}.als ./prompts/alloy-english-suffix.txt ./temp/tmp.txt

python ./scripts/openAI.py ./temp/tmp.txt ./pipeline-test/english-summaries/${NAME}.md

python ./scripts/wrapper.py ./prompts/english-alloy-prefix.txt ./pipeline-test/english-summaries/${NAME}.md ./prompts/english-alloy-suffix.txt ./temp/tmp.txt

python ./scripts/openAI.py ./temp/tmp.txt ./pipeline-test/reconstructed-responses/${NAME}.md

python ./scripts/extract-code.py ./pipeline-test/reconstructed-responses/${NAME}.md ./reconstructed-models/${NAME}.als