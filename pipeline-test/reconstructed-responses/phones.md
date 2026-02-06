Here is an Alloy model that follows the description given:

```alloy
sig Phone {
    requests: set Phone,
    connects: lone Phone
}

//Optional, depending on model goals:
fact {
    //A phone cannot connect to itself
    all p: Phone | p not in p.connects
    //A phone cannot request itself
    all p: Phone | p not in p.requests
}
```

The `set` keyword specifies that "requests" can be a set of multiple Phone instances, while `lone` specifies that "connects" can be at most one Phone instance. 

The optional fact section ensures that no Phone instance can request or be connected to itself. This may or may not be necessary based on the specific model requirements.