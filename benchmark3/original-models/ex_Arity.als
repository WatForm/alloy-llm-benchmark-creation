// from: https://github.com/elkel53930/software_abstructions/blob/master/ch04/4.3.3/ex_Arity.als
sig A {r : B->C}
sig B {}
sig C {}

fact{
	all a:A | a.r in B -> one C
	}

run {} for 3
