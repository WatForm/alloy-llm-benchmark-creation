Following checks are required:
- Works with Ringert's method (Java 17 required)
    - Run the following command: `java -cp jars/alloy-diff.jar org.alloytools.alloy.diff.ModuleDiff 1.als 1.als Equivalence 1 false sat4j`. Check if the string `The two modules are equivalent.` is printed.
    - SemDiff seems to compute right\setminus left
    - it checks scope sizes <= n
    - Get model sets from primary source
    - get prompts for many of them
- Works with compoSAT (Java 8 required)
    - TODO: Determine how to run from command line
    - TODO: Fix: `/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/bin/java -Djava.io.tmpdir=/private/tmp/amalgam-coverage -jar validModels/jars/CompoSAT.jar batch --files sample-set/genealogy.als --command 0 --mode coverage --symmetry 2000 --out sample-set/instances/`
    - TODO: Remove the existing command, use run {} for x. Increment x=1,..., until some (reasonable) time limit - write script for this2

generating instances:
python scripts/master.py openAI trial-run/models trial-run/descriptions/


statistics for models in set (lines of code on input, lines of description)

(This is after removing blank lines and stripping comments)
Bucket 0-9 lines (20 files):
Bucket 10-19 lines (36 files):
Bucket 20-29 lines (42 files):
Bucket 30-39 lines (51 files):
Bucket 40-49 lines (24 files):
Bucket 50-59 lines (33 files):
Bucket 60-69 lines (5 files):

Investigate if ringerts method should be ran over multiple scopes (no monotonicity property)

- Clean up models (different versions) - get original sources for all of them
- Run ringerts method n->1 scope (in scoring script)
- Making scoring script a bit more modular (weighting for two parts of ringers, weighting for composat, weighting per row, average to get total score). If syntax error, gets 0, otherwise score from above.
- Clean up the directory structure of instances (duplicate model names) - or just make directory of models flat with naming.
- Different java versions - how to handle cleanly?
- general refactoring throughout
- nix?
- jenv? - how to handle the different java versions
- she has instructions at the top of her java file


export JAVA_HOME_17="/opt/homebrew/Cellar/openjdk@17/17.0.15/libexec/openjdk.jdk/Contents/Home"
export JAVA_HOME_8="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"

model sources:
https://github.com/wenxiwang/iAlloy-dataset
https://github.com/AlloyTools/models
https://sites.google.com/view/platinum-repository
