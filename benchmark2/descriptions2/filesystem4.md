The model is in the module named chapter4/filesystem.

There is a set named Object.

There is a set named Dir and a set named File. Every Dir is an Object. Every File is an Object. Dir and File are disjoint. Every Object is either a Dir or a File.

Each Dir has a relation named contents to a set of Object. A Dir may be related by contents to any number of Object, including none.

There is exactly one element named Root. Root is a Dir.

Every Object is in Root or is reachable from Root by following contents zero or more times. Equivalently, every Object belongs to the reflexive transitive closure of Root through contents.