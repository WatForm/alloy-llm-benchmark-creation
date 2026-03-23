This model defines a simplified genealogical system of a family. It contains three abstract signatures: Person, Man, and Woman. A Person can include Man and Woman. 

Here are brief descriptions of each signature: 

 A. Person: This represents an individual within the family system. Each person can have one or at most one Man (the father) and Woman (the mother) in the family system. 

 B. Man: This signifies men in the family system and extends the person signature. Each man can have at most, one wife who is woman. 

 C. Woman: This represents women in the family system and extends the person signature. Each woman can have at most, one husband who is a man in the family system. 

There are two facts defined in the model as per the following: 

 A. A person cannot be their own ancestor, either through mother or father. 
 B. The relationship of a husband and wife is bidirectional (i.e. if a man is married to a woman, then the woman is married to that man). 

Two checks are implemented in the model namely NoSelfFather and NoSelfGrandpa. They should not find any counterexamples. Their descriptions are as mentioned below:

A. NoSelfFather: As per this, a man cannot be his own father.

B. NoSelfGrandpa: As per this, a person cannot be their own grandfather.

There are two functions defined in this model, grandpas and ownGrandpa. The functions are described as follows:

 A. grandpas: This function gives all the grandfathers of a person by considering both mother and father's side.
 B. ownGrandpa: If a person is their own grandfather, this predicate returns true, and the model should ensure this never holds.

This model runs the ownGrandpa predicate for four person objects and checks NoSelfGrandpa for instances with four person objects.