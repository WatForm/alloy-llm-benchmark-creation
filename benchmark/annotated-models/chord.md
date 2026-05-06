- Involves Music, requires external knowledge to make sense

- Checks and asserts need to be inverted


Proposed strategy:

```
All checks with expect 0, and associated asserts can be removed

questions: what is to be done with runs and cardinalities?

```



TODO:

This is a primitive version of chord
The actual model uses the ordering module


every command has one State, thus it can be enfoced on the state directly

one sig S extends state  (don't do this)


line 50 becomes a fact
drop nextCorrect'', make nextcorrect a fact, drop arguments

since fingercorrect and fingercorrect' are the same, pick fingercorrect and make fact and drop argument (using one sig)

at closest-preceding finger, on line 138

make closest-preceding finger a fact and drop the argument
then closest-preceding finger' is dropped


findpredecessor - two of them, there is a proof that they are <=>
take original and apply to some constant s


line 48 - fact gets augmented to make it one state


try running in the AA




