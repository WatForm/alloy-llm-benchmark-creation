This is the corresponding Alloy model:

```alloy
abstract sig Color {}

one sig Red, Yellow, Green extends Color {}

fun colorSequence[c: Color] : Color {
  c. Green => Yellow
  + c. Yellow => Red
  + c. Red => Green
}

sig Light {}

sig LightState {
  color: Light -> one Color
}

sig Junction {
  lights: set Light
}

fun redLights[s: LightState] : set Light {
  {l: Light | s.color[l] = Red}
}

pred mostlyRed[s: LightState, j: Junction] {
  #redLights[s] >= #j.lights - 1
}

pred trans[s,s': LightState, j: Junction] {

  all l: j.lights | 
    let color = s.color[l], color' = s'.color[l] |
      (color = color' or 
       color' = colorSequence[color] and 
       color != Red or 
       all l': j.lights - l |
         s.color[l'] = Red)
}

assert Safe {
  all s, s': LightState, j: Junction |
    mostlyRed[s,j] and trans[s,s',j] implies mostlyRed[s',j]
}

check Safe for 3 Light, 1 Junction
```

Please note that the `colorSequence` function here has a deterministic behavior as required by the problem description.