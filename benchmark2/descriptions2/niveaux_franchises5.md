The model imports the util/ternary module.

There are five kinds of elements: "DeductibleLevel", "Product", "Coverage", "RiskType", and "DeductibleValue".

Each "DeductibleLevel" has exactly one "product", which is a "Product".

Each "DeductibleLevel" also has a relation called "coverages" from "Coverage" and "RiskType" to "DeductibleValue". For any given "DeductibleLevel", this relation associates some pairs of a "Coverage" and a "RiskType" with "DeductibleValue" elements.

Each "Product" has a set called "base_coverages" containing "Coverage" elements, a set called "optional_coverages" containing "Coverage" elements, and a set called "risk_types" containing "RiskType" elements.

There is a derived relation called "coverages" from "Product" to "Coverage". For each "Product", its "coverages" are exactly the union of its "base_coverages" and its "optional_coverages".

Each "Coverage" has a set called "risk_types" containing "RiskType" elements.

The condition named "is_valid" for a "DeductibleLevel" means all of the following:

- The set of "Coverage" values that appear in that "DeductibleLevel"'s "coverages" relation is exactly the set of "Coverage" elements that are both in that "DeductibleLevel"'s associated "Product"'s derived "coverages" and paired with some "RiskType" in that "Product"'s "risk_types". This means a "Coverage" appears in the "DeductibleLevel"'s "coverages" relation exactly when that "Coverage" belongs to the associated "Product"'s "coverages" and that "Coverage" is related by its own "risk_types" field to at least one "RiskType" contained in the associated "Product"'s "risk_types".
- For every "Coverage" in that "DeductibleLevel"'s associated "Product"'s "base_coverages", and for every "RiskType", there is exactly one "DeductibleValue" associated by that "DeductibleLevel"'s "coverages" relation with that "Coverage" and that "RiskType".

The global condition named "AllDeductibleLevelsAreValid" states that every "DeductibleLevel" satisfies "is_valid".