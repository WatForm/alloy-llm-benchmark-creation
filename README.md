# alloy-llm-benchmark-creation
Scripts for creating the alloy-llm-benchmark

# API key setup

- API keys are not stored in this repository. If you intend to run this, you are expected to have an OpenAI account and its associated API key
- The key is to be placed in `./secret/api_key.txt`
- This is to be done every time the repository is cloned, since the folder is part of `.gitignore`
- Do not place the key anywhere else, to avoid it becoming part of the commit history.

# Python setup

Execute the following after cloning the repo:

```
python -m venv .env  
source ./.env/bin/activate             
pip install openai
```

This creates a virtual environment and sets up the openai packages. The commands are different on a Windows system.

# Temp:

- to test the pipeline, set up the code in `pipeline-test/original-models/test.als`, then run `temp.sh`
