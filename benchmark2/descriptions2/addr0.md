There are three disjoint sets of atoms related by inclusion:

- `Listing` is an abstract set.
- `Address` is a subset of `Listing`.
- `Name` is a subset of `Listing`.

Because `Listing` is abstract, every `Listing` atom is in `Address` or in `Name`. Since `Address` and `Name` both extend `Listing`, they are disjoint from each other.

There is also a set `Book`. Each `Book` has two relations:

- `entry`, which relates that `Book` to a set of `Name` atoms.
- `listed`, which relates that `Book` to pairs from `entry` to `Listing`. For any given `Book` `b`, the relation `b.listed` only uses first elements drawn from `b.entry`, and its second elements are in `Listing`.

There is a derived operation `lookup[b, n]` for a `Book` `b` and a `Name` `n`. Its value is the set of all `Listing` atoms reachable from `n` by following one or more steps of the relation `b.listed`.

The following constraints hold:

- For every `Book` `b` and every `Name` `n` in `b.entry`, there is at most one `Listing` atom related to `n` by `b.listed`.
- For every `Book` `b`, every `Name` `n`, and every `Name` `l`, if `l` is in `lookup[b, n]`, then `l` is in `b.entry`.
- For every `Book` `b` and every `Name` `n` in `b.entry`, `n` is not in `lookup[b, n]`.

There are no additional named checks or executions, and no modules are imported.