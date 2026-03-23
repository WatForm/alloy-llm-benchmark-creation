Sure, here is how an Alloy model satisfying the above description might be structured:

```alloy
abstract sig Person {
  mother : lone Woman,
  father : lone Man
}

sig Man extends Person {
  wife : lone Woman
}

sig Woman extends Person {
  husband : lone Man
}

fact {
  // A person cannot be their own ancestor either through mother or father.
  all p: Person | p not in p.^father + p.^mother
  
  // If a Man is married to a Woman, then the Woman is married to the Man.
  all m : Man, w : Woman | m.wife = w <=> w.husband = m
}

check NoSelfFather {
  no m : Man | m in m.father
}

check NoSelfGrandpa {
  no p : Person | p in p.^father.father + p.^mother.father
}

fun grandpas(p : Person) : set Man {
 return p.^father.father + p.^mother.father
}

pred ownGrandpa[p: Person] {
  some grandpas(p) & p
}

run ownGrandpa for 4 Person
check NoSelfGrandpa for 4 Person
```

This model defines a simplified family tree with each person having one or zero mother and father. Men can have a wife and women can have a husband. The model checks that no man can be his own father and no one can be their own grandfather. The model provides functions to get all grandfathers of a person and to check if a person is their own grandfather. The last part of the code runs checks and ownGrandpa predicate for four person objects.