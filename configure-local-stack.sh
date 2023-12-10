#!/bin/bash

help() {
  echo "
Usage:
$0 [-i -U -P -r -n -t -s -d -h]

Flags:
  -i   Image to be used by the application   Default value: 
                                             talessrc/infrastructure-interview-app:1.0.0
  -U   Docker username to pull image       
       (Just set if the image is private)
  -P   Docker password to pull image
       (Just set if the image is private)
  -r   Helm release name                     Default value: interview
  -n   Namespace to install helm release     Default value: interview
  -t   Execute infrastructure tests
  -s   Skip infrastructure creation
  -d   Destroy after finish all steps
  -h   Help
"
}

run_apache_ab() {
  echo -e "\nMaking $1 requests \n"
  docker run --network host -i httpd:2.4-alpine3.18 \
  ab -c 350 -n $1 -q http://localhost/posts | grep -E \
  "Requests per second:|Time per request:|Failed requests"

  sleep 10
}

image_name="talessrc/infrastructure-interview-app:1.0.0"
release_name="interview"
namespace="interview"

while getopts i:U:Pr:n:tsdh flag
do
  case "${flag}" in
    i) image_name=${OPTARG};;
    U) docker_username=${OPTARG};;
    P)
      read -s -p "Docker password: " docker_password;;
    r) release_name=${OPTARG};;
    n) namespace=${OPTARG};;
    t) infra_test=true;;
    s) skip_infra_creation=true;;
    d) destroy_after_finish_steps=true;;
    h)
      help
      exit 0;
  esac
done

image_pull_secret=""

if [[ "$docker_username" != "" && "$docker_password" != "" ]]; then
  image_pull_secret="--set imagePullSecret.registry=https://index.docker.io/v1/,\
imagePullSecret.username=$docker_username,\
imagePullSecret.password=$docker_password"
fi

if [[ -z $skip_infra_creation ]]; then
  echo -e "\nIniating terraform..."
  terraform -chdir=infrastructure/terraform/environments/local init
  echo

  echo -e "Creating infrastructure... \n"
  terraform -chdir=infrastructure/terraform/environments/local apply -auto-approve
  echo

  echo -e "Installing/upgrading application stack... \n"
  helm upgrade -n $namespace --create-namespace --wait \
  --install $release_name ./infrastructure/helm \
  --set app.image=$image_name $image_pull_secret
  echo
fi

if [[ -n $infra_test ]]; then
  echo "Testing stack scalability and availability during load peaks"
  run_apache_ab 1000

  for i in {2000..10000..2000}
  do
    run_apache_ab $i
  done

  echo -e "\nTesting stack availability during deployment \n"
  helm upgrade -n $namespace --install \
  $release_name ./infrastructure/helm \
  --set app.image=$image_name,app.readinessProbe.initialDelaySeconds=21 \
  $image_pull_secret

  run_apache_ab 1000
fi

if [[ -n $destroy_after_finish_steps ]]; then
  echo -e "\nDestroying infrastructure..."
  terraform -chdir=infrastructure/terraform/environments/local destroy -auto-approve
fi
