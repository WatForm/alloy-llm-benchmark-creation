/*
	Tabbacco Types
	Brett Kriz

*/


abstract sig Texture {}
one sig caked, flaky, granular, fluffy extends Texture {}

abstract sig Color{}
one sig dark, pale, brown, gray extends Color {}

abstract sig Particles {}
one sig True, False extends Particles {}

abstract sig Nicotine{}
one sig ONE, TWO, THREE extends Nicotine{}


abstract sig Tabbacco {}

one sig Espanada extends Tabbacco{
	texture: one caked,
	color: one dark,
	particles: one False,
	nicotine: one TWO
}

one sig Heritage extends Tabbacco{
	texture: one flaky,
	color: one pale,
	particles: one False,
	nicotine: one TWO
}

one sig Roman extends Tabbacco{
	texture: some Texture,
	color: one dark,
	particles: one True,
	nicotine: one ONE
}

one sig Londoner extends Tabbacco{
	texture: one caked,
	color: one brown,
	particles: one False,
	nicotine: one TWO
}

one sig Lunkah extends Tabbacco{
	texture: one granular,
	color: one dark,
	particles: one False,
	nicotine: one TWO
}

one sig MacDuffy extends Tabbacco{
	texture: one flaky,
	color: one gray,
	particles: one False,
	nicotine: one TWO
}

one sig OldWood extends Tabbacco{
	texture: some Texture,
	color: one brown,
	particles: some Particles,
	nicotine: one THREE
}

one sig TopHat extends Tabbacco{
	texture: one caked,
	color: one gray,
	particles: one False,
	nicotine: one TWO
}

one sig Trichinopoly extends Tabbacco{
	texture: one flaky,
	color: one dark,
	particles: one False,
	nicotine: one TWO
}

one sig WestCountry extends Tabbacco{
	texture: one fluffy,
	color: one pale,
	particles: one False,
	nicotine: one TWO
}



// SAMPLES

one sig Sample1 extends Tabbacco{
	texture: one flaky,
	color: one gray,
	particles: one False,
	nicotine: one TWO
}

one sig Sample2 extends Tabbacco{
	texture: one fluffy,
	color: one pale,
	particles: one False,
	nicotine: one TWO
}

one sig Sample3 extends Tabbacco{
	texture: one caked,
	color: one dark,
	particles: one True,
	nicotine: one ONE
}



fact{
	
	


}


pred Show{}
run Show








