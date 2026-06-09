// from: https://github.com/elkel53930/software_abstructions/blob/master/ch04/4.5.1/ex_Host.als
/*
sig Host {}
sig Link {from, to: Host}
fact {all x: Link | x.from != x.to}
*/

/*
sig Host {}
sig Link {from, to: Host} {from != to}
*/

sig Host {}
sig Link {from, to : Host}
	{some x: Link | x.@from = to and x.@to = from}

run {}
