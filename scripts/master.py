#!/usr/bin/env python3

import os
import sys
import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed


def process_one(script_name, als_path, md_path):
    result = subprocess.run([
        './scripts/unit.sh',
        script_name,
        als_path,
        md_path
    ])
    return als_path, md_path, result.returncode

def main():
    # Check if required arguments are provided
    if len(sys.argv) < 4 or len(sys.argv) > 5:
        print("Usage: python master.py <scriptname> <source_folder> <destination_folder> [max_parallel]")
        print("Example: python master.py openAI /path/to/source-folder /path/to/dest-folder 4")
        sys.exit(1)
    
    arg1 = sys.argv[1]
    source_folder = os.path.abspath(sys.argv[2])
    dest_folder = os.path.abspath(sys.argv[3])
    max_parallel = int(sys.argv[4]) if len(sys.argv) == 5 else 4

    if max_parallel < 1:
        print("Error: max_parallel must be at least 1")
        sys.exit(1)
    
    # Create destination folder if it doesn't exist
    os.makedirs(dest_folder, exist_ok=True)
    
    # Counter for tracking
    processed = 0
    failed = 0
    
    jobs = []

    # Recursively walk through source folder and collect jobs
    for root, dirs, files in os.walk(source_folder):
        for file in files:
            if file.endswith('.als'):
                # Get full path of .als file
                als_path = os.path.join(root, file)
                
                # Create relative path to preserve folder structure
                rel_path = os.path.relpath(als_path, source_folder)
                rel_path_without_ext = os.path.splitext(rel_path)[0]
                
                # Create corresponding .md path in destination folder
                md_filename = rel_path_without_ext + '.md'
                md_path = os.path.join(dest_folder, md_filename)
                
                # Create subdirectories in destination if needed
                os.makedirs(os.path.dirname(md_path), exist_ok=True)

                jobs.append((als_path, md_path))

    if not jobs:
        print("No .als files found.")
        return

    print(f"Discovered {len(jobs)} model(s). Running with max_parallel={max_parallel}.")

    with ThreadPoolExecutor(max_workers=max_parallel) as executor:
        future_map = {
            executor.submit(process_one, arg1, als_path, md_path): (als_path, md_path)
            for als_path, md_path in jobs
        }

        for future in as_completed(future_map):
            als_path, md_path = future_map[future]
            try:
                _, _, returncode = future.result()
                if returncode == 0:
                    print(f"Done: {als_path} -> {md_path}")
                    processed += 1
                else:
                    print(f"Error processing {als_path}: exit code {returncode}", file=sys.stderr)
                    failed += 1
            except Exception as e:
                print(f"Error processing {als_path}: {e}", file=sys.stderr)
                failed += 1
    
    print(f"\nCompleted: {processed} files processed, {failed} failed")
    if failed > 0:
        sys.exit(1)

if __name__ == "__main__":
    main()