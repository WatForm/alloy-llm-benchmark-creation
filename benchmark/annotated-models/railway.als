
/*
 * A simple model of a railway system. Trains sit on segments of tracks
 * and segments overlap one another. It shows a that simple gate policy
 * does not ensure train safety.
 *
 * author: Daniel Jackson
 */

sig Seg {next, overlaps: set Seg}
fact {all s: Seg | s in s.overlaps}
fact {all s1, s2: Seg | s1 in s2.overlaps => s2 in s1.overlaps}

sig Train {}
sig GateState {closed: set Seg}
sig TrainState {on: Train -> lone Seg, occupied: set Seg}
fact {all x: TrainState |
  x.occupied = {s: Seg | some t: Train | t.(x.on) = s}
  }

sig ts in Train{}
one sig x, x" in TrainState {}
one sig g extends GateState {}

pred Safe [x: TrainState] {all s: Seg | lone s.overlaps.~(x.on)}

pred MayMove [g: GateState, x: TrainState, ts: set Train] {
  no ts.(x.on) & g.closed
  }

pred TrainsMove [x, x": TrainState, ts: set Train] {
  all t: ts | t.(x".on) in t.(x.on).next
  all t: Train - ts | t.(x".on) = t.(x.on)
  }

pred GatePolicy [g: GateState, x: TrainState] {
  x.occupied.overlaps.~next in g.closed
  all s1, s2: Seg | some s1.next.overlaps & s2.next => lone (s1+s2) - g.closed
}


pred TrainsMoveLegal [x, x": TrainState, g: GateState, ts: set Train] {
  TrainsMove [x, x", ts]
  MayMove [g, x, ts]
  GatePolicy [g, x]
  }

fact forceMovementToOccur {
  TrainsMoveLegal[x, x", g, ts]
}