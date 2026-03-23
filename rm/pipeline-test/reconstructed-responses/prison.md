Here is a simple Alloy model that reflects on your specifications:

```Alloy
sig Gang {
  members: set Inmate
}

sig Inmate {
  cell: one Cell
}

sig Cell {}

pred safe {} // safety predicates

pred show {} // show predicates

run show // execute the show predicate
```

The "safe" and "show" predicates are left empty, as you didn't specify what conditions or constraints should be checked within these predicates.

Each "Gang" contains a set of "Inmate", which means they can contain more than one inmate. 
Each "Inmate" is associated with exactly one "Cell", as specified by your description. And the "Cell" has no additional features.