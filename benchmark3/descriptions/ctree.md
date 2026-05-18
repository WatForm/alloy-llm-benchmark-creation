There is a set "Color" with exactly two distinct elements in it: "Red" and "Blue". Every element of "Color" is either "Red" or "Blue".

There is a set "Node". Each element of "Node" has:
- a relation "neighbors" to a set of elements of "Node"
- a relation "color" to exactly one element of "Color"

The relation "neighbors" is undirected: for any two elements of "Node", one is in the other's "neighbors" set exactly when the second is in the first one's "neighbors" set.

No element of "Node" is in its own "neighbors" set.

The graph formed by "Node" and "neighbors" is connected: for every element "n1" of "Node" and every different element "n2" of "Node", "n1" is reachable from "n2" by following one or more "neighbors" links.

The graph formed by "Node" and "neighbors" is acyclic in the following sense: for every two elements "n1" and "n2" of "Node", if "n1" is in the "neighbors" set of "n2", then there is no path from "n2" to "n1" that uses one or more "neighbors" links after removing the direct link from "n2" to "n1".