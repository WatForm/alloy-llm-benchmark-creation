There is a set called "Object". Every "File" and every "Dir" is in "Object", and every "Object" is either a "File" or a "Dir" (not both). No element is both a "File" and a "Dir".
>>> Redundant information here, we say an object is not both file and dir, then right after say no element is both a file and dir - maybe just remove "(not both)"?

There is a set called "Name".

There is a set called "DirEntry". Each "DirEntry" has:
- a "name" relation to exactly one "Name",
- a "contents" relation to exactly one "Object".

There is a set "Dir". Each "Dir" has:
>>> Introducing the set "Dir" after already using it on the first line. Strange order for a human reading it.
- an "entries" relation to a set of "DirEntry" elements,
- a "parent" relation to at most one "Dir".

Every "File" is the "contents" of at least one "DirEntry" that belongs to the "entries" of some "Dir".
>>> "File" is never introduced as a set. Not sure if we want to be doing it, but all other sigs are.

Every "Dir"'s' "parent" is exactly the unique "Dir" whose "entries" contains a "DirEntry" whose "contents" is that "Dir". 

Any two elements of a "Dir"'s' "entries" with the same "name" are the same "DirEntry".
>>> This is how we implement the constraint, but I don't think this is a normal way to write it? As a human, it would make more sense to see something like "The names of a directories entries are unique" or "A directory's entries do not contain any duplicate names"

The "parent" relation contains no cycles.

Every "Dir" that is not the "Root", has "Root" reachable from it through its "parent" relation.
>>> remove comma? Does "reachable" always mean transitive closure?

There is exactly one "Root", and "Root" is a "Dir". "Root" has no "parent".

There is at most one "Cur", and "Cur" is a "Dir".
>>> cur != root I believe

Every "DirEntry" belongs to the "entries" of exactly one "Dir".
This means a "Dir" is the child directory named by an entry of its parent exactly when that parent is its "parent".
>>> redundant line above?, covered by "Every Dir's parent is..."

Every "Dir" other than "Root" has exactly one "parent" and is the "contents" of exactly one "DirEntry".