There is a set called "Listing". Every "Address" is a "Listing", and every "Name" is a "Listing". Every "Listing" is either an "Address" or a "Name", and nothing is both an "Address" and a "Name".

There is a set called "Book". Each "Book" has:

- "entry", which is a set of "Name"
- "listed", which is a relation from elements of that book’s "entry" to sets of "Listing"

For every "Book" and every "Name" in that book’s "entry", there is at most one "Listing" related to that "Name" by that book’s "listed".

There is a derived concept called "lookup". For any "Book" and any "Name", "lookup" is the set of all "Listing" values reachable from that "Name" by following that book’s "listed" relation one or more times.

For every "Book" and all "Name" values "n" and "l", if "l" is in "lookup" for that book and "n", then "l" is in that book’s "entry".

For every "Book" and every "Name" in that book’s "entry", that "Name" is not in "lookup" for itself in that book.