The model imports the util/ternary module.

There are five kinds of objects: "DeductibleLevel", "Product", "Coverage", "RiskType", and "DeductibleValue".

Each "DeductibleLevel" has exactly one "product", which is a "Product".  
Each "DeductibleLevel" also has a "coverages" relation from "Coverage" and "RiskType" to "DeductibleValue". For any given "DeductibleLevel", this relation associates some pairs of a "Coverage" and a "RiskType" with "DeductibleValue" objects.

Each "Product" has a set of "base_coverages", a set of "optional_coverages", and a set of "risk_types".

There is a derived relation named "coverages" from "Product" to "Coverage". A "Coverage" belongs to the "coverages" of a "Product" exactly when it belongs to that product’s "base_coverages" or to that product’s "optional_coverages".

Each "Coverage" has a set of "risk_types".

There are no additional fields on "RiskType" or "DeductibleValue".

A "DeductibleLevel" is valid exactly when both of the following conditions hold.

First, the set of pairs of "Coverage" and "RiskType" that appear in that "DeductibleLevel"'s "coverages" relation is exactly the set obtained as follows: take the "Coverage" objects in that "DeductibleLevel"'s "product".coverages, and for each such "Coverage", pair it with the "RiskType" objects in that "Coverage"'s "risk_types". Equivalently, a pair of a "Coverage" and a "RiskType" appears in a "DeductibleLevel"'s "coverages" relation if and only if that "Coverage" is in the "coverages" of the associated "product" and that "RiskType" is in that "Coverage"'s "risk_types".

Second, for every "Coverage" in the associated "product".base_coverages and for every "RiskType", there is exactly one "DeductibleValue" related by that "DeductibleLevel"'s "coverages" relation to that "Coverage" and that "RiskType".

All "DeductibleLevel" objects are valid. Equivalently, every "DeductibleLevel" satisfies both conditions above.