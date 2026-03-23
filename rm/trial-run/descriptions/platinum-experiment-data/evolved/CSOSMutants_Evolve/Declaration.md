This model defines a system with EndPoints, HTTPEvents, Requests, Responses and Redirects, along with a Server and a Client.

Clients and Servers are types of EndPoints. A Server contains a set known as 'causes' consisting of HTTPEvents. An HTTPEvent is associated to three EndPoints referred to as 'from', 'to' and 'origin'.

The model further defines two types of HTTPEvents: Requests and Responses. A Request is associated with atmost one Response. A Response, on the other hand, may embed multiple Requests. It can also be a Redirect.

Each Request must originate from a Client and each Response must be sent back to a Client. Furthermore, Responses are sent from Servers and Requests are sent to Servers.

Every HTTPEvent 'e' belongs to a Server's 'causes' set if and only if 'e' is from that Server, or if 'e' is contained in a Response 'r' which is caused by that Server.

Two constraints apply to Requests and Responses. One, a Request cannot be found recursively within any Response that it itself embeds. Two, each Response must come from an exact one Request and the to-endpoint of the Response and the from-endpoint of its corresponding Request should be the same and vice-versa.

When it comes to the origin of an HTTPEvent, for a Redirect, the origin and the Request's origin should be the same. In all other cases, the origin should be the Server. The origin of all Requests embedded in a Response should be the same as the Response's origin. All Requests that are not embedded have their origin as the Client.

The predicate 'obeysOrigins' checks if all Requests accepted by a particular Server have their origin either at the Server itself or at the sender.

Finally, the model includes a command that runs a check to ensure that there are no good or bad Servers such that no Requests are accepted by the bad Server from the Client, the good Server obeys origins, and there exists a Request to the good Server that has been caused by the bad Server. The scope of this check is set to 5. The expected result is that no counterexample should be found.