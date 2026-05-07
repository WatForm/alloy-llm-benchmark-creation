/*
 * Models the chord distributed hash table lookup protocol.
 *
 * For a detailed description, see:
 *
 * Chord: A Scalable Peer-to-peer Lookup Service for Internet Applications
 * Ion Stoica, Robert Morris, David Karger, M. Frans Kaashoek, and Hari Balakrishnan.
 *
 */

open util/relation as rel

sig Id {next: Id}
fact {all i: Id | Id in i.*next}

/**
 * true iff i precedes j in the order starting at from
 */
pred less_than [from, i,j: Id] {
        let next" = Id<:next - (Id->from) | j in i.^next"  // if from=j, returns true if # nodes > 1
        }
pred less_than_eq [from, i,j: Id] {
        let next" = Id<:next - (Id->from) | j in i.*next"
        }

sig Node {id: Id}
fact {all m,n: Node | m!=n => m.id != n.id}


sig NodeData {
        prev, next: Node,
        finger: Id -> lone Node,
        closest_preceding_finger: Id -> one Node,
        find_predecessor: Id -> one Node,
        find_successor: Id -> one Node
        }

one sig State {
        active: set Node,
        data: active -> one NodeData
        }

/**
 * node n"s next node is defined to be the m where n"s finger table maps the id
 * that follows n.id to m
 * next holds the first entry of the finger table
 */
fact {all s: State | all n: s.active | n.(s.data).next = n.(s.data).finger[n.id.next]}

pred NextCorrect [s: State] {
        all n: s.active {
                -- no intervening node (ie, close enough)
                no n": s.active - n | less_than [n.id, n".id, n.(s.data).next.id]
                -- can reach all other active nodes (ie, far enough)
                -- need this because can"t rule out case of next being node itself (because of 1-node ring)
                -- s.active in n.*(s.data.next)
                n.(s.data).next != n || #s.active = 1
                }
        }

fact {
      all s: State | NextCorrect[s]  
}


-- says that finger entry maps an id to a node so that there are no intervening nodes
-- between the id and the node
pred FingersCorrect [s: State] {
        all nd: s.active.(s.data) | all start:nd.finger.univ |
                nd.finger[start] in s.active &&
                (no n" : s.active | less_than [start, n".id, nd.finger[start].id])
        }

fact {
        all s : State | FingersCorrect[s]
}


pred ClosestPrecedingFinger[s: State] {
        all n: s.active | let nd = n.(s.data) |
                all i: Id | let cpf = nd.closest_preceding_finger[i] {
                        no n": nd.finger[Id] + n - cpf | less_than [cpf.id, n".id, i]
                        cpf in nd.finger[Id] + n
                        cpf.id != i || # s.active = 1
                        //less_than (n.id, cpf.id, i)
                }
        }

fact {
        all s : State | ClosestPrecedingFinger[s]
}


pred FindPredecessor[s: State] {
        all n: s.active | let nd = n.(s.data) | all i: Id {
                nd.find_predecessor[i] =
                        (less_than_eq [n.id, i, nd.next.id] && (n.id != i || # s.active = 1)
                        => n
                        else (nd.closest_preceding_finger[i].(s.data).find_predecessor)[i])
                }
        }

fact {
        all s : State | FindPredecessor[s]
}


pred FindSuccessor[s: State] {
        all n: s.active | let nd = (s.data)[n] | all i: Id {
                nd.find_successor[i] = ((s.data)[nd.find_predecessor[i]]).next
        }}
