## Changes


```
pred mostlyRed (s: LightState, j: Junction) {
	lone j.lights - redLights [s]
	}


run {}
```

is removed, since the mostlyRed predicate is unused. 

```
fun redLights (s: LightState): set Light {s.color.Red}

```

is also removed, since it is now unused after removing the predicate.


## Opinion

```
sig Light {}
sig LightState {color: Light -> one Color}
sig Junction {lights: set Light}
```

Can be simplified down into

```
sig Light {color : one Color}
sig Junction {lights: set Light}

```

since `LightState` is superfluous. This is not done, since it substantially changes the signature hierarchy of the model, and `LightState` may serve a purpose beyond the model itself, possibly as a lesson on simplification.