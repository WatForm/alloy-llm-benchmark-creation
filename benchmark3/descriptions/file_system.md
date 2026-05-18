There is a set "Object". Every "File" and every "Dir" is in "Object", and every "Object" is either a "File" or a "Dir". No element is both a "File" and a "Dir".

There is a set "Name".

There is a set "File". Every "File" is the "contents" of at least one "DirEntry" that belongs to the "entries" of some "Dir".

There is a set "Dir". Each "Dir" has:
- an "entries" relation to a set of "DirEntry" elements,
- a "parent" relation to at most one "Dir".

For every "Dir", the following constraints hold:
- Its "parent" is exactly the unique "Dir" whose "entries" contains a "DirEntry" whose "contents" is that "Dir". This means a "Dir" is the child directory named by an entry of its parent exactly when that parent is its "parent".
- Any two elements of its "entries" with the same "name" are the same "DirEntry".
- It is not in the transitive closure of its own "parent" relation.
- If it is not "Root", then "Root" is in the transitive closure of its "parent" relation.

There is exactly one "Root", and "Root" is a "Dir". "Root" has no "parent".

There is at most one "Cur", and "Cur" is a "Dir".

There is a set "DirEntry". Each "DirEntry" has:
- a "name" relation to exactly one "Name",
- a "contents" relation to exactly one "Object".

Every "DirEntry" belongs to the "entries" of exactly one "Dir".

The fact named "OneParent_correctVersion" states that every "Dir" other than "Root" satisfies both of the following:
- it has exactly one "parent",
- it is the "contents" of exactly one "DirEntry".