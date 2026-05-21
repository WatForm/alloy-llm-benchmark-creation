>  The model is in the module "chapter5/sets1".  -  removed

There are two kinds of entities: "Set" and "Element".

Each "Set" is related by "elements" to zero or more "Element" entities.

The following constraint holds and is named "NotClosed":

There exist some "Set" entities s0 and s1 such that, for every "Set" entity s2, the "elements" related to s2 are not exactly the union of the "elements" related to s0 and the "elements" related to s1.