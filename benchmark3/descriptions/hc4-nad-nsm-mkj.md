There is a set called "Vertex". Each "Vertex" has at most one "left" value and at most one "right" value.

There are two non-overlapping subsets of "Vertex", named "Joint" and "End". Every element of "Vertex" belongs to one of these two subsets.

>> rephrase to "every vertex is a Joint or an End", more natural-sounding

For every "End", either:
- its "left" value is absent, and it is equal to the "left" value of its "right" value ; or
>>> not clear to me if "it" referees to the "End" or its "left" value
>> agreed
- its "right" value is absent, and it is equal to the "right" value of its "left" value.

For every "Joint":
- following "left" and then "right" returns to that same element, and
- following "right" and then "left" returns to that same element, and
- its "left" value and its "right" value are different.

For every element of "Vertex", every other element of "Vertex" is reachable from it by a nonempty path consisting only of repeated "left" steps and/or repeated "right" steps. This means that for any chosen element of "Vertex", all elements of "Vertex" except that element itself belong to the set of elements reachable from it by repeatedly following "left" or repeatedly following "right".
>>> restating the same thing twice