# Getting started

Welcome to the Calisti Webinar - learn to deploy, manage and troubleshoot your service mesh.


Upon completion of this lab, you will be able to: 

•	Deploy the Istio service mesh using Calisti – The Cisco Service Mesh Manager 

•	Deploy a demo application in the service mesh

•	Observe and monitor traffic across various microservices of the demo application

•	Debug and troubleshoot issues in your service 

## Create a 3 node cluster
```bash
/home/developer/tools/cluster/cluster_setup.sh
```
## Deploy calisti

Download and untar smm 

```bash
tar -xvf /home/developer/bin-rel/smm/smm_1.10.0_linux_amd64.tar.gz 
cp ./smm /usr/bin
```

Copy paste the activation command

Install Calisti and expose dashboard
```bash
smm --non-interactive install -a --anonymous-auth --additional-cp-settings /home/developer/tools/smm/enable-dashboard-expose.yaml -c ~/.kube/demo1.kconf
```
Enable reverse-proxy 

```bash
/home/developer/tools/proxy/proxy.sh
```


You should be able to open the [dashboard](dashboard) in your browser.


## Deploy the demo app
```bash
smm demoapp install
```

## Expose an application using istio GW


