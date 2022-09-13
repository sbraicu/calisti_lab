
## Circuit breaking

Circuit Breaking is a pattern for creating resilient microservices applications. In microservices architecture, services are deployed across multiple nodes or clusters and have different response times or failure rate. Downstream clients need to be protected from excessive slowness of upstream services. Upstream services, in turn, must be protected from being overloaded by a backlog of requests.

A circuit breaker can have three states:

**Closed**: requests succeed or fail until the number of failures reach a predetermined threshold, with no interference from the breaker. When the threshold is reached, the circuit breaker opens.

**Open**: the circuit breaker trips the requests, which means that it returns an error without attempting to execute the call

**Half open**: the failing service is given time to recover from its broken behavior. If requests continue to fail in this state, then the circuit breaker is opened again and keeps tripping requests. Otherwise, if the requests succeed in the half open state, then the circuit breaker will close and the service will be allowed to handle requests again.

![circuit 1](images/circuit_1.png)

Service Mesh Manager is using Istio’s - and therefore Envoy’s - circuit breaking feature under the hood.

Let's configure a circuit breaking rule using the UI


##Fault injection
Fault injection is a system testing method which involves the deliberate introduction of network faults and errors into a system. It can be used to identify design or configuration weaknesses, and to ensure that the system can handle faults and recover from error conditions.

With Service Mesh Manager, you can inject failures at the application layer to test the resiliency of the services. You can configure faults to be injected into requests that match specific conditions to simulate service failures and higher latency between services. There are two types of failures:

**Delay** adds a time delay before forwarding the requests, emulating various failures such as network issues, an overloaded upstream service, and so on.

**Abort** aborts the HTTP request attempts and returns error codes to a downstream service, giving the impression that the upstream service is faulty.

