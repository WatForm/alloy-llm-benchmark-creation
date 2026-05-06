## Changes:

`check { OneParent_correctVersion => NoDirAliases } for 5 expect 0` is removed entirely, since no c/e expected


```
/**
 * all directories besides root have one parent
 */
pred OneParent_buggyVersion {
    all d: Dir - Root | one d.parent
}

/**
 * all directories besides root have one parent
 */
pred OneParent_correctVersion {
    all d: Dir - Root | (one d.parent && one contents.d)
}

/**
 * Only files may be linked (that is, have more than one entry)
 * That is, all directories are the contents of at most one directory entry
 */
pred NoDirAliases {
    all o: Dir | lone o.~contents
}

check { OneParent_buggyVersion => NoDirAliases } for 5 expect 1

```

all these removed, 

```
fact OneParent_correctVersion {
    all d: Dir - Root | (one d.parent && one contents.d)
}

```

added


TODO:

- OneParent_correctVersion becomes a face
- drop all the commands and orphan predicates