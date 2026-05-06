There are two preds in this, removing the run will need them to be turned into facts

```
//Use the following run command to explore the state space of the static model:
run{
ScheduledGame
	UnscheduledGame
} for 5

```

becomes

```
fact {
	ScheduledGame
	UnscheduledGame
}
```

## Comments

```

one sig FieldComplex{
schedule: set Game
}

```

Is actually not necessary, the model works without this wrapper signature. Games can exist without being bound to a schedule?


