#!/bin/bash

ingressip=$(kubectl get svc smm-ingressgateway-external -n smm-system --kubeconfig ~/.kube/demo1.kconf  -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
caddy reverse-proxy --from :8080 --to ${ingressip}:80 &
