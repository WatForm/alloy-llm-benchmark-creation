module studyabroad
-- Students who speak foreign languages can visit foreign hosts in their hometowns

abstract sig City {}
one sig Bangalore, Chennai, Hamburg, Marseille, Milan, StPetersburg, Toulouse extends City {}

abstract sig Host {
	hometown: one City	-- each host has a unique hometown
}
one sig Danielle, Dieter, Konstantin, Marco, Mahesh, Priyanka, Sebastien, Shreya extends Host {}

abstract sig Language {
	host: set Host	-- there are hosts assigned to languages -- zero or more, a set
}
one sig French, German, Hindi, Italian, Russian, Tagalog extends Language {}

abstract sig Student {
	speaks: some Language,
	-- each student speaks at least one foreign language
	friend: some Student
}



one sig Abigail, Alexander, Adele, Arthur, Amy, Aloysius extends Student {}

fact {-- must be true ib worlds
	hometown = Dieter->Hamburg
	+ Danielle->Marseille
	+ (Mahesh+Shreya)->Bangalore // 2 pairs into
	+ Konstantin->StPetersburg
	+ Marco->Milan
	+ Priyanka->Chennai
	+ Sebastien->Toulouse

	host = French->(Danielle+Sebastien) // both pairs have french
	+ German->Dieter
	+ Hindi->(Mahesh+Shreya+Priyanka)
	+ Italian->Marco
	+ Russian->Konstantin

	speaks = Abigail->(French+German)
	+ Alexander->German
	+ Adele->(German+Russian)
	+ Arthur->Tagalog
	+ Amy->Hindi
	+ Aloysius->(French+Russian)

	friend = ~friend
	no friend & iden -- iden, relationship for every element to itself4
	-- nobody is friends with themselves ;D
	-- IRREFLEXIVE, no pairs of self
	#friend < 3
	-- 
}

-- the cities that each student can visit, given his/her languages and given host availability
fun canvisit: Student->City {speaks.host.hometown} // FUNction
// Use of join ops


pred show {}

run show for 7 City, 8 Host, 6 Language, 6 Student
// JOIN OPERATOR   .     GIVES BACK AGREEING SIMILAR FACTORS    
// SPEAKS.HOST
// see:
// ALLOYISISH - DANIELLE
//==============================
//Student.Citty
//  Adel.speaks
// Aloysius.speaks.host //  to find posible ho\sts
//==============================
// CARDINALITY CHAR #
// #Hosts
//===============================
// canvisit.Marseille
// ===============================
// UNION +
// Intersection &
// ==============================
///All cities can visit
// Student.canvisit
//
// City - Student.canvisit // set difference
//
// RELATION: SET OF ORDERED PAIRS
// friends.friends // FRIENDS of friends
///
// friend.friend-friend-iden // friends of friends, minus reflexive pairs
// TRANSITIVE CLOSOUR
// ^friend //  some chain of friends to friend
//
//





