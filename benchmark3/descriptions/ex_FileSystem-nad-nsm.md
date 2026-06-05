There is a set called "Object".

There is a set called "Directory" contained within "Object". Each element of "Directory" is related by "contents" to a set of elements of "Object".
>>> "set contained within"?

There is exactly one element called "Root", and it is the only member of "Directory".
>>> is this true?

There is a set called "File" contained within "Object".
>>> "set contained within"?

Every element of "Object" is either in "Directory" or in "File". No element can be in both "Directory" and "File".

No element of "Directory" is reachable from itself by following one or more steps of "contents".

Every element of "Object" is reachable from "Root" by following zero or more steps of "contents". 

Every element of "Object" other than "Root" is in the "contents" relation of exactly one element.