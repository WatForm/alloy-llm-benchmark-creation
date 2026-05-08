There is an abstract set "Listing".

"Address" and "Name" are disjoint subsets of "Listing". Every element of "Address" is a "Listing". Every element of "Name" is a "Listing". Because "Listing" is abstract, every "Listing" belongs to at least one of "Address" or "Name".

There is a set "Book". Each "Book" has:

- "entry", which is a set of "Name"
- "listed", which is a relation from elements of that book’s "entry" to elements of "Listing"

For any "Book" b and any "Name" n, "lookup[b,n]" is the set of all elements reachable from n by following the relation b."listed" one or more times transitively.

The following constraints hold:

- For every "Book" b and every "Name" n in b."entry", at most one "Listing" is related to n by b."listed".
- For every "Book" b and all "Name" elements n and l, if l is in "lookup[b,n]", then l is in b."entry".
- For every "Book" b and every "Name" n in b."entry", n is not in "lookup[b,n]".

Equivalently, within any "Book", the transitive targets reachable from a starting "Name" through "listed" are always "Name" elements that belong to that book’s "entry", and no "Name" in "entry" is transitively reachable from itself through one or more "listed" steps.