There is a set called "Object". The sets "Dir" and "File" are non-overlapping subsets of "Object" Every element of "Object" belongs to exactly one of its subsets.

For any element of "Dir", its "contents" may contain any number of elements of "Object", including none.

There is a distinguished singleton element "Root" contained in "Dir".

Every element of "Object" is reachable from the "Root" by following the "contents" relation zero or more times. This includes the element of "Root" itself.