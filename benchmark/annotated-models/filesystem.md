## Changes

- none

## Comments


- There are files, dirs and a root

- The root is itself not a file or a dir

- files and dirs are fundamentally different

- There is exactly one root

- The contents relation represents immediate children, the transitive closure operator represents a recursive walk of the dir/root

- RootTop produces a counterexample because there is no fact that says nothing can contain root, or contain something that itself contains root, and so on.

- The only fact given says that the whole system must contain one object besides the root itself