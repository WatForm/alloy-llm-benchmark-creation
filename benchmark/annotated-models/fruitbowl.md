## Changes:

- removed comment "Brett Kriz" for irrelevance
- removed `pred show` for being empty


## Description:

- red and orange are the colors
- the qualities are ripe, juicy, moldy, organic and brown
- the sizes are large, small and medium

These are modelled using abstract sigs for the property, and one concrete sig for each possible value

- Apples and Oranges are the two possible fruits, with fixed colors and variable qualities and sizes. The qualities are mutually exclusive (one fruit can have exactly one quality)

- There is one fruitbowl that contains a set of fruits

```
fact{
	contains = FruitBowl -> apple + FruitBowl -> orange
}

```

Since apple and orange are both one sig, and the fruitbowl is also one sig, this means that there is exactly one fruit bowl containing exactly one orange and exactly one apple. There are no restrictions on size and quality.

There is a placeholder predicate "show" which is empty.

## Opinion:

The model doesn't describe any standard algorithm or data structure, or even a description of the real world that matches human experience, since one expects that a fruit bowl is allowed to contain any number of fruits, and that the qualities listed are not mutually exclusive. If the LLM-generated summary does not capture the idiosyncrasies of the model, a reconstruction is likely to have `set qualities` and a different fact.