The model is in the module named alloy4fun.
>>> do we want this?

There are four kinds of elements: StoredModel, Link, Command, and Instance.
>>> disjoint?

Secret is a subset of StoredModel.

Each StoredModel has:
- at most one derivationOf value, which is a StoredModel
- at most one public value, which is a Link
- at most one secret value, which is a Link
- at most one command value, which is a Command

Each Instance has:
- exactly one instanceOf value, which is a Command
- a set of model values, each of which is a StoredModel
- exactly one link value, which is a Link

The following constraints hold.

Links:
- Every Link belongs to exactly one of the following relationships taken together: as the public value of some StoredModel, as the secret value of some StoredModel, or as the link value of some Instance.
- Every Link that appears as a secret value of some StoredModel belongs to a StoredModel in Secret.
- For every StoredModel in Secret, if it has some secret value then it also has some public value.
- For every StoredModel in Secret, if it has some public value then some StoredModel that is either that same StoredModel or reachable from it by following derivationOf one or more times has some secret value equal to that public value.
>>> should this just be the existence of a secret value isntead of "equal to"?

Derivations:
- No StoredModel is reachable from itself by following derivationOf one or more times.
- For every StoredModel, if it has no public value then at most one StoredModel has derivationOf equal to it.
- For every StoredModel in Secret, every StoredModel that can reach it by following derivationOf one or more times is also in Secret.
- For every StoredModel in Secret, if it has some public value and no secret value, then no StoredModel that can reach it by following derivationOf zero or more times has any secret value.

Commands:
- Every Command is the command value of exactly one StoredModel.
- For every StoredModel, having no public value is exactly the same as having some command value.

Instances:
- For every Instance, its model set is exactly the set of StoredModel elements whose command value is that Instance’s instanceOf value.
- For every Command, at most one Instance has instanceOf equal to that Command.