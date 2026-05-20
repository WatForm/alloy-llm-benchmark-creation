There are sets named "Field", "Game", and "Date".

Each element of "Game" has exactly one "where" value, and that value is an element of "Field". Each element of "Game" also has exactly one "when" value, and that value is an element of "Date".

There is exactly one element named "FieldComplex". "FieldComplex" has a relation named "schedule" that matches "FieldComplex"es with "Games", and any number of games may be in the relation with the same "FieldComplex".

At least one element of "Game" is not in "FieldComplex"."schedule". For any element of "Game" that is not in "FieldComplex"."schedule", it has no "where" value and no "when" value.

At least one element of "Game" is in "FieldComplex"."schedule". For any element of "Game" that is in "FieldComplex"."schedule", it has exactly one "where" value and exactly one "when" value.

For any two distinct elements of "Game", if they have the same "where" value, then they have different "when" values.

The named condition "ScheduledGame" holds exactly when there exists at least one element of "Game" that is in "FieldComplex"."schedule", and every such game considered by that condition has exactly one "when" value and exactly one "where" value.

The named condition "UnscheduledGame" holds exactly when there exists at least one element of "Game" that is not in "FieldComplex"."schedule".

Both "ScheduledGame" and "UnscheduledGame" are required to hold.