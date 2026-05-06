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

fact {
        all s : State | FingersCorrect[s]
}

fact {
        all s : State | ClosestPrecedingFinger[s]
}

fact {
        all s : State | FindPredecessor[s]
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

pred FingersCorrect" [s: State] {
        all n: s.active | let nd = (s.data)[n] | all start: Node.~(nd.finger) {
                nd.finger[start] in s.active &&
                (let next" = Id<:next - (nd.finger[start].id -> Id) {
                        no n" : s.active - nd.finger[start] {
                                n".id in start.*next"
                        }
                })
            }
        }

pred ClosestPrecedingFinger"[s: State] {
        all n: s.active | let nd = (s.data)[n] | all i: Id {
                let next" = Id<:next - (Id -> i) {
                        nd.next.id in n.id.^next" =>
                                // nd.closest_preceding_finger[i] = nd.next,
                                (some n1: nd.finger[Id] {
                                        nd.closest_preceding_finger[i] = n1
                                        //n1 in nd.finger[Id]
                                        n1.id in n.id.^next"
                                        no n2: nd.finger[Id] | n2.id in n1.id.^next"
                                }) else
                        nd.closest_preceding_finger[i] = n
                }}
        }

pred FindPredecessor"[s: State] {
        all n: s.active | let nd = (s.data)[n] | all i: Id {
                let next" = Id<:next - (nd.next.id -> Id) {
                        one s.active or i in n.id.^next" =>  // *next" -> ^next" 1/8/02
                        nd.find_predecessor[i] = n else
                        nd.find_predecessor[i] =
                        ((s.data)[nd.closest_preceding_finger[i]]).find_predecessor[i]
                }}
        }
```
removed


Removed commands:

```
assert FPisActive {
        all s: State | FingersCorrect[s] && ClosestPrecedingFinger[s] && FindPredecessor[s]
        => (all n: s.active | all nd: n.(s.data) | nd.find_predecessor[Id] in s.active) }
check FPisActive for 3 but 1 State expect 1





assert SameFP {all s: State | FingersCorrect[s] // && s.active = Node
        => (FindPredecessor [s] iff FindPredecessor" [s])}

assert SameFP1 {
        all s: State | FingersCorrect[s] && s.active = Node
                => (FindPredecessor [s] => FindPredecessor" [s])}
assert SameFP2 {
        all s: State | FingersCorrect[s] && s.active = Node
                => (FindPredecessor" [s] => FindPredecessor [s])}

check SameFP for 3 but 1 State expect 1
check SameFP1 for 3 but 1 State expect 0
check SameFP2 for 3 but 1 State expect 0

assert SameCPF {all s: State | FingersCorrect[s] => (ClosestPrecedingFinger [s] iff ClosestPrecedingFinger" [s])}
assert SameCPF1 {all s: State | FingersCorrect[s] => (ClosestPrecedingFinger [s] => ClosestPrecedingFinger" [s])}
assert SameCPF2 {
        all s: State | ((s.active = Node && FingersCorrect[s] && ClosestPrecedingFinger" [s])
         => ClosestPrecedingFinger [s]) }

check SameCPF for 3 but 1 State expect 0
check SameCPF1 for 2 but 1 State expect 0
check SameCPF2 for 3 but 1 State expect 0

// valid
assert Same1 {all s: State | NextCorrect[s] => NextCorrect"[s]}
check Same1 for 3 but 1 State expect 0

// valid unless active condition removed
assert Same2 {all s: State | s.active = Node => (NextCorrect"[s] => NextCorrect[s])}
check Same2 for 3 but 1 State expect 0

-- assert NextInFinger {all s: State | all n: s.active | some n.s.data.finger[n.id.next] }

assert SameFC {all s: State | FingersCorrect [s] iff FingersCorrect"[s]}
check SameFC for 3 but 1 State expect 0


pred ShowMeFC {
        all s : State | s.active = Node && FingersCorrect[s]
}

run ShowMeFC for 2 but 1 State expect 1


assert InjectiveIds {all i, j: Id | i!=j => i.next != j.next}
check InjectiveIds for 5 expect 0

assert FindSuccessorWorks {
        all s: State, i: Id |
                let nd = s.active.(s.data) |
                let succ = nd.find_successor [i] |
                        FingersCorrect [s] // && s.active = Node
                                => (no n": s.active | less_than [i, n".id, succ.id])
        }
check FindSuccessorWorks for 3 but 1 State expect 1



pred ShowMe1Node  {
        #Node = 1
        all s : State | NextCorrect[s]
        State.active = Node
}

run ShowMe1Node for 2 but 1 State, 1 Node expect 1

pred ShowMe1  {
        #Node = 2
        #State = 1
        all s : State | NextCorrect[s]
        State.active = Node
}


pred ShowMe2  {
        #Node = 3
        #State = 1
        all s : State | NextCorrect[s] && FingersCorrect[s]
        State.active = Node
        //all n: NodeData | one n.finger[Id]
}


assert OK1 {
        #Node = 3 &&
        #State = 1 &&
        (all s : State | NextCorrect[s] && FingersCorrect[s]) &&
        State.active = Node
}


run ShowMe1 for 3 expect 1
run ShowMe2 for 3 expect 1


pred ShowMeCPF {
        all s : State | s.active = Node && FingersCorrect[s] &&
        // not ClosestPrecedingFinger(s) && ClosestPrecedingFinger"(s)
        ClosestPrecedingFinger[s]
        //all s : State | all nd : s.active.s.data | nd.finger[Id] = Node
        # Node = 2
        # State = 1
}


run ShowMeCPF for 2 but 1 State expect 1

```


