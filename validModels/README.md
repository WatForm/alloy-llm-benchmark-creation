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
https://github.com/practicalalloy/models
https://github.com/elkel53930/software_abstructions
https://github.com/cturle/alloy.git
https://github.com/Allisonius/AlloyModelsForEvaluations.git



Overall Funnel

Stage	Count	Removed at this stage
Initial models	1039	-
Passed validity script	258	781
Kept in benchmark/models	25	233
Key rates:

Validity pass rate: 24.8% (258/1039)
Manual keep rate after validity: 9.7% (25/258)
Final keep rate from original pool: 2.4% (25/1039)
By Source (5 Sources)

Source	Input	Passed validity	Kept final	Removed by validity	Removed manually after validity
expert-models	246	42	21	204	21
iAlloy-dataset	192	141	0	51	141
models	116	46	4	70	42
Platinum	293	0	0	293	0
practical-alloy	192	29	0	163	29
Validity Script Failures (exact, script-order first failure)
These are exactly where files are rejected in validModels/checkValidity.sh:

First failing check	Count	% of all inputs
Primed variable check	286	27.5%
Non-util open check	311	29.9%
Alloy-diff compatibility	94	9.0%
CompoSAT compatibility	90	8.7%
Pass all checks	258	24.8%
So among the 781 validity rejections, split is:

Primed: 286
Open: 311
Alloy-diff: 94
CompoSAT: 90
Only-Failed-This-Check Counts (what you asked for)
I ran targeted follow-up checks to determine exclusivity.

Check	Only this check failed	Potential gain if this one check were removed
Primed variable	49	+49 (258 -> 307)
Non-util open	0	+0 (258 -> 258)
Alloy-diff	52	+52 (258 -> 310)
CompoSAT	90	+90 (258 -> 348)





The current directory is for building an llm benchmark evaluating how well they can read and understand alloy. As part of this, we need a good sample of alloy files to run this on. At this point, you can look increation/validModels for some of the models we have already gotten (readme may provide some clarification).

One issue that we have is that most models are not compatable with our benchmark. In particular, you can look at the checkValidity script to see what we require.

On top of that, even the models which pass the script are usually not acceptable, this is usually because of a few reasons:
- Incomplete (i.e. leaves sections blank to be filled in later)
- Incorrect (e.g. may have intentional bugs to demonstrate something)
- Unsatisfiable (likely intentionally, we want ones that have instances though)
- Duplicate or close duplicate (sometimes a model appears in multiple sources, or theres many versions of the same file that are almost identical)

Of our initial set of ~1000 models in validModels, we are down to 13 that actually work (see benchmark/models - there's 16 here but 3 aren't satifiable).

We have scraped the web and have found ~110000 als files in catalyst corpus. This is way too many to run our validity script on (especially the compoSAT check, it can take quite a while), and even after that, the rest of our checks are by hand and currently take way to long.

I would like you to go through these models, and find a good set we can use. Here is what we are looking for, models that:
- Passes the checkValidity script
- Pass a manual inspection (as outlined above)
- Are distinct from the models we already have

The goal is to get at least 50 models.

We will also want to get these models from their original source, so your main goal is to look through here, find parts that seem to have a high concentration of good models, and recomend them to me. You obviously won't be able to run the checkValidity script on all of the models (since it's too slow), but if you remove the super slow checks, you might be able to run it on a pretty large number. For your recomendation of places to look, you should have ran the full checkValidity script on them, ensured that a decent number pass, and by manuall inspection, you expect a large number to make it through to the final batch.

For all the models you recomend, provide:
- Reference to the source (i.e. where in corpus-alloy are they, as well as sufficeint information to find the original source)
- Number of models in the source
- Number of models that pass the checkValidity Script
- Number of models that pass above, and are complete, correct, and satisfiable
- Number you expect to remain after removing any duplicates or near-duplicates.

Keep in mind there are a ton of models here, so you will need to be smart about how to approach this, you won't be able to manually analyze every single one.

I ran targeted triage plus full validity checks using checkValidity.sh, then manually reviewed pass profiles to estimate quality and dedup survival.

Recommended source pockets

Source in corpus	Original source	Total models	Passed full checkValidity	Passed + complete/correct/satisfiable (estimate)	Expected after dedup/near-dedup (estimate)	Notes
rjfdnowtm3fjcd5zumw5zuwxksi6wsqj-software_abstructions	https://github.com/elkel53930/software_abstructions (log.txt:1902)	27	21	18	14	Best concentration; mostly clean textbook-style models
dzz4b75smwsluutbtvh4vky2wxho3s7q-alloy	https://github.com/cturle/alloy (log.txt:1304)	44	9 to 10	7	6	One long CompoSAT tail; mostly domain models + some scratch/variants
pqoauozfewkvp5lkojtwqwm3avtxeebh-AlloyModelsForEvaluations	https://github.com/Allisonius/AlloyModelsForEvaluations (log.txt:1106)	269	32 to 33	20	12	All passes come from Benchmarks branch; requires filtering out buggy/test subsets
mmtidary2xx74gopx3uaniudmdk5qkfi-iAlloy-dataset	https://github.com/wenxiwang/iAlloy-dataset (log.txt:1894)	44	33	15	11	High pass rate, but many mutant/version variants; keep mostly real versions
gumxtrzzbkrtwi7jtwyu7eibi3fwhgmf-models	https://github.com/AlloyTools/models (log.txt:1740)	40	7	6	4	Strong quality, but overlaps current benchmark set
pzugbcasc5kpzv74sri7yypulw2l7n5d-MuAlloy	https://github.com/kaiyuanw/MuAlloy (log.txt:688)	20	4	3	2	Small but useful reserve
nhhvlij4ybonipvwonfsvopwhw4sdv5r-Alloy	https://github.com/BrettKriz/Alloy (log.txt:1236)	11	4	2	1	Low volume reserve
Projected totals from recommended pockets

Full script passes: 110 to 112
After complete/correct/sat manual filtering: about 71
After duplicate/near-duplicate removal: about 50
Why two counts are ranges

In two large runs, one CompoSAT file each became long-tail:
flow.als
AD_etendues_et_montants_garanties.als
Concentration findings inside AlloyModelsForEvaluations

Smaller Models: 0 of 9 pass
Larger Models: 0 of 101 pass
ASketch Benchmarks: 18 of 108 pass
So for this source, only Benchmarks is worth mining, and it must be manually filtered for faulty/test-oriented content.

Suggested next steps to lock 50+

Start extraction from the first four rows (rjfd, dzz4, pqo-benchmarks, mmtid).
In mmtid, prioritize real_version_set and drop mutant_version_set plus any path containing Faulty.
In pqo, drop paths containing faulty-models, realbugs, and most test-suite variants first.
Then add gumx and pzug as fill-in pools for final diversity.