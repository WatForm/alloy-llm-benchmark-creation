The model is named FullTree.

It contains a set called Node. Each element of Node has two relations named left and right, and each of these relates a Node to zero or more elements of Node.

For every element of Node, the set of left-related Nodes has at most one element, and the set of right-related Nodes has at most one element.

The following constraints hold for every element of Node.

No Node is reachable from itself by following one or more steps through left or right.

Each Node has at most one incoming left-or-right relation from other Nodes. That is, for any Node, there is at most one Node that relates to it through either left or right.

For any Node, no Node is both in its left relation and in its right relation.

For every Node, the number of Nodes reachable from it by zero or more left steps is equal to the number of Nodes reachable from it by zero or more right steps. This count includes the Node itself.