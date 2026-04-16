## Changes

removed `run {} for 3`, which is an empty run command with a specific scope

## Description

This model is a test for how arity works: r is a relation in A->B->C, which is further restricted by a fact, that says that every tuple in B->C associated with a given A, is in B -> one C.

In other words, each element of A maps to one element of C, but does so via multiple elements of B