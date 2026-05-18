The model imports the standard relation utilities and the standard graph utilities instantiated for "C".

There are two sets of elements, named "E" and "C".

Each element of "E" is related by "isas" to one or more elements of "C".

Each element of "E" is also related by "all_isas_attr" to zero or more elements of "C".

Each element of "C" is related by "genls" to zero or more elements of "C".

For any set of elements of "E", "all_isas" denotes the set of all elements of "C" that are reachable from one of those elements through "isas", followed by zero or more steps through "genls". Because zero "genls" steps are allowed, this includes the directly related "isas" elements themselves.

For every element of "E", the set given by "all_isas_attr" is exactly the result of applying "all_isas" to that single element.

For every element of "E", there is no element of its "isas" set that is reachable by one or more "genls" steps from another distinct element of its "isas" set. This means that if an element is directly related by "isas" to two different elements of "C", then neither of those two elements can be a strict "genls" descendant of the other.

The inverse of "genls" forms a tree, according to the imported graph utility on "C".