There is at least one "Picture".

There is at least one "Client". Each "Client" has:
- a set "loaned" of "Picture"
- a set "desires" of "Picture"

There is exactly one "Museum". "Museum" has:
- a set "permanent" of "Picture"
- a set "onDisplay" of "Picture"

The following conditions hold:

- Every "Picture" is either in "Museum"."onDisplay" or in the "loaned" set of at least one "Client".
- For every "Picture" and for "Museum", if the picture is in "Museum"."permanent", then it is in "Museum"."onDisplay".
- No "Picture" is both in "Museum"."onDisplay" and in the "loaned" set of any "Client".
- For every "Client", that client's "desires" set is not equal to "Museum"."permanent".
- For every "Client", no picture is both in that client's "desires" set and in that client's "loaned" set.
- Every picture that appears in the "desires" set of any "Client" is in the "loaned" set of at least one "Client".
- For every two distinct "Client" elements, no picture is in both of their "loaned" sets.

> completed, no changes made