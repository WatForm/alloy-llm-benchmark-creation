## Changes


```
run
{
} for 0 but exactly 1 E, 5 C

```

## Comments

This model uses standard libraries from util.

```
fun all_isas[Es: set E] : set C
{
	Es.isas.*genls
}
```

despite not being invoked, is computed, which has an effect on the model