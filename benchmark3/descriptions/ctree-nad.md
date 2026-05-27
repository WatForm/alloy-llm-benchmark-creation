There is a set "Color" with exactly two distinct elements in it: "Red" and "Blue". 

There is a set called "Node". Each "Node" has "neighbors", which is a set of "Node"s.  Every "Node" has exactly "color", which is a "Color".

The relation "neighbors" is symmetric.  No "Node" is a "neighbour" of itself.


The graph formed by "neighbors" is connected: for every element "n1" of "Node" and every different element "n2" of "Node", "n1" is reachable from "n2" by following one or more "neighbors" links.

The graph formed by "neighbors" is acyclic in the following sense: for every two elements "n1" and "n2" of "Node", if "n1" is in the "neighbors" set of "n2", then there is no path from "n2" to "n1" that uses one or more "neighbors" links after removing the direct link from "n2" to "n1".

>>> uses terms "connected" and "acyclic" then explains them. Do we want this?