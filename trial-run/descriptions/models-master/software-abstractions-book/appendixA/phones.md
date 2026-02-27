This Alloy model describes a software system built to counter Cross Site Request Forgery (CSRF) attacks, which exploit the trust a website has in a user's browser.

The model contains four signatures, named 'EndPoint', 'Server', 'Client' and 'HTTPEvent'. 'EndPoint' is abstract, which implies that no instances of this signature can be created unless they're part of a non-abstract subsignature. 'Server' and 'Client' are non-abstract subsignatures that extend 'EndPoint'. 'HTTPEvent' is abstract with two non-abstract subsignatures, namely 'Request' and 'Response'. 'Redirect' is a subsignature of 'Response'.

The 'Server' has a relation with 'HTTPEvent' named 'causes', which is a set of HTTP events that a server can cause. The HTTP event is associated with three 'EndPoint' signatures named 'from', 'to', and 'origin'. The 'Request' is related to 'Response' via a lone relation named 'response'. The 'Response' has a set relation 'embeds' with 'Request'.

The model also describes the relationship amongst different events:

- The 'from' field of a request and the 'to' field of a response are always clients.
- The 'to' field of a request and the 'from' field of a response are always servers.
- An event is caused by a server if and only if the event originates from that server or if some response, which the server causes, embeds the event.
- A request can't be in the transitive closure of the 'embeds' relation of its 'response' field.
- Every response is linked to exactly one request and the 'from' and 'to' fields of a response are inverted in relation to its associated request.
- The origin of a request for a 'Redirect' type response is the same as the origin of the associated request, otherwise the origin is the server that sends the response.
- All requests that are embedded in a response have the same origin as the response.
- If a request is not embedded in a response, then the origin of the request is the client it came from.

The predicate 'obeysOrigins' is associated with the 'Server' and checks that a request will be accepted by a server only if its origin is either the server itself or the client from which the request originated.

The model also contains a check command, which checks that no good and bad server exists satisfying a certain condition, for a scope of 5. The condition is that there is no request sent to a bad server whose origin is a client, a good server obeys origins and there exists a request sent to a good server which is caused by a bad server. The result of the check command is false if there exists at least one counter-example that satisfies these conditions.