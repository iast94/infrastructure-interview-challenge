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
  -t   Execute load test
  -h   Help
"
}

image_name="talessrc/infrastructure-interview-app:1.0.0"
release_name="interview"
namespace="interview"

while getopts i:U:Pr:n:th flag
do
  case "${flag}" in
    i) image_name=${OPTARG};;
    U) docker_username=${OPTARG};;
    P)
      read -s -p "Docker password: " docker_password;;
    r) release_name=${OPTARG};;
    n) namespace=${OPTARG};;
    t) load_test=true;;
    h)
      help
      exit 0;
  esac
done

echo -e "\nIniating terraform..."
terraform -chdir=infrastructure/terraform/environments/local init
echo

echo -e "Creating infrastructure... \n"
terraform -chdir=infrastructure/terraform/environments/local apply -auto-approve
echo

image_pull_secret=""

if [[ "$docker_username" != "" && "$docker_password" != "" ]]; then
  image_pull_secret="--set imagePullSecret.registry=https://index.docker.io/v1/,\
imagePullSecret.username=$docker_username,\
imagePullSecret.password=$docker_password"
fi

echo -e "Installing application stack... \n"
helm upgrade -n $namespace --create-namespace --wait \
--install $release_name ./infrastructure/helm \
--set app.image=$image_name $image_pull_secret
echo

if [[ -n $load_test ]]; then
  echo -e "Testing stack scalability and availability during load peaks \n"
  docker run --network host -i httpd:2.4-alpine3.18 \
  ab -c 350 -n 20000 http://localhost/posts
else
  echo "Skipping load test..."
fi
