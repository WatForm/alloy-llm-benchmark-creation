Following checks are required:
- Works with Ringert's method (Java 17 required)
    - Run the following command: `java -cp jars/alloy-diff.jar org.alloytools.alloy.diff.ModuleDiff 1.als 1.als Equivalence 1 false sat4j`. Check if the string `The two modules are equivalent.` is printed.
    - TODO: what command to check implication on ringert's method
    - Get model sets from primary source
    - get prompts for many of them
- Works with compoSAT (Java 8 required)
    - TODO: Determine how to run from command line
    - TODO: Fix: `/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/bin/java -Djava.io.tmpdir=/private/tmp/amalgam-coverage -jar validModels/jars/CompoSAT.jar batch --files sample-set/genealogy.als --command 0 --mode coverage --symmetry 2000 --out sample-set/instances/`
    - TODO: Remove the existing command, use run {} for x. Increment x=1,..., until some (reasonable) time limit - write script for this2