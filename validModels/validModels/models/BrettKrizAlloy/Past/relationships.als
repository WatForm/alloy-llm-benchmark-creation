sig SomeSet{
	someRelation: one SomeSet
}

sig ONE, TWO extends SomeSet{}

fact {
	someRelation = ~someRelation
	no someRelation & iden // Cant have self looping relationship


	someRelation = ONE->TWO + TWO->ONE
}

pred show{}
run show
