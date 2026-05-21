There are five sets of entities: "Condition", "Sensor", "Qualification", "Expert", and "State".

Each "Sensor" has a relation named "raise_alarm_on" to a set of "Condition". A sensor may be related to any number of conditions, including none.

Each "Qualification" has a relation named "conditions" to some "Condition". Every qualification is related to at least one condition.

Two different elements of "Qualification" cannot have exactly the same set of related "Condition". For any two distinct qualifications, their "conditions" sets are different.

Each "Expert" has a relation named "qualifications" to some "Qualification". Every expert is related to at least one qualification.

Each "State" has:
- a relation named "called_experts" to a set of "Expert",
- a relation named "onsite_experts" to a set of "Expert",
- a relation named "current_alarms" to a set of "Condition".

The named condition "can_solve_all_alarms" holds for a set of experts and a set of conditions exactly when every condition in that set of conditions is included in the union of the "conditions" sets of all qualifications related to those experts. This means the given experts, through their qualifications, collectively cover all of those conditions.

The named condition "called_experts_check" holds for a state exactly when all of the following are true:

- The union of that state's "onsite_experts" and "called_experts" can solve all of that state's "current_alarms".
- No expert is both in that state's "called_experts" and in that state's "onsite_experts".
- No expert in that state's "called_experts" is unnecessary for solving that state's "current_alarms" together with the onsite experts and the other called experts. For every expert in "called_experts", if that expert is removed from "called_experts", then the remaining called experts together with the onsite experts can no longer solve all of the current alarms.

This constraint holds for every element of "State": every state satisfies "called_experts_check".

> no changes made