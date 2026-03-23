This Alloy model represents a system with Servers, Clients, and HTTP Events which include Requests and Responses. It also represents a specific type of Response known as a Redirect.

There are certain defined objects and the relationships between them are as follows:

- The EndPoint objects are either Servers or Clients.
- Each Server can cause multiple HTTP Events.
- Every HTTP Event originated from an EndPoint, is directed to an EndPoint, and has an origin EndPoint.
- Each Request is a type of HTTPEvent and can have zero to one corresponding Responses.
- Each Response, including Redirection, is a type of HTTPEvent that can embed multiple Requests.

There are also some universal facts that hold for this model:

- A Request always has a Client either as its source (from) or destination (to). Similarly, a Response always has a Server either as its source or destination.
- An HTTP Event is caused by a Server only if it is a Response from the Server or is a Request embedded in another Response that the Server caused.
- No Request is ever embedded in a Request that is itself embedded in a Response.
- Every Response is associated with exactly one Request, and the source and destination of the Response and its associated Request are opposite.
- For a Response, its origin is the same as its associated Request if the Response is a Redirect. Otherwise, it's the source of the Response.
- All Requests that are embedded within a Response share their origin with the Response.
- All standalone Requests (i.e., those that are not embedded within a Response) have a Client as their origin.

There is a predicate defined as "obeysOrigins" which applies to a Server. This predicate checks whether a Server would accept a Request only if the Origin of the Request is either the Server itself or the Client it came from.

Finally, there is a check command to ensure that there are no two Servers, referred to as 'good' and 'bad', such that each Request addressed to the 'bad' Server originates from a Client, the 'good' Server obeys the origins, and there is a Request intended for the 'good' Server caused by the 'bad' Server. This check is performed for up to 5 Server objects.