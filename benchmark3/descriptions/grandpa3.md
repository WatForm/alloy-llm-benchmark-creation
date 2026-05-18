The model is in the module "language/grandpa3".

There is a set "Person". "Person" is divided into the disjoint subsets "Man" and "Woman", and every "Person" belongs to one of those two subsets.

Every "Person" has:
- "father", which relates that person to at most one "Man"
- "mother", which relates that person to at most one "Woman"

Every "Man" has:
- "wife", which relates that man to at most one "Woman"

Every "Woman" has:
- "husband", which relates that woman to at most one "Man"

The following constraints hold.

"Biology":
- No "Person" is an ancestor of themself through one or more repetitions of "mother" and "father".
- This means there is no person such that, by repeatedly following "mother" and "father" links in any combination for one or more steps, that same person can be reached again.

"Terminology":
- "wife" and "husband" are exact converses of each other.
- A "Man" is related by "wife" to a "Woman" exactly when that "Woman" is related by "husband" to that "Man".

"SocialConvention":
- No pair connected by "wife" or "husband" is also connected by one or more repetitions of "mother" and "father".
- This means no spouse of any person is any ancestor or descendant of that person through parent links.