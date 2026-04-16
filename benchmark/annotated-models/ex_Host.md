## Changes

```
/*
sig Host {}
sig Link {from, to: Host}
fact {all x: Link | x.from != x.to}
*/

/*
sig Host {}
sig Link {from, to: Host} {from != to}
*/

```

removed comments

```
run {}
```

removed empty run

## Comments

- The model is isomorphic to a directed graph
- Hosts are nodes
- Links are edges
- There is a fact that a self-loop exists