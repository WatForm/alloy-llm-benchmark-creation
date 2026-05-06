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




State changed to one sig
```
one sig State {
        active: set Node,
        data: active -> one NodeData
        }
```

```
fact {all s: State | all n: s.active | n.(s.data).next = n.(s.data).finger[n.id.next]}

```
- no changes to this



```
fact {
      all s: State | NextCorrect[s]  
}
```
added


```
pred NextCorrect" [s: State] {
-- next seems to be correct for 1,2,3 nodes
        all n: s.active | let nd = (s.data)[n] {
                let next" = Id<:next - (Id -> nd.next.id) {
                        no n" : s.active { n".id in n.id.^next" }
                }}
        }
```
removed


