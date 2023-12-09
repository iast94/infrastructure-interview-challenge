# Infrastructure Challenge

## Helm Chart

The helm chart is within the folder "infrastructure/helm" and it implements the 
database, app and webserver resources. It also has a README file explain all 
accepted values.

## Local Stack

To configure the cluster locally you will need the following binaries installed 
in your machine (the usage of a different version may lead to a different result 
in the cluster creation):

| Binary | Used version |
|-------- | -------------|
| kubectl | 1.26.1 |
| terraform | 1.4.0 |

To configure it run ```./configure-and-test-local-env.sh``` inside the repository 
root folder.

This script will initiate and apply the terraform module, install or upgrade the helm 
chart version and test its scalability under a high load of requests.

If you have any questions about the accepted flags and their default values, you 
can run ```./configure-and-test-local-env.sh -h```

### Additional components

It comes with additional components, such as: nginx ingress controller, metrics-server and kube-prometheus (optional).

### Ingress URL

In the helm values file, you can specify your application URL, but to be able to 
access it locally you will need to edit the file ```/etc/hosts``` adding the 
following value ```127.0.0.1     <your-url>```

## Build and push image

To build and push image with a single command, you can run ```./build-and-push-image.sh``` 
it also provides a ```-h``` flag to help you with the parameters.
