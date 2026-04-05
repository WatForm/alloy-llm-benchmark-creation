
abstract sig Node {
	next: lone Node
}

one sig N1, N2, N3, N4 extends Node {}

abstract sig Path{
	s: one Node,
	f: one Node
}

one sig P1,P2,P3 extends Path{}

fact{
	// This is the actual syntax to make pairs (A ->B) = (A,B)
	// We add them into a big join table
	// Then the compiler matches A with B
	next = N1->N2 + N2->N3 + N3->N4


	s = P1->N1 + P2->N2 + P3->N3
	f = P1->N2 + P2->N3 + P3->N4

//	#s < 3
//	#f < 3
	no next & iden -- iden, relationship for every element to itself4
}
pred show {}
run show
