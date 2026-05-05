## Changes


- removed comments
- changed a check into a fact: `

```
assert lookupEndsInAddr {
	all b:Book | all n:b.entry | some (lookup[b,n]&Address)
}
check lookupEndsInAddr for 4

```

->

`fact lookupEndsInAddr`

However, this is a check that's expected to pass, so the whole thing is removed