This Alloy model describes a system that communicates through HTTPEvents, with EndPoints transmitting data through HTTPEvents. The system highlights a method for tracking origins to counter Cross-Site Request Forgery (CSRF).

There are two types of EndPoint: the Client and the Server. The Server has a set of HTTPEvents that it triggers, referred to as 'causes'. The Client has no specified attributes.

HTTPEvents are messages sent from one EndPoint to another in this system. An HTTPEvent includes an 'origin' EndPoint from which it was originally sent, a 'from' EndPoint which sends the event, and a 'to' EndPoint which receives the event. HTTPEvents can be further classified as either Requests or Responses.

A Request is an HTTPEvent that ultimately leads to a Response. A Request may lead to zero or one Responses, indicated as 'response'.

A Response is an HTTPEvent that echoes a Request. A Response may include zero or more embedded Requests, shown in the 'embeds' set. If a Response is of type Redirect, it changes the specifications of the Response.

The Directions fact specifies that a Request goes from a Client to a Server, and a Response returns from the Server to the Client. The Causality fact states that a Server causes an HTTPEvent under two possible conditions: either the HTTPEvent is a response originating from the Server itself, or the HTTPEvent is a request embedded in a Response that the Server has caused.

The RequestResponse fact has three main specifications: firstly, there are no Requests in a sequence of Responses derived from that Request. Secondly, each Response relates to a single Request only. Thirdly, the 'to' and 'from' EndPoints of a Response are respectively the 'from' and 'to' EndPoints of the corresponding Request.

The Origin fact specifies how to determine the 'origin' of an HTTPEvent. For any Response, the 'origin' is its 'from' EndPoint unless the Response is a Redirect, in which case the 'origin' is the same as the initial Request's 'origin'. Also, any Request embedded in a Response has an 'origin' same as that Response. Further, a Request that isn't embedded in a Response has an 'origin' in its 'from' EndPoint.

The model further includes a predicate, obeysOrigins, for a Server. This predicate requires that a Server accepts a Request only if the 'origin' of that Request is either the Server itself or the Client who made the Request.

Lastly, the model includes a check command which specifies that for all Servers, no Server that obeys the origins should act upon a Request that is caused by another Server and intended for a Client. The maximum scope for this command is limited to 5.