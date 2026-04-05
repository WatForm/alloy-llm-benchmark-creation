// Sparrows are birds'
// penguins are birds
abstract sig bird {}
sig sparrow extends bird {}
sig penguin extends bird {}

// Some birds fly
sig flyer in bird{}
// all birds b such that b is in flyer
fact f1 {some b:bird | b in flyer} // all bird would create no instances
// { all b:bird - penguin | b in flyer} // equivilant
// 
// { all b:sparrow | b in flyer }

// no birds p such that b is in flyer
fact f2 { no p:penguin | p in  flyer}

// Sally is a sparrow
one sig sally extends sparrow {}
// frobisher is a penguin
one sig frobisher extends penguin {}

// lone means instantiate 0 or 1w


// Show command
pred show {}
run show
