The model imports the util/relation module.

There is a set of elements called N.

Each element of N is related by suivant to a set of elements of N. The relation suivant is therefore a relation from N to N, and each element of N may be related by suivant to any number of elements of N, including none.

The relation suivant is acyclic over N. No element of N is reachable from itself by following one or more links of suivant.

No pair of elements belongs both to suivant and to the transitive closure of suivant followed by at least one more step. This means there do not exist elements of N such that one is related to the other by a direct suivant link and also related to the same other element by a path of length at least two using suivant.