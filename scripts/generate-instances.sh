#!/bin/bash
#
# Generate Alloy instances using CompoSAT with incrementing scope.
#
# Creates a temp copy of the .als file with all existing run/check commands
# stripped, appends "run {} for x" (x = 1, 2, 3, ...), and runs CompoSAT
# on each scope until a time limit is reached.
#
# Usage:
#   ./scripts/generate-instances.sh <input.als|input-dir> <output-dir> [time-limit-seconds] [max-parallel]
#
# Examples:
#   ./scripts/generate-instances.sh model.als trial-run/instances/ 120
#   ./scripts/generate-instances.sh trial-run/models/ trial-run/instances/ 120 4

JAVA8="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/bin/java"
COMPOSAT_JAR="validModels/jars/CompoSAT.jar"
COMPOSAT_TMPDIR="/private/tmp/amalgam-coverage"

# Ensure temp directory exists for CompoSAT
mkdir -p "$COMPOSAT_TMPDIR"

# --- Process a single .als file ---
process_single_file() {
    local INPUT_FILE="$1"
    local OUTPUT_DIR="$2"
    local TIME_LIMIT="$3"

    local MODEL_NAME
    MODEL_NAME=$(basename "$INPUT_FILE" .als)
    local TEMP_DIR
    TEMP_DIR=$(mktemp -d /tmp/composat_XXXXXXXX)
    local TEMP_FILE="$TEMP_DIR/${MODEL_NAME}.als"

    # Remove lines that are run or check commands
    sed -E '/^[[:space:]]*(run|check)[[:space:]]/d' "$INPUT_FILE" > "$TEMP_FILE"

    echo "[$MODEL_NAME] Starting (time limit: ${TIME_LIMIT}s)"

    mkdir -p "$OUTPUT_DIR"

    local TOTAL_INSTANCES=0
    local START_TIME
    START_TIME=$(date +%s)
    local SCOPE=1

    while true; do
        local CURRENT_TIME
        CURRENT_TIME=$(date +%s)
        local ELAPSED=$((CURRENT_TIME - START_TIME))
        if [ "$ELAPSED" -ge "$TIME_LIMIT" ]; then
            echo "[$MODEL_NAME] Time limit reached (${ELAPSED}s >= ${TIME_LIMIT}s). Stopping."
            break
        fi

        local REMAINING=$((TIME_LIMIT - ELAPSED))

        # Update the temp file: remove any previous "run {} for" line, append new one
        sed -i '' '/^run {} for [0-9]/d' "$TEMP_FILE"
        echo "run {} for $SCOPE" >> "$TEMP_FILE"

        echo "[$MODEL_NAME] Scope $SCOPE (${ELAPSED}s elapsed, ${REMAINING}s remaining)"

        # Output structure: <output-dir>/<model-name>/scope_N/
        local SCOPE_OUT="$OUTPUT_DIR/$MODEL_NAME/scope_$SCOPE"
        mkdir -p "$SCOPE_OUT"

        # Run CompoSAT directly in background (no pipe, so $! is the Java PID)
        local COMPOSAT_LOG="$TEMP_DIR/composat_scope_${SCOPE}.log"
        "$JAVA8" -Djava.io.tmpdir="$COMPOSAT_TMPDIR" \
            -jar "$COMPOSAT_JAR" batch \
            --files "$TEMP_FILE" \
            --command 0 \
            --mode coverage \
            --symmetry 2000 \
            --out "$SCOPE_OUT" \
            > "$COMPOSAT_LOG" 2>&1 &
        local COMPOSAT_PID=$!

        # Poll until CompoSAT finishes or time limit is exceeded
        local TIMED_OUT=false
        while kill -0 "$COMPOSAT_PID" 2>/dev/null; do
            CURRENT_TIME=$(date +%s)
            ELAPSED=$((CURRENT_TIME - START_TIME))
            if [ "$ELAPSED" -ge "$TIME_LIMIT" ]; then
                echo "[$MODEL_NAME] Time limit during scope $SCOPE. Killing..."
                kill "$COMPOSAT_PID" 2>/dev/null
                wait "$COMPOSAT_PID" 2>/dev/null
                rm -rf "$SCOPE_OUT"
                TIMED_OUT=true
                break
            fi
            sleep 1
        done
        wait "$COMPOSAT_PID" 2>/dev/null

        if [ "$TIMED_OUT" = true ]; then
            echo "[$MODEL_NAME] Time limit reached (${ELAPSED}s >= ${TIME_LIMIT}s). Stopping."
            break
        fi

        # Count instances generated for this scope
        local SCOPE_INSTANCES
        SCOPE_INSTANCES=$(find "$SCOPE_OUT" -name "*.xml" 2>/dev/null | wc -l | tr -d ' ')
        TOTAL_INSTANCES=$((TOTAL_INSTANCES + SCOPE_INSTANCES))
        echo "[$MODEL_NAME]   -> $SCOPE_INSTANCES instance(s) at scope $SCOPE"

        # Clean up empty scope dirs
        if [ "$SCOPE_INSTANCES" -eq 0 ]; then
            rm -rf "$SCOPE_OUT" 2>/dev/null || true
        fi

        SCOPE=$((SCOPE + 1))
    done

    rm -rf "$TEMP_DIR"

    local END_TIME
    END_TIME=$(date +%s)
    local TOTAL_TIME=$((END_TIME - START_TIME))
    echo "[$MODEL_NAME] Done. ${TOTAL_TIME}s, max scope $((SCOPE - 1)), $TOTAL_INSTANCES instance(s)"
}

# Export function and variables so subprocesses can use them
export -f process_single_file
export JAVA8 COMPOSAT_JAR COMPOSAT_TMPDIR

# --- Argument parsing ---
if [ $# -lt 2 ] || [ $# -gt 4 ]; then
    echo "Usage: $0 <input.als|input-dir> <output-dir> [time-limit-seconds] [max-parallel]"
    echo "  input              .als file or directory of .als files"
    echo "  output-dir         Directory to write generated instances"
    echo "  time-limit-seconds Max time per file in seconds (default: 120)"
    echo "  max-parallel       Max concurrent jobs for directory mode (default: 4)"
    exit 1
fi

INPUT="$1"
OUTPUT_DIR="$2"
TIME_LIMIT="${3:-120}"
MAX_PARALLEL="${4:-4}"

if [ ! -e "$INPUT" ]; then
    echo "Error: '$INPUT' not found."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

if [ -f "$INPUT" ]; then
    # Single file mode
    process_single_file "$INPUT" "$OUTPUT_DIR" "$TIME_LIMIT"
elif [ -d "$INPUT" ]; then
    # Directory mode — find all .als files and run in parallel
    ALS_FILES=()
    while IFS= read -r -d '' f; do
        ALS_FILES+=("$f")
    done < <(find "$INPUT" -type f -name "*.als" -print0)

    FILE_COUNT=${#ALS_FILES[@]}
    echo "=== CompoSAT Instance Generation (directory mode) ==="
    echo "Input dir:    $INPUT"
    echo "Output dir:   $OUTPUT_DIR"
    echo "Files found:  $FILE_COUNT"
    echo "Time limit:   ${TIME_LIMIT}s per file"
    echo "Parallelism:  $MAX_PARALLEL"
    echo ""

    if [ "$FILE_COUNT" -eq 0 ]; then
        echo "No .als files found."
        exit 0
    fi

    # Run jobs in parallel using background processes with a job limiter
    for f in "${ALS_FILES[@]}"; do
        # Wait if we've hit the parallelism limit
        while true; do
            RUNNING_JOBS=$(jobs -rp | wc -l | tr -d ' ')
            if [ "$RUNNING_JOBS" -lt "$MAX_PARALLEL" ]; then
                break
            fi
            sleep 1
        done

        process_single_file "$f" "$OUTPUT_DIR" "$TIME_LIMIT" &
    done

    # Wait for all remaining background jobs
    wait

    echo ""
    TOTAL_INSTANCES=$(find "$OUTPUT_DIR" -name "*.xml" 2>/dev/null | wc -l | tr -d ' ')
    echo "=== All done. $TOTAL_INSTANCES total instance(s) generated across $FILE_COUNT file(s) ==="
else
    echo "Error: '$INPUT' is neither a file nor a directory."
    exit 1
fi
