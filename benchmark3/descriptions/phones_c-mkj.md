>  The model is in the module "homework/phones". -- removed

There is a set of elements named "Phone".

Each "Phone" has these relations:
- "requests", which relates that phone to any number of "Phone" elements, including possibly none.
- "connects", which relates that phone to at most one "Phone".
- "forward", which relates that phone to at most one "Phone".

The following constraints hold.

Define "noForward" as the set of all "Phone" elements whose "forward" relation is empty.

Define "forwardedRequests" as follows: start with the "requests" relation, then follow the "forward" relation zero or more times, and keep only endpoints that are in "noForward". A pair belongs to "forwardedRequests" exactly when the second phone can be reached from a phone that was requested, by following zero or more "forward" links, and the final reached phone has no "forward".

Every pair in "connects" is also in "forwardedRequests". This means that whenever one "Phone" connects to another, that other phone must be either directly requested by the first phone or reachable from one of the first phone’s requested phones by following zero or more "forward" links, and the final connected phone must have no "forward".

For every "Phone" x, at most one "Phone" connects to x. No phone can be the target of "connects" from more than one phone.