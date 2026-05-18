The model is in module "hc4".

There is a set "Vertex" with two relations on each element of "Vertex": "left" and "right". Each "Vertex" has at most one "left" value and at most one "right" value.

There are two subsets of "Vertex", named "Joint" and "End". Every element of "Vertex" belongs to one of these two subsets.

The following constraints hold.

For every element of "End", one of these two conditions is true:
- its "left" value is absent, and the "left" value of its "right" value is that same element of "End"; or
- its "right" value is absent, and the "right" value of its "left" value is that same element of "End".

For every element of "Joint":
- following "left" and then "right" returns to that same element,
- following "right" and then "left" returns to that same element,
- its "left" value and its "right" value are different.

For every element of "Vertex", every other element of "Vertex" is reachable from it by a nonempty path consisting only of repeated "left" steps and/or repeated "right" steps. This means that for any chosen element of "Vertex", all elements of "Vertex" except that element itself belong to the set of elements reachable from it by repeatedly following "left" or repeatedly following "right".