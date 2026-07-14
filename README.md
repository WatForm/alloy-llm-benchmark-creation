# alloy-llm-benchmark-creation

Scripts for building an Alloy benchmark workflow:
1. collect candidate Alloy models,
2. filter for compatibility,
3. generate English descriptions,
4. generate model instances.

## 1) Setup

### Python environment

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai ollama
```

### API key setup

This repository expects your OpenAI key in:

```text
./secret/key
```

Create the file and paste only the raw key value into it (no quotes/newlines beyond the final newline).

## 2) Java requirements (for filtering and instance generation)

Two Java versions are used:
1. Java 17 for `alloy-diff.jar`
2. Java 8 for `CompoSAT.jar`

These scripts require explicit environment variables:
1. JAVA_HOME_17
2. JAVA_HOME_8

Run these commands in your shell before running filter/instance scripts:

```bash
export JAVA_HOME_17="/path/to/jdk-17"
export JAVA_HOME_8="/path/to/jdk-8"
```

Verify both are set and correct:

```bash
echo "$JAVA_HOME_17"
"$JAVA_HOME_17/bin/java" -version

echo "$JAVA_HOME_8"
"$JAVA_HOME_8/bin/java" -version
```

Expected major versions:
1. JAVA_HOME_17/bin/java reports 17
2. JAVA_HOME_8/bin/java reports 1.8 (or 8)

## 3) Where to put models

Use this location for your input Alloy models:

```text
./validModels/models/
```

You can keep nested folders; scripts recurse through subdirectories.

## 4) Run the compatibility filter

Filter models before generation:

```bash
./validModels/checkValidity.sh ./validModels/models
```

What this does:
1. checks Alloy-diff compatibility (Java 17)
2. checks CompoSAT compatibility (Java 8)
3. copies passing models into:

```text
./validModels/validModels/
```

## 5) Generate English descriptions for all compatible models

Create a folder called `benchmark` in the root directory. Copy all models you wish to use into `benchmark/models`.

Run the following command to generate descriptions:

```bash
python ./scripts/master.py openAI ./benchmark/models ./benchmark/descriptions
```

This traverses all `.als` files recursively and writes one `.md` description per model.

## 6) Generate instances for all compatible models

```bash
./scripts/generate-instances.sh ./benchmark/models ./benchmark/instances 120 4
```

Arguments:
1. input `.als` file or directory
2. output directory
3. time limit in seconds per model (default `120`)
4. max parallel jobs in directory mode (default `4`)

After each CompoSAT scope, XML instances that duplicate an instance already kept
at a lower scope for the same model are removed. Duplicate detection compares the
XML instance content after stripping run metadata such as `command`, `filename`,
and `maxseq`.

## 7) Generate exact-scope general instances (new)

This step uses `scripts/InstanceGenerator.java` and runs exact scopes for top-level signatures.

Default command (uses `x=10`, `y=5`):

```bash
./scripts/generate-general-instances.sh
```

Explicit command (same defaults shown):

```bash
./scripts/generate-general-instances.sh ./benchmark/models ./benchmark/generalInstances 10 5
```

Arguments:
1. models directory (default `./benchmark/models`)
2. output directory (default `./benchmark/generalInstances`)
3. `x`: max unique instances kept per scope (default `10`)
4. `y`: max scope, runs `1..y` (default `5`)
5. timeout in seconds per model/scope run (optional, default `45`)

Notes:
1. Traverses all `.als` files recursively under the models directory.
2. For each model and each scope from `1` to `y`, keeps up to `x` XML instances that are unique from lower scopes.
3. Duplicate detection compares XML instance content after stripping run metadata such as `command`, `filename`, and `maxseq`.
4. For each scope, the script starts by generating `2*x` candidates. If fewer than `x` unique new instances are found, it retries with `3*x`, then `4*x`, and so on until it either keeps `x` unique new instances, reaches the `10*x` candidate limit, or `InstanceGenerator` exhausts the scope.
5. If fewer than `x` unique satisfiable instances exist at a scope, it keeps however many exist.
6. Output layout is: `benchmark/generalInstances/<model-relative-path>/scope_<n>/`.

