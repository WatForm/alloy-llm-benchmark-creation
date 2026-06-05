There is a set called "Target".

The set "Addr" is contained in "Target".
The set "Name" is also contained in "Target".
>>> do we want to be saying set is "containd in" a set
>> Is this the standard way to deal with sig hierarchies? I could see it being rephrased as "all Addrs are Targets" and "all Names are targets"
The sets "Addr" and "Name" are disjoint and together they contain all elements of "Target"
There are two sets, "Alias" and "Group" that partition "Name".

There is a set called "Book".  Each book is given a "Name" and a "Target" by the "addr" relation.
>>> does "given a... by the addr relation" make sense here
>> I think it does

For every book, there is no element of "Name" that can reach itself by following one or more steps of the "addr" relation of the book.

For every element of "Book" and every element of "Alias", every "Alias" can reach at most one "Target" of every "Book".
