There is exactly one "Amendment".

"Amendment" has a relation called "modifications" whose values are "Modification" elements. An "Amendment" may be related through "modifications" to any number of "Modification" elements, including none by multiplicity alone, but in fact at least one "Modification" is related through "modifications".

There is a set of "Modification" elements. Each "Modification" has:
- a relation called "modified_entity" to at most one "ModifiedEntity"
- a relation called "application_date" to at most one "Date"

Every "Modification" is related through "Amendment"’s "modifications" relation to at least one "Amendment". Since there is exactly one "Amendment", every "Modification" belongs to that unique "Amendment" through "modifications".

There is a set of "ModifiedEntity" elements. Every "ModifiedEntity" is the value of "modified_entity" for at least one "Modification".

There is a set of "Date" elements. Every "Date" is the value of "application_date" for at least one "Modification".

There is a named condition "ModificationSpec" that applies to a "Modification". It requires that the "Modification" has exactly one "ModifiedEntity" through "modified_entity" and exactly one "Date" through "application_date".

The following global constraints hold:
- At least one element appears in "modifications" of the unique "Amendment".
- Every "Modification" that appears in "Amendment"’s "modifications" satisfies "ModificationSpec".

As a result, every "Modification" has exactly one "ModifiedEntity" and exactly one "Date", every "ModifiedEntity" is used by at least one "Modification", every "Date" is used by at least one "Modification", and there is at least one "Modification".