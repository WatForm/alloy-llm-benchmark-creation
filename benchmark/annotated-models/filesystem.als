module chapter4/filesystem ----- The model from page 125

abstract sig Object {}

sig Dir extends Object {contents: set Object}

one sig Root extends Dir { }

sig File extends Object {}

fact {
	Object in Root.*contents
	}



assert RootTop {
	no o: Object | Root in o.contents
	}
check RootTop // This assertion should produce a counterexample


