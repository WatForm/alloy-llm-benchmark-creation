Here's an alloy model that translates the given description :

```alloy
sig A {}
sig B {}
sig C {}

fact { one C } // Exactly one instance of C
```

Here, `sig A {}, B {}, C {}` declare three signatures A, B and C indicating 3 distinct entities. `fact { one C }` establishes the constraint that there must exist exactly one instance of the entity C in any model or instance conforming to this specification.