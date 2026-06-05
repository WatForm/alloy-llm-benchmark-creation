There are two sets of elements, named "E" and "C".

Each element of "C" is related by "genls" to zero or more elements of "C", meaning the set of "C"s is generalized to be the element of "C".
>>> not sure what the last part here means
>> agreed

The inverse of "genls" forms a tree, meaning it is a directed acyclic graph with one root.

Each element of "E" is related by "isas" to one or more elements of "C", meaning the element of "E" is a "C".

Each element of "E" is also related by "all_isas_attr" to zero or more elements of "C".

The set of "C"s that related to an individual "E" using "all_isas_attr" is equal to the set of "C"s resulting from the "C"s that can be reached in zero or more steps of "genls" starting from the "C"s that are connected to the "E" via "isas".
Because zero "genls" steps are allowed, this includes the "C"s directly related "isas" elements themselves.

For every element of "E", there is no element of its "isas" set that is reachable by zero or more "genls" steps from another distinct element of its "isas" set. This means that if an element is directly related by "isas" to two different elements of "C", then neither of those two elements can be a strict "genls" descendant of the other.

>> I think the use of "this means that <rephrased> need not be present
