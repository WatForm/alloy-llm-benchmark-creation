

`run {GoodSpec} for 4 but 8 Link` needs to be turned into a generic run, with GoodSpec turned into a fact


`BadSpec` is used in checks and asserts, which also need transformation

```
assert NoCommands {
	// There are no commands
	BadSpec implies no command
}

check NoCommands for 20
check NoCommands for 20

assert PublicAndSecretLinksDisjoint {
	// The set of public and secret links is disjoint
	GoodSpec implies no StoredModel.public & StoredModel.secret
}

check PublicAndSecretLinksDisjoint for 20
check PublicAndSecretLinksDisjoint for 20

assert OneDerivation{
	// models without a public link can have at most one Dervation
	all m:StoredModel | no m.public implies lone derivationOf.m
}

check OneDerivation for 20
check OneDerivation for 30

```

removed totally