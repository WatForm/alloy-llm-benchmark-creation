Here is an Alloy model that describes the system:

```alloy
sig Set {
    elements: set Element
}

sig Element {}

fact combinationExist {
    all s1: Set, s2: Set | 
        some s3: Set | s3.elements = s1.elements + s2.elements
}

assert Closed {
    combinationExist
}

check Closed
```

In the model, `Set` is a signature representing the sets in the system and it has a field `elements` which is a set of `Element` objects (represented by the `Element` signature). 

The fact `combinationExist` specifies the system's constraint: for every two sets (`s1` and `s2`), there is another set (`s3`) whose elements are exactly the combination (union, depicted by `+`) of the elements of `s1` and `s2`. 

The `Closed` assertion checks this property for all possible combinations of sets in the system. The `check Closed` command launches the verification of this assertion. If it fails (meaning there are two sets without a corresponding set containing all their elements), a counterexample will be generated.