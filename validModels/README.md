Following checks are required:
- Works with Ringert's method (Java 17 required)
    - Run the following command: `java -cp jars/alloy-diff.jar org.alloytools.alloy.diff.ModuleDiff 1.als 1.als Equivalence 1 false sat4j`. Check if the string `The two modules are equivalent.` is printed.
- Works with compoSAT (Java 8 required)
    - TODO: Determine how to run from command line