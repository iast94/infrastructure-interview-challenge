#!/bin/bash

help() {
  echo "
Usage:
$0 [-i -U -P -r -n -h]

Flags:
  -i   Image to be used by the application   Default value: 
                                             talessrc/infrastructure-interview-app:1.0.0
  -U   Docker username to pull image       
       (Just set if the image is private)
  -P   Docker password to pull image
       (Just set if the image is private)
  -r   Helm release name                     Default value: interview
  -n   Namespace to install helm release     Default value: interview
  -h   Help
"
}

image_name="talessrc/infrastructure-interview-app:1.0.0"
release_name="interview"
namespace="interview"

while getopts i:U:Pr:n:h flag
do
  case "${flag}" in
    i) image_name=${OPTARG};;
    U) docker_username=${OPTARG};;
    P)
      read -s -p "Docker password: " docker_password;;
    r) release_name=${OPTARG};;
    n) namespace=${OPTARG};;
    h)
      help
      exit 0;
  esac
done

echo
echo "Iniating terraform..."
terraform -chdir=infrastructure/terraform/environments/local init
echo

echo "Creating infrastructure..."
terraform -chdir=infrastructure/terraform/environments/local apply -auto-approve
echo

image_pull_secret=""

if [[ "$docker_username" != "" && "$docker_password" != "" ]]; then
  image_pull_secret="--set imagePullSecret.registry=https://index.docker.io/v1/,\
imagePullSecret.username=$docker_username,\
imagePullSecret.password=$docker_password"
fi

echo "Installing application stack..."
helm upgrade -n $namespace --create-namespace --wait \
--install $release_name ./infrastructure/helm \
--set app.image=$image_name,webserver.port=80 $image_pull_secret
echo

webserver_url=$(kubectl get svc -n $namespace -o \
custom-columns=:.metadata.name --no-headers -l \
component="webserver-service")

echo "Testing stack scalability and availability during load peaks (press ctrl+c to stop)"
kubectl run -i --tty load-generator --rm -n $namespace \
--image=busybox:1.28 --restart=Never -- \
/bin/sh -c "while sleep 0.01; do wget -q -O- http://$webserver_url/posts; done"

kubectl delete po -n $namespace load-generator
