The model is named "SinglyLinkedList".

There are two sets, "List" and "Node".

Each element of "List" has a relation named "header" to elements of "Node". For any element of "List", "header" relates it to at most one element of "Node", and it may relate it to none.

Each element of "Node" has a relation named "link" to elements of "Node". For any element of "Node", "link" relates it to at most one element of "Node", and it may relate it to none.

The following constraint holds for every element of "List":

- either its "header" is absent,
- or there exists some element reachable from its "header" by following "link" zero or more times such that that element has no "link" target.

This means that for every "List", either the list has no header, or among the nodes reachable from the header by repeatedly following "link", including the header itself, there is at least one node whose "link" is absent.