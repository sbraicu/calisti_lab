# Observe system health and topology

## Topolgy 

The TOPOLOGY page of the Service Mesh Manager web interface displays the topology of services and workloads inside the mesh, and annotates it with real-time and information about latency, throughput, or HTTP request failures. You can also display historical data by adjusting the timeline.

The topology view is almost entirely based on metrics: metrics received from Prometheus and enhanced with information from Kubernetes.

The topology page serves as a starting point of diagnosing problems within the mesh. Service Mesh Manager is integrated with Grafana and Jaeger for easy access to in-depth monitoring and distributed traces of various services.

Select the smm-demo namespace and display its topolgy.

![topology 1](images/topology_1.png)

The nodes in the graph are services or workloads, while the arrows represent network connections between different services. This is based on Istio metrics retrieved from Prometheus.

For certain services like MySQL and PostgreSQL, protocol-specific metrics normally not available in Istio are also shown, for example, sessions or transactions per second.

Select one node in the graph (for example the postgresql service) and display its details. By drilling down and selecting the pod it is also possible to display its logs directly in the dashboard (click on the ![log](images/log_icon.png) icon)

![topology 1](images/pod_logs.png)

## Generate traffic load


Most of the data displayed in the Calisti interface is based on anaylsing the traffic received by the different applications in the cluster. Calisti provides several mechanisms to generate traffic.

If there is no traffic generated, the topolgy cannot be displayed, and an option to generate traffic is displayed instead.

![traffic 1](images/traffic_1.png)

If the topology is generated, triggering the traffic generation can be done using the HTML button on the left

![traffic 2](images/traffic_2.png)

Let's generate some traffic on the frontend service from the smm-demo namespace.

![traffic 3](images/traffic_3.png)

Going back to the overview page of the dashboard we can now see the traffic increasing.

![traffic 4](images/traffic_4.png)

For the demoapp application constant traffic can also be generated using the CLI. 

Start with

```bash
smm demoapp load start
```

and stop with

```bash
smm demoapp load stop
```

## Traffic tap

The traffic tap feature of Service Mesh Manager enables you to monitor live access logs of the Istio sidecar proxies. Each sidecar proxy outputs access information for the individual HTTP requests or HTTP/gRPC streams.

The access logs contain information about the:

reporter proxy,
source and destination workloads,
request,
response, as well as the
timings.

### Traffic tap using the CLI

To watch the access logs for an individual namespace, workload or pod, use the smm tap command. Be sure to have some live traffic generated using any of the previous methods for this to work.

For smm-demo namespace

```bash
smm tap ns/smm-demo
```

The output should be similar to

![ttap 1](images/ttap_1.png)

It also possible to filter on workload

```bash
smm tap --ns smm-demo workload/bookings-v1
```

or a pod
```bash
POD_NAME=$(kubectl get pod -n smm-demo -l app=bookings -o jsonpath="{.items[0]..metadata.name}")
smm tap --ns smm-demo pod/$POD_NAME
```

and also use filter tags to only display the relevant lines like

```bash
smm tap ns/smm-demo --method GET --response-code 500,599
```