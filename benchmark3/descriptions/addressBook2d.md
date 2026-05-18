The model is in the module "tour/addressBook2d".

There is a set "Target".

There is a set "Addr" contained in "Target".

There is a set "Name" contained in "Target".

Every element of "Target" is in "Addr" or in "Name".

There are two sets, "Alias" and "Group", both contained in "Name".

Every element of "Name" is in "Alias" or in "Group".

There is a set "Book".

Each element of "Book" has a relation "addr" from "Name" to "Target".

For every element of "Book", there is no element of "Name" that can reach itself by following one or more steps of the "addr" relation.

For every element of "Book" and every element of "Alias", there is at most one element of "Target" related to that "Alias" by "addr".