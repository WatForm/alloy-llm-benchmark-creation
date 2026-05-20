There is a set called "Object". Every "File" and every "Dir" is in "Object", and every "Object" is either a "File" or a "Dir" (not both). No element is both a "File" and a "Dir".

There is a set called "Name".

There is a set called "DirEntry". Each "DirEntry" has:
- a "name" relation to exactly one "Name",
- a "contents" relation to exactly one "Object".

There is a set "Dir". Each "Dir" has:
- an "entries" relation to a set of "DirEntry" elements,
- a "parent" relation to at most one "Dir".

Every "File" is the "contents" of at least one "DirEntry" that belongs to the "entries" of some "Dir".

Every "Dir"'s' "parent" is exactly the unique "Dir" whose "entries" contains a "DirEntry" whose "contents" is that "Dir". 

Any two elements of a "Dir"'s' "entries" with the same "name" are the same "DirEntry".

The "parent" relation contains no cycles.

Every "Dir" that is not the "Root", has "Root" reachable from it through its "parent" relation.

There is exactly one "Root", and "Root" is a "Dir". "Root" has no "parent".

There is at most one "Cur", and "Cur" is a "Dir".

Every "DirEntry" belongs to the "entries" of exactly one "Dir".
This means a "Dir" is the child directory named by an entry of its parent exactly when that parent is its "parent".

Every "Dir" other than "Root" has exactly one "parent" and is the "contents" of exactly one "DirEntry".