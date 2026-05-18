There is a set called Color. Every element of Color is exactly one of Red, Yellow, or Green. Red, Yellow, and Green are each single distinct elements of Color.

There is a set called Light.

There is a set called LightState. Each element of LightState has a relation called color from Light to Color such that, in that LightState, every Light is related to exactly one Color.

There is a set called Junction. Each element of Junction has a relation called lights to a set of Light.

There is a derived concept called redLights. For any LightState, redLights is the set of all Light elements whose color in that LightState is Red.

The following constraint always holds: for every LightState and every Junction, among the lights related to that Junction, at most one light is not in redLights for that LightState. This means that in every LightState, for every Junction, at most one of the Junction's lights has a color other than Red.