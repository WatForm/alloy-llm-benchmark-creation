There is a set called "Target".

The set "Addr" is contained in "Target".
The set "Name" is also contained in "Target".
The sets "Addr" and "Name" are disjoint and together they contain all elements of "Target"
There are two sets, "Alias" and "Group" that partition "Name".

There is a set called "Book".  Each book is given a "Name" and a "Target" by the "addr" relation.

For every book, there is no element of "Name" that can reach itself by following one or more steps of the "addr" relation of the book.

For every element of "Book" and every element of "Alias", 

Every "Alias" can reach at most one "Target" of every "Book".
