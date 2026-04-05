module TobaccoAshClassifier

/*
Given a Sample of tobacco ash whose properties of Texture, Color, 
Particles, and Nicotine have been specified, classify the Sample 
for Tobacco Type according to the following table.

TOBACCO TYPE	TEXTURE	COLOR	PRESENCE OF PARTICLES	NICOTINE COUNT
Espanada			caked		dark	false							2
Heritage			flaky		pale	false							2
Roman				caked,	dark	true							1 
					flaky, 
					granular, 
					or fluffy
Londoner			caked		brown	false							2
Lunkah			granular	gray	false							2
MacDuffy			flaky		gray	false							2
Old Wood			caked,	brown	true or false				3 
					flaky, 
					granular, 
					or fluffy
Top Hat			caked		gray	false							2
Trichinopoly	flaky		dark	false							2
West Country	fluffy	pale	false							2
*/

// Define the properties of tobacco ash.
abstract sig Texture {}
one sig Caked, Granular, Flaky, Fluffy extends Texture { }

abstract sig Color {}
one sig Dark, Pale, Brown, Gray extends Color {}

abstract sig Particles {}
one sig TRUE, FALSE extends Particles {}

abstract sig Nicotine {}
one sig One, Two, Three extends Nicotine {}

// Describe the properties of Ash
abstract sig Ash {
	texture: one Texture,
	color: one Color,
	particles: one Particles,
	nicotine: one Nicotine
}

// For convenience create a set of variable textures
sig VariableTextures in Texture { }
fact {
	Caked in VariableTextures
  	Flaky in VariableTextures
	Granular in VariableTextures
	Fluffy in VariableTextures
}

// For convenience create a set of variable particles
sig VariableParticles in Particles { }
fact {
	TRUE in VariableParticles
  	FALSE in VariableParticles
}

// Create a kind of Ash representing all Samples
abstract sig TobaccoAsh extends Ash { }
// Create the kinds of Tobacco that is the source of the ash.
sig Espanada, Heritage, Roman, Londoner, Lunkah, MacDuffy, OldWood, TopHat, Trichinopoly, WestCountry in TobaccoAsh { }

// Define a sample as being Tobacco Ash
abstract sig Sample extends TobaccoAsh { }

// Rules for Tobacco Types of Samples per the table above.
fact {
	all s:Sample | s.texture=Caked && s.color=Dark && s.particles=FALSE && s.nicotine=Two <=> s in Espanada

	all s:Sample | s.texture=Flaky && s.color=Pale && s.particles=FALSE && s.nicotine=Two <=> s in Heritage

	all s:Sample | s.texture in VariableTextures && s.color=Pale && s.particles=TRUE && s.nicotine=One <=> s in Roman

	all s:Sample | s.texture=Caked && s.color=Brown && s.particles=FALSE && s.nicotine=Two <=> s in Londoner

	all s:Sample | s.texture=Granular && s.color=Gray && s.particles=FALSE && s.nicotine=Two <=> s in Lunkah

	all s:Sample | s.texture=Flaky && s.color=Gray && s.particles=FALSE && s.nicotine=Two <=> s in MacDuffy

	all s:Sample | s.texture in VariableTextures && s.color=Brown && s.particles in VariableParticles && s.nicotine=Three <=> s in OldWood

	all s:Sample | s.texture=Caked && s.color=Gray && s.particles=FALSE && s.nicotine=Two <=> s in TopHat

	all s:Sample | s.texture=Flaky && s.color=Dark && s.particles=FALSE && s.nicotine=Two <=> s in Trichinopoly

	all s:Sample | s.texture=Fluffy && s.color=Pale && s.particles=FALSE && s.nicotine=Two <=> s in WestCountry
} 

// Describe the properties of some ash samples
one sig Sample1, Sample2, Sample3, Sample4 extends Sample { }
fact{
	texture = Sample1->Caked + Sample2->Flaky + Sample3->Fluffy + Sample4->Caked
	color = Sample1->Dark + Sample2->Gray + Sample3->Pale + Sample4->Pale
	particles = Sample1->FALSE + Sample2->FALSE + Sample3->FALSE + Sample4->TRUE
	nicotine = Sample1->Two + Sample2->Two + Sample3->Two + Sample4->One
}

pred show { }
run show 
