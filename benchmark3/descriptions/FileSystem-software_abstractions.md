There are four sets of objects named "Object", "Directory", "File", and "Alias", and one distinguished single element named "Root".

Every "Directory" is an "Object".
Every "File" is an "Object".
Every "Alias" is a "File".
Every "Root" is a "Directory".
"Object" is abstract, so every element of "Object" is in at least one of its extending sets.

There is exactly one "Root".

There is a relation named "contents" from "Directory" to "Object". Each "Directory" is related by "contents" to a set of "Object" elements.

There is a relation named "to" from "Alias" to "Object". Each "Alias" is related by "to" to exactly one "Object".

The following constraints hold.

For every "Directory" and every "Root", that "Root" is not in the "contents" of that "Directory".

For every "Root", the set of elements reachable from that "Root" by following "contents" one or more times is exactly all "Object" elements except "Root".

For every "Directory", that "Directory" is not reachable from itself by following "contents" one or more times.

The relation "contents" is lone on the "Directory" side and set-valued on the "Object" side. This means each "Object" is in the "contents" of at most one "Directory".

For every "Alias", that "Alias" is not reachable from itself by following "to" one or more times.