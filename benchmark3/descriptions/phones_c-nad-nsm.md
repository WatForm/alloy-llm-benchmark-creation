There is a set of elements named "Phone".

Each "Phone" is related to a set of "Phone", called its "requests".
Each "Phone" "connects" to at most one "Phone".
Each "Phone" "forwards"s to at most one "Phone".

All "connects" pairs are in the set of pairs where the first "Phone" of the pair is the source of a "request" and when the second "Phone" can be reached from the "Phone" that was requested, by following zero or more "forward" links

>>> I don't understand why (*forward) is limited to noForward.  If a phone doesn't go anywhere in "forward", how can it go any farther in the transitive closure?

No phone can be the target of "connects" from more than one "Phone".
