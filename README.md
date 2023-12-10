# Infrastructure Challenge

## Helm Chart

The helm chart is within the folder "infrastructure/helm" and it implements the 
database, app and webserver resources. It also has a README file explaining all 
accepted values.

## Local Stack

To configure the cluster locally you will need the following binaries installed 
in your machine (the usage of a different version may lead to a different result 
in the cluster creation):

| Binary | Used version |
|-------- | -------------|
| kubectl | 1.26.1 |
| terraform | 1.4.0 |
| docker | 23.0.5 |

To configure the local stack run ```./configure-local-stack.sh``` inside the repository 
root folder.

This script will initiate and apply the terraform module, install/upgrade the helm 
chart version and test (if asked) its scalability under a high load of requests.

If you have any questions about the accepted flags and their default values, you 
can run ```./configure-local-stack.sh -h```

### Additional components

It comes with additional components, such as: nginx ingress controller, metrics-server (optional) and kube-prometheus (optional).

### Ingress URL

In the helm values file, you can specify your application URL, but to be able to 
access it locally with a URL not equals to ```localhost``` you will need to edit the file ```/etc/hosts``` adding the 
following value: ```127.0.0.1     <your-url>```

## Build and push image

To build and push image with a single command, you can run ```./build-and-push-image.sh``` 

It also provides a ```-h``` flag to help you with the parameters.

## Tests

Using the flag ```-t``` two tests are executed to ensure accomplishment of SLOs.

SLOs:

1) 90% of the requests must return a non 5XX status code within a range of 31000 requests.

2) 90% of the requests must return a non 5XX status code within a range of 1.000 requests during a deployment.

Their respective tests:

1) Using apache ab to get the benchmarking
of the server, the script makes 31000
requests in 6 parts: 1000, 2000, 4000, 6000, 8000, 10000. In real life the traffic increse would be more natural, so the pods would get ready on time, to emulate it, the script gives 10s without
requests to the pods get ready instead of flutuate the number of requests.

2) Using apache ab to get the benchmarking
of the server, the script makes 1000
requests while a deployment is running
with rolling update strategy.
