This Alloy model is composed of several categories (signatures) and properties (fields) that define a mechanism to track the origin of HTTP requests and responses to combat Cross-Site Request Forgery (CSRF).

An HTTP event is abstractly defined to have an origin, as well as a from and to endpoint. HTTP events can be either requests or responses, which are further defined with additional properties. A "Request" can have a "Response", while a "Response" may embed multiple "Request". Redirects are a subset of "Response".

Endpoints in this model are abstractly defined and can be either "Client" or "Server". A "Server" can be the cause of a set of multiple "HTTPEvent".

The model sets up several constraints: 

- The "from" field of a "Request" and the "to" field of a "Response" are in the set of "Client" endpoints, while the "to" field of a "Request" and the "from" field of a "Response" are in the set of "Server" endpoints.
- A "Server" is defined as the cause of an "HTTPEvent" if the "HTTPEvent" is sourced from that "Server", or if the "HTTPEvent" is a "Request" embedded in a "Response" that the "Server" caused.
- The model asserts that a "Request" cannot be in a chain of embedded responses, and that every "Response" comes from a single request with matched "from" and "to" endpoints.
- The model states that the origin of a "Response" is the same as the "Request" for redirects, else it is the same as the "from" field of the "Response". Embedded requests have the same origin as their "Response". And if a "Request" isn't embedded, its origin is the "from" field.
- The "obeysOrigins" predicate specifies that a "Server" only accepts a "Request" if the request's origin is the server itself or the sender.

Finally, there is a command that checks for any two "Server" instances where the first doesn't accept requests from "Client" as its origin, obeys the origin rules, and has requests in the second server's list of caused events, for any scope of 5. This check assumes there's no such pair of "Server".