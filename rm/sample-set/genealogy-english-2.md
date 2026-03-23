This Alloy model describes a simplified genealogical system.

There is a type called Person. Each person has one spouse or none at all and may have multiple parents. The set of all persons is partitioned into two subsets - Man and Woman.

There are two specific individuals, a man named Adam and a woman named Eve. Each has exactly one instance in the model. Adam is categorised in the Man subset, while Eve is categorised in the Woman subset.

Several facts or constraints about these relationships exist:

- No person can be their own ancestor. In other words, a person cannot be part of the set of their ancestor's parents.
- Every person, apart from Adam and Eve, has exactly two parents - one mother and one father. Adam and Eve, however, have no parents.
- Adam's spouse is Eve.
- Nobody can be their own spouse. The spouse relationship is symmetric, meaning if person A is the spouse of person B, then person B is the spouse of person A.
- A man's spouse must be a woman, and vice versa.
- It is not allowed for a person to marry their sibling, meaning that a person and their spouse should not share any common parents.
- It is also forbidden for a person to marry one of their parents. 

There is a predicate named Show. It asserts that there is at least one person, apart from Adam and Eve, who has a spouse. 

Finally, there is a command that runs the Show predicate. The command attempts to find an instance of the model for six persons. It expects exactly one result.