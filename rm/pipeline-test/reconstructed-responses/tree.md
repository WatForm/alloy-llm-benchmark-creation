Here is a basic skeleton of an Alloy model which captures the specifications you described:

```alloy
module appendixA/tree

abstract sig Node {}

pred isTree [r: Node -> Node] {
  // constraints that r must fulfill to be a considered a tree go here
}

run isTree for 4 Nodes
```

In this model skeleton, 'Node' is an abstract signature which represents an element in the universe we're considering, and 'r' is a relation that maps Nodes to Nodes. The 'isTree' predicate is incomplete and needs user-defined constraints for 'r' to be considered a 'tree'. 

The 'run' command tests the 'isTree' predicate for a universe of four Nodes.