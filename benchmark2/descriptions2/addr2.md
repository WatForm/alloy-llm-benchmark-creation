There are three kinds of elements named "Listing", "Address", and "Name".

"Listing" contains all listing elements. "Address" and "Name" are both subsets of "Listing". Every "Address" is a "Listing". Every "Name" is a "Listing". "Address" and "Name" together make up all of "Listing", so every "Listing" is either an "Address" or a "Name", and there are no other kinds of "Listing".

There is also a kind of element named "Book".

Each "Book" has a relation named "entry" from that "Book" to zero or more "Name" elements. So each "Book" is associated with a set of "Name" elements through "entry".

Each "Book" also has a relation named "listed" from the "Name" elements in that book’s "entry" set to zero or more "Listing" elements. For any given "Book", every pair in "listed" starts with a "Name" that is in that book’s "entry", and ends with a "Listing".

The function named "lookup" takes a "Book" and a "Name" and returns the set of "Listing" elements reachable from that "Name" by following the "listed" relation of that "Book" one or more times transitively.

The following constraints hold.

For every "Book" and every "Name" in that book’s "entry", there is at most one "Listing" related to that "Name" by that book’s "listed" relation.

For every "Book" and all "Name" elements "n" and "l", if "l" is in "lookup" of that book and "n", then "l" is in that book’s "entry". In other words, any "Name" reached by transitively following "listed" from a starting "Name" must itself be one of the same book’s entries.

For every "Book" and every "Name" in that book’s "entry", that "Name" is not in "lookup" of that book and itself. So no entry "Name" can reach itself by following the book’s "listed" relation one or more times transitively.

There are no other named conditions, checks, run commands, scopes, or expected results.