-- Our world contains nodes (aka vertices)
sig Node { }

-- hamPath takes three parameters:
-- p (a relation between nodes)
-- start (a node)
-- end (a node)
-- and returns true if p is a Hamiltonian path from start to end
pred hamPath(p: Node->Node, start: Node, end: Node) {

	-- three things have to be true for p to be a Hamiltonian path from start to end:

	// (1) every node (except one) has a successor in the path
	all n: Node - end | one n': Node | n -> n' in p 

	// (2) every node (except one) has a predecessor in the path
	all n: Node - start | one n':Node| n' -> n in p
 	
	// (3) no node appears more than once in the path
	// (Helpful hint: n.^p returns the set of nodes that are reachable from n via p)
	all n: Node | !n in n.^p

	
}

run hamPath for 5 Node
