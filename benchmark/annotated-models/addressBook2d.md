## Question:

- how to handle run for quantified sigs?

```
fact { 
	all b | Book : show(b) 
	one Book
}
```


removed

```
pred show [b:Book]   { some Alias.(b.addr) }

// This command generates an instance similar to Fig 2.12
run show for 3 but 1 Book
```