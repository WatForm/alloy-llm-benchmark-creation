There is a set called "Listing". Every "Address" is a "Listing", and every "Name" is a "Listing". Every element of "Listing" belongs to either "Address" or "Name".

>>> Address and name are disjoint?

There is a set called "Book". Each "Book" has:

- an "entry" relation to a set of "Name" elements
- a "listed" relation from its "entry" elements to a set of "Listing" elements

For any "Book" and any "Name", "lookup" is the set of all "Listing" elements reachable from that "Name" by following the "listed" relation one or more times within that "Book".

The following constraints hold:

- For every "Book" and every "Name" in its "entry" set, that "Name" is related by "listed" to at most one "Listing".
- For every "Book" and all "Name" elements n and l, if l is in "lookup" for n in that "Book", then l is in the "entry" set of that "Book".
- For every "Book" and every "Name" in its "entry" set, that "Name" is not in its own "lookup" set in that "Book".