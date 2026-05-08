The model is in the module "chapter4/filesystem".

There is a set "Object".

There is a set "Dir" contained in "Object". Every element of "Dir" has a relation "contents" to a set of elements of "Object".

There is a set "File" contained in "Object".

"Object" is completely partitioned by "Dir" and "File": every element of "Object" is in "Dir" or in "File", and no element is in both.

There is exactly one element "Root", and "Root" is in "Dir".

Every element of "Object" is reachable from "Root" by following "contents" zero or more times. This includes "Root" itself. So every element of "Object" is either "Root" or is in the "contents" of "Root", or is in the "contents" of something in the "contents" of "Root", and so on for any finite number of steps.