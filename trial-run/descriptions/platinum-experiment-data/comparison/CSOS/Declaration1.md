This Alloy model describes an origin tracking mechanism to counter Cross-Site Request Forgery (CSRF).

The model has several types of entities:

1. EndPoints, which are either Servers or Clients. Servers have a set of HTTPEvents that they cause.

2. HTTPEvents, which are Request or Response. HTTPEvents have properties "from", "to", and "origin", all of which are EndPoints.

3. Requests, which are a type of HTTPEvent and have a property "response". This property can be related to no more than one Response.

4. Responses, which are a type of HTTPEvent and can be further classified as Redirect. Responses have a property "embeds" that relate to a set of Requests. These are the Requests that are embedded in the Response.

In this model, there are several key constraints:

1. The "from" property of a Request and the "to" property of a Response must always be a Client. 

2. The "to" property of a Request and the "from" property of a Response must always be a Server.

3. A Server "causes" an HTTPEvent if the event is a Response from the Server, or if the event is a Request embedded in a Response and the Server causes the Response.

4. A Request cannot be in the set of Requests embedded in successive Responses.

5. Every Response comes from a single Request. Additionally, the "to" property of a Response equals the "from" property of its corresponding Request and vice versa.

6. For a Redirect, its "origin" property equals the "origin" property of the request it come from, otherwise the "origin" equals the "from" property. 

7. The "origin" property of Requests embedded in a Response is the same as the "origin" property of the Response.

8. If a Request is not embedded in a Response, its "origin" property must match its "from" property.

Finally, the model checks a predicate "obeysOrigins" for a Server. According to this predicate, a Request is accepted only if its "origin" is the same as the "to" property or the "from" property of the Request. The model's check command verifies that no Server exists such that it does not accept any Request having the Client as its origin, abides by the "obeysOrigins" predicate, and causes a Request that is accepted by a Server obeying the "obeysOrigins" predicate. The check is performed within a scope of 5.