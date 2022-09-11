# Getting started

Welcome to the Calisti Webinar - learn to deploy, manage and troubleshoot your service mesh.

## Scenario

A service mesh provides many benefits to Cloud Native applications, including observability, security, and load-balancing. However, mesh architectures present operators with several inherent challenges including lifecycle management, fragmented observability, and the complexity of enabling advanced use-cases, such as canary deployments, customized traffic management and circuit breakers.

Calisti is a multi and hybrid-cloud enabled service mesh platform for constructing modern applications. Built on Kubernetes, and our Istio operator, Calisti enables flexibility, portability and consistency across on-prem data centres and cloud environments. Calisti operationalizes the service mesh to bring deep observability, convenient management, and policy-based security to modern container & virtual machine-based applications.

Calisti includes Prometheus to ensure faster troubleshooting and recovery. It supports distributed tracing via Jeager which is installed automatically by default when installing Calisti. 

Upon completion of this lab, you will be able to: 

•	Deploy the Istio service mesh using Calisti – The Cisco Service Mesh Manager 

•	Deploy a demo application in the service mesh

•	Observe and monitor traffic across various microservices of the demo application

•	Debug and troubleshoot issues in your service 

## Create a 3 node cluster
```bash
/home/developer/tools/cluster/cluster_setup.sh
```

### Kubernetes Checks

To check the status of the Kubernetes clusters, do the following:

Verify the clusters exist.  Expected output should show the `demo1` cluster.

   ```bash
   kind get clusters
   ```
   
Check the status of the pods running in the clusters.  All pods should be in "Ready" state.

   ```bash
   kubectl get pods -A
   ```


## Deploy Calisti

Navigate to https://calisti.app. Click on the “Sign up, It’s Free” button and proceed to register and download the Calisti binaries.

![calisti register](images/1_1.png)

For simplicity, the smm binary is already copied in your lab environment

Extract the smm binary and copy to the system path
```bash
tar -xvf /home/developer/bin-rel/smm/smm_1.10.0_linux_amd64.tar.gz 
cp ./smm /usr/bin
```

Please copy and paste the activation credentials command provided on the download page to the terminal.

![calisti register](images/1_2.png)

Install Calisti and expose dashboard
```bash
smm --non-interactive install -a --anonymous-auth --additional-cp-settings /home/developer/tools/smm/enable-dashboard-expose.yaml -c ~/.kube/demo1.kconf
```

check the Calisti SMM multicluster status, do the following:

```bash
smm istio cluster status -c ~/.kube/demo1.kconf
```

The expected output should show 2 clusters with one instance of control plane.

```
developer:src > smm istio cluster status -c ~/.kube/demo1.kconf 
Clusters
---
Name        Type   Provider  Regions  Version   Distribution  Status  Message  
kind-demo1  Local  kind      []       v1.19.11  KIND          Ready            
kind-demo2  Peer   kind      []       v1.19.11  KIND          Ready            


ControlPlanes
---
Cluster     Name                   Version  Trust Domain     Pods                                             Proxies  
kind-demo1  cp-v112x.istio-system  1.12.5   [cluster.local]  [istiod-cp-v112x-5cf4c487c6-l47q6.istio-system]  25/25    
```

In order to be able to access the Calisti dashboard outside of the lab container we need to enable a reverse-proxy 
```bash
/home/developer/tools/proxy/proxy.sh
```


You should be able to open the [dashboard](dashboard) in your browser.


## Deploy the demo app
```bash
smm demoapp install
```

## Expose an application using istio GW


