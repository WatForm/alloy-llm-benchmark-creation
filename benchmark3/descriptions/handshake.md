The model is in the module named "handshake".

There is a set of elements called "Person". Each "Person" has exactly one "spouse", which is a "Person", and a set called "shaken", whose members are "Person" elements.

There are exactly two distinguished "Person" elements named "Jocelyn" and "Hilary".

The following constraints hold.

For every "Person", neither that person nor that person’s "spouse" is in that person’s "shaken" set.

For all "Person" elements, if one person is in another person’s "shaken" set, then the second person is in the first person’s "shaken" set.

For every two distinct "Person" elements, if one person’s "spouse" is the other, then the other’s "spouse" is the first.

For every two distinct "Person" elements, their "spouse" values are different.

For every "Person", the "spouse" of that person’s "spouse" is that person.

For every "Person", that person is not that person’s own "spouse".

"Hilary"’s "spouse" is "Jocelyn".

For all distinct "Person" elements other than "Jocelyn", the number of people in one person’s "shaken" set is different from the number of people in the other person’s "shaken" set.