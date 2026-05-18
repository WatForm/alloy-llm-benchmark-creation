The model is in the module "chapter4/filesystem".

There is a set "Object".

"Object" is abstract: every element of "Object" belongs to at least one of its extending sets.

There is a set "Dir" contained in "Object". Each element of "Dir" has a relation "contents" to a set of elements of "Object". For any element of "Dir", its "contents" may contain any number of elements of "Object", including none.

There is a set "File" contained in "Object".

There is a distinguished set "Root" contained in "Dir" that has exactly one element.

Every element of "Object" is reachable from the unique element of "Root" by following the "contents" relation zero or more times. This includes the element of "Root" itself.