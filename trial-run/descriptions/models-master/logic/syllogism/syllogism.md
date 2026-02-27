The model includes different types of "EndPoint" entities which captures the more specific notions of "Server" and "Client". Each "Server" is connected to a set of "HTTPEvent", which is represented by the "causes" relation.

There are two types of "HTTPEvent", namely "Request" and "Response". Each "HTTPEvent" is associated with one "from" EndPoint, one "to" EndPoint and one "origin" EndPoint. Each request is mapped to zero or one response through the "response" relation and each response may relate with a set of requests through "embeds" relation.

There is also a type of "Response", namely "Redirect".

A set of constraints are applied in this model:
- Only "Client" could be the origin of "Request" or destination of "Response".
- Only "Server" could be the destination of "Request" or the origin of "Response".
- A "Server" "causes" an "HTTPEvent" only if the event is a response from the server, or the event is embedded in a response by the server.
- A "Request" event should not be embedded into ancestor requests' responses.
- Each "Response" event should come from one and only one request.
- For each "Response", its "to" EndPoint should be the "from" EndPoint of its corresponding request, and its "from" EndPoint should be the "to" EndPoint of its corresponding request.
- For a "Redirect" response event, its origin is the same as its corresponding request, otherwise it is from the server.
- The origin of a request that embedded in a "Response" is the same as the origin of that "Response".
- The origin of a "Request" that does not embed in any "Response" should be its "from" EndPoint.
- Only requests from the server or from the sender will be accepted, as per the "obeysOrigins" predicate for a server.
- The model checks non-existence of servers such that there is no request to a 'bad' server from the client and there is at least one request to a 'good' server that causes action on the 'bad' server, while the 'good' server obeys origin.

The model performs the above checks for up to five items i.e., scope limit is 5.
