There are four disjoint groups of entities: "Fruit", "Color", "Quality", and "Size".

"Fruit" consists exactly of "apple" and "orange".  
"Color" consists exactly of "RED" and "ORANGE".  
"Quality" consists exactly of "Ripe", "Juicy", "Moldy", "Brown", and "Organic".  
"Size" consists exactly of "Large", "Medium", and "Small".

There is exactly one "FruitBowl". "FruitBowl" has a relation named "contains" from "FruitBowl" to zero or more elements of "Fruit".

There is exactly one "apple". "apple" is a "Fruit".  
"apple" has exactly one "color", and that "color" is "RED".  
"apple" has exactly one "quality", chosen from "Quality".  
"apple" has exactly one "size", chosen from "Size".

There is exactly one "orange". "orange" is a "Fruit".  
"orange" has exactly one "color", and that "color" is "ORANGE".  
"orange" has exactly one "quality", chosen from "Quality".  
"orange" has exactly one "size", chosen from "Size".

The "contains" relation of "FruitBowl" contains exactly "apple" and "orange". That means "FruitBowl" is related by "contains" to "apple" and to "orange", and to no other "Fruit".