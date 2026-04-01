#!/bin/bash

# Generate exact-scope Alloy instances via InstanceGenerator for all benchmark models.
#
# Defaults:
#   models dir:  ./benchmark/models
#   output dir:  ./benchmark/generalInstances
#   x:           10 random instances per scope (max)
#   y:           5 max scope
#   timeout:     45 seconds per model/scope run
#
# Usage:
#   ./scripts/generate-general-instances.sh [models-dir] [output-dir] [x] [y] [timeout-seconds]

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$SCRIPT_DIR/java-common.sh"

MODELS_DIR="${1:-$REPO_ROOT/benchmark/models}"
OUTPUT_DIR="${2:-$REPO_ROOT/benchmark/generalInstances}"
MAX_RANDOM_PER_SCOPE="${3:-10}"
MAX_SCOPE="${4:-5}"
TIMEOUT_SECONDS="${5:-45}"
# Generate more than x candidates before random sampling down to x.
CANDIDATE_MULTIPLIER="${CANDIDATE_MULTIPLIER:-3}"

DEFAULT_ALLOY_JAR="$REPO_ROOT/validModels/jars/org.alloytools.alloy.dist-6.2.0.jar"
ALLOY_DIST_JAR="${ALLOY_DIST_JAR:-$DEFAULT_ALLOY_JAR}"

INSTANCE_GENERATOR_JAVA="$SCRIPT_DIR/InstanceGenerator.java"
INSTANCE_GENERATOR_CLASS="$SCRIPT_DIR/InstanceGenerator.class"

usage() {
    echo "Usage: $0 [models-dir] [output-dir] [x] [y] [timeout-seconds]"
    echo "  models-dir       Directory of .als files (default: ./benchmark/models)"
    echo "  output-dir       Directory for sampled xml outputs (default: ./benchmark/generalInstances)"
    echo "  x                Max random instances kept per scope (default: 10)"
    echo "  y                Max scope, runs 1..y (default: 5)"
    echo "  timeout-seconds  Timeout per model/scope run (default: 45)"
}

is_positive_int() {
    case "$1" in
        ''|*[!0-9]*) return 1 ;;
        *) [ "$1" -ge 1 ] ;;
    esac
}

run_with_timeout() {
    local timeout_secs="$1"
    shift

    "$@" &
    local cmd_pid=$!
    local start_time
    start_time=$(date +%s)

    while kill -0 "$cmd_pid" 2>/dev/null; do
        local now
        now=$(date +%s)
        local elapsed=$((now - start_time))
        if [ "$elapsed" -ge "$timeout_secs" ]; then
            kill "$cmd_pid" 2>/dev/null || true
            sleep 1
            kill -9 "$cmd_pid" 2>/dev/null || true
            wait "$cmd_pid" 2>/dev/null || true
            return 124
        fi
        sleep 1
    done

    wait "$cmd_pid"
    return $?
}

choose_random_subset() {
    local max_keep="$1"
    shift

    local files=("$@")
    local count="${#files[@]}"

    if [ "$count" -le "$max_keep" ]; then
        printf '%s\n' "${files[@]}"
        return 0
    fi

    # Portable randomization without depending on shuf.
    printf '%s\n' "${files[@]}" \
        | awk 'BEGIN { srand(); } { printf "%.12f\t%s\n", rand(), $0; }' \
        | sort -k1,1n \
        | head -n "$max_keep" \
        | cut -f2-
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    usage
    exit 0
fi

if [ ! -d "$MODELS_DIR" ]; then
    echo "Error: models directory not found: $MODELS_DIR"
    exit 1
fi

if ! is_positive_int "$MAX_RANDOM_PER_SCOPE"; then
    echo "Error: x must be a positive integer: $MAX_RANDOM_PER_SCOPE"
    exit 1
fi

if ! is_positive_int "$MAX_SCOPE"; then
    echo "Error: y must be a positive integer: $MAX_SCOPE"
    exit 1
fi

if ! is_positive_int "$TIMEOUT_SECONDS"; then
    echo "Error: timeout-seconds must be a positive integer: $TIMEOUT_SECONDS"
    exit 1
fi

if ! is_positive_int "$CANDIDATE_MULTIPLIER"; then
    echo "Error: CANDIDATE_MULTIPLIER must be a positive integer: $CANDIDATE_MULTIPLIER"
    exit 1
fi

CANDIDATE_LIMIT=$((MAX_RANDOM_PER_SCOPE * CANDIDATE_MULTIPLIER))

if [ ! -f "$ALLOY_DIST_JAR" ]; then
    echo "Error: Alloy distribution jar not found: $ALLOY_DIST_JAR"
    echo "Set ALLOY_DIST_JAR to the jar location, or place it at: $DEFAULT_ALLOY_JAR"
    exit 1
fi

if [ ! -f "$INSTANCE_GENERATOR_JAVA" ]; then
    echo "Error: missing source file: $INSTANCE_GENERATOR_JAVA"
    exit 1
fi

JAVA17="$(require_java_for_version 17 "InstanceGenerator")" || exit 1
JAVAC17="$(dirname "$JAVA17")/javac"
if [ ! -x "$JAVAC17" ]; then
    echo "Error: javac not found next to Java 17 binary: $JAVAC17"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

if [ ! -f "$INSTANCE_GENERATOR_CLASS" ] || [ "$INSTANCE_GENERATOR_JAVA" -nt "$INSTANCE_GENERATOR_CLASS" ]; then
    echo "Compiling InstanceGenerator.java"
    if ! "$JAVAC17" -cp "$ALLOY_DIST_JAR" "$INSTANCE_GENERATOR_JAVA"; then
        echo "Error: failed to compile $INSTANCE_GENERATOR_JAVA"
        exit 1
    fi
fi

ALS_COUNT=$(find "$MODELS_DIR" -type f -name "*.als" | wc -l | tr -d ' ')
if [ "$ALS_COUNT" -eq 0 ]; then
    echo "No .als files found under: $MODELS_DIR"
    exit 0
fi

echo "=== Exact-scope general instance generation ==="
echo "Models dir:        $MODELS_DIR"
echo "Output dir:        $OUTPUT_DIR"
echo "x (max kept):      $MAX_RANDOM_PER_SCOPE"
echo "y (max scope):     $MAX_SCOPE"
echo "Candidates/scope:  $CANDIDATE_LIMIT"
echo "Timeout per scope: ${TIMEOUT_SECONDS}s"
echo "Models found:      $ALS_COUNT"
echo ""

TOTAL_WRITTEN=0
TOTAL_TIMEOUTS=0
TOTAL_ERRORS=0
TOTAL_EMPTY=0

while IFS= read -r -d '' MODEL_FILE; do
    REL_PATH="${MODEL_FILE#$MODELS_DIR/}"
    REL_NO_EXT="${REL_PATH%.als}"
    MODEL_DIR="$(dirname "$MODEL_FILE")"
    MODEL_BASE="$(basename "$MODEL_FILE" .als)"

    echo "[$REL_NO_EXT]"

    MODEL_WRITTEN=0

    SCOPE=1
    while [ "$SCOPE" -le "$MAX_SCOPE" ]; do
        echo "  scope $SCOPE: generating candidates"

        run_with_timeout "$TIMEOUT_SECONDS" \
            "$JAVA17" -cp "$SCRIPT_DIR:$ALLOY_DIST_JAR" InstanceGenerator "$MODEL_FILE" "$SCOPE" "$CANDIDATE_LIMIT"
        GEN_STATUS=$?

        if [ "$GEN_STATUS" -eq 124 ]; then
            echo "  scope $SCOPE: timeout after ${TIMEOUT_SECONDS}s"
            TOTAL_TIMEOUTS=$((TOTAL_TIMEOUTS + 1))
            # Remove any partial artifacts for this scope in model dir.
            find "$MODEL_DIR" -maxdepth 1 -type f -name "$MODEL_BASE-instance-$SCOPE-*.xml" -delete 2>/dev/null || true
            SCOPE=$((SCOPE + 1))
            continue
        fi

        if [ "$GEN_STATUS" -ne 0 ]; then
            echo "  scope $SCOPE: generator failed (exit $GEN_STATUS)"
            TOTAL_ERRORS=$((TOTAL_ERRORS + 1))
            find "$MODEL_DIR" -maxdepth 1 -type f -name "$MODEL_BASE-instance-$SCOPE-*.xml" -delete 2>/dev/null || true
            SCOPE=$((SCOPE + 1))
            continue
        fi

        GENERATED_FILES=()
        while IFS= read -r -d '' XML_FILE; do
            GENERATED_FILES+=("$XML_FILE")
        done < <(find "$MODEL_DIR" -maxdepth 1 -type f -name "$MODEL_BASE-instance-$SCOPE-*.xml" -print0)

        GEN_COUNT="${#GENERATED_FILES[@]}"
        if [ "$GEN_COUNT" -eq 0 ]; then
            echo "  scope $SCOPE: no satisfiable instance"
            TOTAL_EMPTY=$((TOTAL_EMPTY + 1))
            SCOPE=$((SCOPE + 1))
            continue
        fi

        TARGET_SCOPE_DIR="$OUTPUT_DIR/$REL_NO_EXT/scope_$SCOPE"
        mkdir -p "$TARGET_SCOPE_DIR"

        SELECTED=()
        while IFS= read -r CHOSEN; do
            [ -n "$CHOSEN" ] && SELECTED+=("$CHOSEN")
        done < <(choose_random_subset "$MAX_RANDOM_PER_SCOPE" "${GENERATED_FILES[@]}")

        KEPT_COUNT="${#SELECTED[@]}"
        for XML_FILE in "${SELECTED[@]}"; do
            cp "$XML_FILE" "$TARGET_SCOPE_DIR/"
        done

        find "$MODEL_DIR" -maxdepth 1 -type f -name "$MODEL_BASE-instance-$SCOPE-*.xml" -delete 2>/dev/null || true

        echo "  scope $SCOPE: kept $KEPT_COUNT/$GEN_COUNT"
        MODEL_WRITTEN=$((MODEL_WRITTEN + KEPT_COUNT))
        TOTAL_WRITTEN=$((TOTAL_WRITTEN + KEPT_COUNT))

        SCOPE=$((SCOPE + 1))
    done

    echo "  total kept for model: $MODEL_WRITTEN"
    echo ""
done < <(find "$MODELS_DIR" -type f -name "*.als" -print0)

echo "=== Done ==="
echo "Total kept xml files: $TOTAL_WRITTEN"
echo "Timeouts:             $TOTAL_TIMEOUTS"
echo "Generator errors:     $TOTAL_ERRORS"
echo "Unsat scopes:         $TOTAL_EMPTY"
echo "Unsat scopes:         $TOTAL_EMPTY"