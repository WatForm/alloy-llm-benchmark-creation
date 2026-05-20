The model is in the module "tour/addressBook2d".
>>> do we want the above line?

There is a set "Target".

There is a set "Addr" contained in "Target".
>>> is "contained in" good wording here? should it be subset of? (makes it sound like set is contained in a set)

There is a set "Name" contained in "Target".

Every element of "Target" is in "Addr" or in "Name".
>>> disjoint

There are two sets, "Alias" and "Group", both contained in "Name".

Every element of "Name" is in "Alias" or in "Group".
>>> disjoint

There is a set "Book".

Each element of "Book" has a relation "addr" from "Name" to "Target".
>>> is addr technically a ternary relation?

For every element of "Book", there is no element of "Name" that can reach itself by following one or more steps of the "addr" relation.
>>> restricted to the specific book?

For every element of "Book" and every element of "Alias", there is at most one element of "Target" related to that "Alias" by "addr".