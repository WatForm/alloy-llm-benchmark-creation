 

## Changes


```
pred show{}
run show
```

was removed. Empty named predicate, which is then invoked with run, but with no scopes


## Comments:

- This models thermodynamic processes related to the flow of heat across a temperature  gradient, until the temperatures become equal and the gradient vanishes. 

- Heat is modelled as a one sig for each object, and each process maps to the heat being decreased, and the heat being increased. 

- The universe being modelled assumes that total energy is constant, since each process that decreases some heat sig, necessarily increases another heat sig

- Unless the english description is very detailed, it seems unlikely that an LLM will choose to make a model with a similar sig hierarchy
