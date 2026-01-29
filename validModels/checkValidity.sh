#!/bin/bash

# Usage: ./checkValidity.sh file/dir

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JAR_PATH="$SCRIPT_DIR/jars/alloy-diff.jar"
VALID_DIR="$SCRIPT_DIR/validModels"

valid_count=0
invalid_count=0
base_dir=""

mkdir -p "$VALID_DIR"

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
    
    output=$(java -cp "$JAR_PATH" org.alloytools.alloy.diff.ModuleDiff "$file" "$file" Equivalence 1 false sat4j 2>&1)
    
    if echo "$output" | grep -q "The two modules are equivalent."; then
        echo "  [PASS] Alloy-diff compatible"
        return 0
    else
        echo "  [FAIL] Not alloy-diff compatible"
        return 1
    fi
}

check_file() {
    local file="$1"
    
    # Run all checks
    if ! check_primed_vars "$file"; then
        ((invalid_count++))
        return 1
    fi
    
    if ! check_single_file "$file"; then
        ((invalid_count++))
        return 1
    fi
    
    if ! check_alloy_diff_compatible "$file"; then
        ((invalid_count++))
        return 1
    fi
    
    # All checks passed
    echo "  [PASS] All checks passed"
    if [ -n "$base_dir" ]; then
        rel_path="${file#$base_dir/}"
    else
        rel_path=$(basename "$file")
    fi
    
    target_path="$VALID_DIR/$rel_path"
    mkdir -p "$(dirname "$target_path")"
    cp "$file" "$target_path"
    ((valid_count++))
}

process_directory() {
    local dir="$1"
    base_dir="$dir"
    
    while IFS= read -r -d '' file; do
        check_file "$file"
    done < <(find "$dir" -type f -name "*.als" -print0)
}

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file|directory>"
    exit 1
fi

input="$1"

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
        check_file "$input"
    else
        echo "Error: '$input' is not an .als file"
        exit 1
    fi
elif [ -d "$input" ]; then
    # Directory
    process_directory "$input"
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
