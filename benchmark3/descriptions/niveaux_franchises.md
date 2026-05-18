The model imports the util/ternary module.

There are five kinds of elements: "DeductibleLevel", "Product", "Coverage", "RiskType", and "DeductibleValue".

Each "DeductibleLevel" has exactly one "product", which is a "Product".  
Each "DeductibleLevel" also has a relation called "coverages" from "Coverage" and "RiskType" to "DeductibleValue". For any given "DeductibleLevel", this relation associates some pairs consisting of a "Coverage" and a "RiskType" with "DeductibleValue" elements.

Each "Product" has a set of "base_coverages", a set of "optional_coverages", and a set of "risk_types".

There is a derived relation called "coverages" from "Product" to "Coverage". For any "Product", its related "Coverage" elements are exactly the union of its "base_coverages" and its "optional_coverages".

Each "Coverage" has a set of "risk_types".

The condition named "is_valid" for a "DeductibleLevel" means all of the following:

- The set of pairs consisting of a "Coverage" and a "RiskType" that appear in that "DeductibleLevel"'s "coverages" relation is exactly the set of pairs where:
  - the "Coverage" belongs to the "coverages" of that "DeductibleLevel"'s "product", and
  - the "RiskType" belongs to the "risk_types" of that "Coverage".
- For every "Coverage" in the "base_coverages" of that "DeductibleLevel"'s "product", and for every "RiskType", there is exactly one "DeductibleValue" related by that "DeductibleLevel"'s "coverages" relation to that "Coverage" and that "RiskType".

The exact domain condition above means that a "DeductibleLevel" can assign "DeductibleValue" elements only to combinations of:
- a "Coverage" that is either a base or optional coverage of its "product", and
- a "RiskType" that is in the "risk_types" set of that "Coverage";

and it must assign a value to every such combination.

There is a global constraint named "AllDeductibleLevelsAreValid": every "DeductibleLevel" satisfies "is_valid".