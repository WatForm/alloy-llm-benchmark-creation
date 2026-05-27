There is a set called "Listing". Every "Address" is a "Listing", and every "Name" is a "Listing". Every element of "Listing" belongs to either "Address" or "Name".  There are no "Listings"s that are not "Address"es or "Name"s.

There is a set called "Book". A "Book" can have an "entry" that is a set of "Name" elements. A "Book" can be "listed", which is a mapping to its "entry" and a set of "Listing"s.

The result of looking up a book and a name is the set of all "Listing" elements reachable from that name by following the "listed" relation starting with that book, one or more times.

There is at most one element in the "listed" relation for a book and all the names in a book's entry.

If a "Name" is in the set resulting from looking up a book and a name, then that name is in that book's entry.

All names in a book's entry cannot be in the set resulting from looking up that book and the name.


