There are three sets named "Father", "Mother", and "Child".

Each element of "Child" is related to exactly one element of "Father" by "father".

Each element of "Child" is related to exactly one element of "Mother" by "mother".

Each element of "Child" is related by "brothers" to a set of elements of "Child". A child may be related to any number of children by "brothers", including none.

The following constraints apply to all elements of "Child":

- For any two children, if they have the same "father" and the same "mother", and one of them is in the other’s "brothers" set, then the reverse also holds: the second is in the first’s "brothers" set.
- No child is in its own "brothers" set.