This model is about end points and HTTP event interactions in a network. The end points consist of two types: Servers and Clients. Servers are unique in that they are associated with a set of HTTP events that they cause, and therefore, they have a "causes" relation to a set of HTTP events.

HTTP events occur between End Points, specified by "from", "to", and "origin" fields. HTTP events come in two types: Requests and Responses. Each Request is associated with zero or one Response, described by the "response" field. A Response, on the other hand, can be associated with multiple Requests, which are embedded in it, represented by the "embeds" field. This relationship suggests that a Request may initiate a Response, and a Response may contain multiple embedded Requests. A particular type of Response is a Redirect.

There are several important facts, or rules, that must hold true for all instances in this model:

Directions: 
- The "from" field of a Request and the "to" field of a Response should always be a Client.
- The "to" field of a Request and the "from" field of a Response should always be a Server.

Causality: A Server causes an HTTP Event if and only if:
- The HTTP Event "from" field references the Server, or,
- There is a Response such that it has the HTTP Event embedded and the Server caused the Response.

RequestResponse: 
- No Request should be in the transitive closure of a Response through the "embeds" relation.
- Each Response comes from a single Request, and the "to" and "from" fields of a Response and its corresponding Request are complementary, that is, the client of the Request becomes the server in the Response and vice versa.

Origin: 
- For a Redirect, the "origin" field is the same as the corresponding Request's "origin" field. Otherwise, the "origin" field is the same as the "from" field.
- All embedded requests within a Response have the same "origin" as the Response.
- Requests that are not embedded have their "origin" field the same as their "from" field.

The predicate obeysOrigins is defined for a Server, which checks that any Request to this Server is only accepted if its "origin" field is either itself or the sender.

The model checks within a scope of 5, if there are any good and bad servers such that,
-No request to the bad server has an origin in the client and,
- The good server obeys origins and,
- There is a request to the good server that is caused by the bad server.