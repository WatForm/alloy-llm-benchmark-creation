Below is an Alloy model that captures the specifications from the description:

```alloy
sig Element {}

abstract sig List {
  append: lone Element,
  rest: lone List
}

sig NonEmptyList extends List {
  element: one Element
}

sig EmptyList extends List {}

fact ListGenerator {
  all l:List, e:Element {
    some nl:List | nl.append = e and nl.rest = l
  }
}

assert FalseAssertion {
  no l:List | l = l 
}

check FalseAssertion for 5
```

Please note that the number `5` in `check FalseAssertion for 5` is just a scope. You can adjust it according to your needs. Additionally, depending on the intended use of this model, further constraining and assertions may be required.