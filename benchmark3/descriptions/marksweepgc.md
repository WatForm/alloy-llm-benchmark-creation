There is a set of atoms called "Node".

There is a set of atoms called "HeapState". Each "HeapState" has these relations:

- "left", a relation from "Node" to "Node" such that for any "Node", there is at most one "Node" related to it by "left".
- "right", a relation from "Node" to "Node" such that for any "Node", there is at most one "Node" related to it by "right".
- "marked", a set of "Node".
- "freeList", a relation to "Node" such that each "HeapState" is related to at most one "Node" by "freeList".

There are exactly two distinguished elements of "HeapState", named "h" and "h"".

There is exactly one distinguished element named "root", and it is a member of "Node".

A condition named "clearMarks" relates two elements of "HeapState", called the before-state and after-state, with all of the following requirements:

- the after-state has no marked nodes;
- the after-state has the same "left" relation as the before-state;
- the after-state has the same "right" relation as the before-state.

A derived set named "reachable" is determined from a "HeapState" and a starting "Node". It is the set containing the starting node together with every "Node" reachable from that starting node by following zero or more steps, where each step may use either the "left" relation or the "right" relation of that "HeapState".

A condition named "mark" relates a before-state, a starting "Node" called "from", and an after-state, with all of the following requirements:

- the marked set of the after-state is exactly the set "reachable" from "from" in the before-state;
- the after-state has the same "left" relation as the before-state;
- the after-state has the same "right" relation as the before-state.

A condition named "setFreeList" relates a before-state and an after-state, with all of the following requirements:

- every node reachable from the after-state’s "freeList" by following zero or more "left" steps is an element of "Node" that is not in the marked set of the before-state;
- for every "Node" not in the marked set of the before-state:
  - that node has no outgoing "right" relation in the after-state;
  - its "left" successor in the after-state, if any, is reachable from the after-state’s "freeList" by following zero or more "left" steps;
  - the node itself is reachable from the after-state’s "freeList" by following zero or more "left" steps;
- for every "Node" that is in the marked set of the before-state:
  - its "left" successor in the after-state is exactly the same as in the before-state;
  - its "right" successor in the after-state is exactly the same as in the before-state;
- the marked set of the after-state is exactly the same as the marked set of the before-state.

A condition named "GC" relates a before-state, a "Node" called "root", and an after-state, with the following requirement:

- there exist two "HeapState" elements, named "hs1" and "hs2", such that:
  - "clearMarks" holds between the before-state and "hs1";
  - "mark" holds between "hs1", "root", and "hs2";
  - "setFreeList" holds between "hs2" and the after-state.

A global constraint named "GCHappened" holds:

- "GC" holds between "h", "root", and "h"".