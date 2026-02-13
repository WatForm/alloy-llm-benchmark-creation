#!/usr/bin/env python3

import os
import sys
import subprocess
from pathlib import Path
import argparse

def main():
    # Check if all three arguments are provided
    if len(sys.argv) != 4:
        print("Usage: python master.py <string_arg> <source_folder> <destination_folder>")
        print("Example: python master.py test /path/to/source /path/to/dest")
        sys.exit(1)
    
    arg1 = sys.argv[1]
    source_folder = os.path.abspath(sys.argv[2])
    dest_folder = os.path.abspath(sys.argv[3])
    
    # Create destination folder if it doesn't exist
    os.makedirs(dest_folder, exist_ok=True)
    
    # Counter for tracking
    processed = 0
    failed = 0
    
    # Recursively walk through source folder
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
                
                try:
                    # Spawn process to run temp.sh with arguments
                    print(f"Processing: {als_path} -> {md_path}")
                    
                    # Using subprocess.Popen to spawn processes (non-blocking)
                    # For sequential processing, use subprocess.run() instead
                    process = subprocess.Popen([
                        './scripts/unit.sh',
                        arg1,
                        als_path,
                        md_path
                    ])
                    
                    # If you want to wait for each process to complete before moving to next:
                    # process.wait()
                    
                    processed += 1
                    
                    # Optional: Add small delay if needed
                    # import time
                    # time.sleep(0.1)
                    
                except Exception as e:
                    print(f"Error processing {als_path}: {e}", file=sys.stderr)
                    failed += 1
    
    print(f"\nCompleted: {processed} files processed, {failed} failed")

if __name__ == "__main__":
    main()