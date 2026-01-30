python ./scripts/wrapper.py ./prompts/alloy-english-prefix.txt ./pipeline-test/original-models/test.als ./prompts/alloy-english-suffix.txt ./temp/tmp.txt

python ./scripts/openAI.py ./temp/tmp.txt ./pipeline-test/english-summaries/test.md

python ./scripts/wrapper.py ./prompts/english-alloy-prefix.txt ./pipeline-test/english-summaries/test.md ./prompts/english-alloy-suffix.txt ./temp/tmp.txt

python ./scripts/openAI.py ./temp/tmp.txt ./pipeline-test/reconstructed-responses/test.md

python ./scripts/extract-code.py ./pipeline-test/reconstructed-responses/test.md ./reconstructed-models/test.als