#!/bin/bash

# Usage: ./checkValidity.sh file/dir [max-parallel]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JAR_PATH="$SCRIPT_DIR/jars/alloy-diff.jar"
COMPOSAT_JAR="$SCRIPT_DIR/jars/CompoSAT.jar"
source "$SCRIPT_DIR/../scripts/java-common.sh"

JAVA17="$(require_java_for_version 17 "alloy-diff")" || exit 1
JAVA8="$(require_java_for_version 8 "CompoSAT")" || exit 1
COMPOSAT_TMPDIR="$(resolve_alloy_tmpdir)"
VALID_DIR="$SCRIPT_DIR/validModels"

valid_count=0
invalid_count=0
DEFAULT_MAX_PARALLEL=4

mkdir -p "$VALID_DIR"
mkdir -p "$COMPOSAT_TMPDIR"

check_primed_vars() {
    local file="$1"
    
    if grep -q \' "$file"; then
        echo "  [FAIL] Contains primed variables (not compatible with Alloy 6)"
        return 1
    fi
    return 0
}

check_single_file() {
    local file="$1"
    
    if grep -E '^\s*open\s+' "$file" | grep -qv 'util/'; then
        echo "  [FAIL] Contains open statements for non-util modules"
        return 1
    fi
    return 0
}

check_alloy_diff_compatible() {
    local file="$1"
    
    echo "Checking: $file"
    
    output=$("$JAVA17" -cp "$JAR_PATH" org.alloytools.alloy.diff.ModuleDiff "$file" "$file" Equivalence 1 false sat4j 2>&1)
    
    if echo "$output" | grep -q "The two modules are equivalent."; then
        echo "  [PASS] Alloy-diff compatible"
        return 0
    else
        echo "  [FAIL] Not alloy-diff compatible"
        return 1
    fi
}

check_composat_compatible() {
    local file="$1"
    
    # Create a temp copy with run/check commands stripped and "run {} for 1" appended
    local tmpdir
    tmpdir=$(mktemp -d /tmp/composat_check_XXXXXXXX)
    sed -E '/^[[:space:]]*(run|check)[[:space:]]/d' "$file" > "$tmpdir/test.als"
    echo "run {} for 1" >> "$tmpdir/test.als"
    
    output=$("$JAVA8" -Djava.io.tmpdir="$COMPOSAT_TMPDIR" \
        -jar "$COMPOSAT_JAR" batch \
        --files "$tmpdir/test.als" \
        --command 0 \
        --mode coverage \
        --symmetry 2000 \
        --out "$tmpdir/out" 2>&1)
    
    rm -rf "$tmpdir"
    
    if echo "$output" | grep -q "Error"; then
        echo "  [FAIL] Not CompoSAT compatible"
        return 1
    else
        echo "  [PASS] CompoSAT compatible"
        return 0
    fi
}

check_file() {
    local file="$1"
    local input_root="$2"
    
    # Run all checks
    if ! check_primed_vars "$file"; then
        return 1
    fi
    
    if ! check_single_file "$file"; then
        return 1
    fi
    
    if ! check_alloy_diff_compatible "$file"; then
        return 1
    fi
    
    if ! check_composat_compatible "$file"; then
        return 1
    fi
    
    # All checks passed
    echo "  [PASS] All checks passed"
    if [ -n "$input_root" ]; then
        rel_path="${file#$input_root/}"
    else
        rel_path=$(basename "$file")
    fi
    
    target_path="$VALID_DIR/$rel_path"
    mkdir -p "$(dirname "$target_path")"
    cp "$file" "$target_path"
    return 0
}

process_directory() {
    local dir="$1"
    local max_parallel="$2"
    local results_tmp
    local file
    local result_file
    local running
    local file_count=0
    local -a pids=()
    local -a result_files=()

    results_tmp=$(mktemp -d /tmp/checkvalidity_results_XXXXXXXX)

    echo "Directory mode: checking with up to $max_parallel parallel worker(s)"

    while IFS= read -r -d '' file; do
        ((file_count++))
        result_file="$results_tmp/result_${file_count}.txt"
        result_files+=("$result_file")

        while true; do
            running=$(jobs -rp | wc -l | tr -d ' ')
            if [ "$running" -lt "$max_parallel" ]; then
                break
            fi
            sleep 0.2
        done

        (
            if check_file "$file" "$dir"; then
                echo "PASS" > "$result_file"
            else
                echo "FAIL" > "$result_file"
            fi
        ) &
        pids+=("$!")
    done < <(find "$dir" -type f -name "*.als" -print0)

    for pid in "${pids[@]}"; do
        wait "$pid" 2>/dev/null || true
    done

    for result_file in "${result_files[@]}"; do
        if [ -f "$result_file" ] && grep -qx "PASS" "$result_file"; then
            ((valid_count++))
        else
            ((invalid_count++))
        fi
    done

    rm -rf "$results_tmp"
}

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $0 <file|directory> [max-parallel]"
    exit 1
fi

input="$1"
max_parallel="${2:-$DEFAULT_MAX_PARALLEL}"

if ! [[ "$max_parallel" =~ ^[0-9]+$ ]] || [ "$max_parallel" -lt 1 ]; then
    echo "Error: max-parallel must be a positive integer"
    exit 1
fi

if [ ! -e "$input" ]; then
    echo "Error: '$input' does not exist"
    exit 1
fi

echo "========================================"
echo "Alloy Model Validity Checker"
echo "========================================"
echo ""

if [ -f "$input" ]; then
    # Single file
    if [[ "$input" == *.als ]]; then
        if check_file "$input" ""; then
            ((valid_count++))
        else
            ((invalid_count++))
        fi
    else
        echo "Error: '$input' is not an .als file"
        exit 1
    fi
elif [ -d "$input" ]; then
    # Directory
    process_directory "$input" "$max_parallel"
else
    echo "Error: '$input' is neither a file nor a directory"
    exit 1
fi

echo ""
echo "========================================"
echo "Summary"
echo "========================================"
echo "Valid:   $valid_count"
echo "Invalid: $invalid_count"
echo "Total:   $((valid_count + invalid_count))"
echo ""
echo "Valid models copied to: $VALID_DIR"
