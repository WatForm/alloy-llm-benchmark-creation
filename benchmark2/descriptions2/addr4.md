There is a set "Listing". Every "Address" is a "Listing", and every "Name" is a "Listing". "Listing" contains only "Address" and "Name", so every "Listing" is either an "Address" or a "Name".

There is a set "Book". Each "Book" has:

- "entry", which is a set of "Name"
- "listed", which relates each element of "entry" to a set of "Listing"

The relation "listed" is constrained so that, for every "Book" and every "Name" in that book’s "entry", there is at most one "Listing" related to that "Name" by that book’s "listed".

There is a derived mapping "lookup" with arguments "b" of type "Book" and "n" of type "Name". "lookup[b,n]" is the set of all "Listing" elements reachable from "n" by following the relation "b.listed" one or more times.

The following constraints hold:

- For every "Book", for every "Name" "n", and for every "Name" "l", if "l" is in "lookup[b,n]", then "l" is in "b.entry".
- For every "Book" and every "Name" in that book’s "entry", that "Name" is not in "lookup[b,n]". In other words, no "Name" in a book’s "entry" can reach itself by one or more steps through that book’s "listed" relation.