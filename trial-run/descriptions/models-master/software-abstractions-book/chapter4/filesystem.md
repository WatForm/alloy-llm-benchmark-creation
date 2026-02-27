This Alloy model describes an origin tracking mechanism to counter Cross-Site Request Forgery (CSRF) in the context of HTTP events like requests and responses.

There are two types of EndPoint: Server and Client. Server has a relation 'causes' to the set of HTTPEvents.

HTTPEvent is an abstract entity, which represents some kind of activity over HTTP protocol. It includes fields 'from', 'to', and 'origin' all of which are EndPoint type entities. HTTPEvent has two concrete forms: Request and Response. 

Request is a concrete form of HTTPEvent that may have a corresponding Response. The 'response' field has at most one Response linked to a Request. 

Response is another form of HTTPEvent. A Response may embed multiple Requests, which is represented by the 'embeds' field. A specialized type of Response is called 'Redirect'.

There are specific constraints on these HTTPEvents:

1. The 'from' field of Request and 'to' field of Response should always point to a Client. Conversely, the 'to' field of Request and 'from' field of Response should always point to a Server. 

2. A Server 's' causes an HTTPEvent 'e', if and only if 'e' is a Response originating from 's', or the Event 'e' is a Request embedded in a Response 'r' where 'r' is caused by 's'.

3. A Request cannot be accompanied by itself or other Requests that are recursively linked via their responses' 'embeds' relation. 

4. Each Response 'r' must have exactly one corresponding Request, and must have the same 'to' and 'from' as the respective 'from' and 'to' of the corresponding Request.

5. For a Response, its 'origin' equals its original HTTPEvent's 'origin' if it is a Redirect type, otherwise the 'origin' of Response is its 'from' field. Also, the 'origin' of any Request embedded in a Response should be the origin of that Response. For a Request not embedded in a response, its 'origin' should be its 'from' field.

A Server obeys the Origin policy (represented by the predicate 'obeysOrigins'), if all Requests being sent to this Server have their origin either as the Server itself or as the sender Client. 

The model then checks a scenario where no 'good' and 'bad' Server exists displaying certain behavior. 'Bad' Server does not accept any Requests that originated from a Client. 'Good' Server obeys the origin policy and has some Requests wherein their destination is 'good' and have been caused by 'bad' Server. This scenario check runs within the scope of having up to five Server entities.