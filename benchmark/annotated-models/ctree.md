## Changes

```
run {} for 3 Node

```

is removed

## Opinions

The model is self-explanatory. The fact `undirected` includes the condition for no self-edges.


```
fact treeAcyclic {
  all n1, n2: Node | n1 in n2.neighbors implies 
    n1 not in n2.^(neighbors-(n2->n1)) } 
```

Consider a node n1 and let n2 be a neighbour. If the edge from n1 to n2 is removed, it should be impossible to reach n2 from n1. If this property holds for every (n1,n2), then the tree is acyclic.