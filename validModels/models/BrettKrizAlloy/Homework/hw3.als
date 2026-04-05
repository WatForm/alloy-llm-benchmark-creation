
abstract sig Class{
	takers: some Enroll
}
one sig A,B,C,D,E,F,G,H,I,J extends Class{}

abstract sig Student {}
//	classes: some Class,
//	enrolls: some Enroll
//}
//one sig Bill, John, Sara, Mary extends Student {}

abstract sig Enroll {
	stu: one Student,
	cls: one Class
}

one sig E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13 extends Enroll {}

one sig Bill extends Student{
	takes = (A+B+C),
	enrolls = (E1+E2+E3)
}
one sig Sara extends Student{
	takes = (C+D),
	enrolls = (E4+E5)
}
one sig John extends Student{
	takes = (F+G+H+I),
	enrolls = (E6+E7+E8+E9)
}
one sig Mary extends Student{
	takes = (D+G+C+J),
	enrolls = (E10+E11+E12+E13)
}



fact{
//	enrolls = Bill->(E1+E2+E3)
//	+ Sara->(E4+E5)
//	+ John->(E6+E7+E8+E9)
//	+ Mary->(E10+E11+E12+E13)

	cls = E1->A + E2->B + (E3+E12)->C 
	+ (E4+E10)->D + E5->E + E6->F 
	+ (E7+E11)->G + E8->H + E9->I + E13->J

	takers = A->E1 + B->E2 + C->(E3+E12) 
	+ D->(E4+E10) + E->E5 + F->E6
	+ G->(E7+E11) + H->E8 + I->E9 + J->E13

	stu = (E1+E2+E3)->Bill
	+ (E4+E5)->Sara
	+ (E6+E7+E8+E9)->John
	+ (E10+E11+E12+E13)->Mary

//	#classes < 6
//	#takers > 6
//	#enrolls < 6
//	#stu < 6
}


pred show {}
//fun show : z {}
//run show for 13 Enroll, 10 Class, 4 Student
run show
