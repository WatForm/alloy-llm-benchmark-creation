// from: https://github.com/elkel53930/software_abstructions/blob/master/ch04/4.5.1/ex_FileSystem.als
abstract sig Object {}
sig Directory extends Object {contents: set Object}
one sig Root extends Directory {}
sig File extends Object {}
fact{
	no d: Directory | d in d.^contents
	Object in Root.*contents
	all o: Object - Root | one o.~contents
	}

assert RootIsRoot{
	no d: Directory | d.contents = Root
	}

run {} for 5
