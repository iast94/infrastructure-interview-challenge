#!/bin/bash

help() {
  echo "
Usage:
$0 [-i -h]

Flags:
  -i   Image name                           Required
       <username>/<image_name>:<version>
  -r   Repository url                                 Default value: DockerHub url
  -h   Help
"
}

while getopts i:r:t:h flag
do
  case "${flag}" in
    i) image_name=${OPTARG};;
    r) repository_url=${OPTARG};;
    h)
      help
      exit 0
  esac
done

if [[ -z $image_name ]]; then
  echo "Flag -i is required, please check the help guide (-h)"
  exit 1
fi

echo "Checking if you are logged in on DockerHub"
username=$(docker info | sed '/Username:/!d;s/.* //')

if [[ $username == "" ]]; then
  echo "You are not, please login below"
  echo
  docker login
  if [[ $? -eq 1 ]]; then
    exit 1
  fi
else
  echo "You are already logged in"
fi

if [[ ! -z $repository_url ]]; then
  image_fullname="$repository_url/$image_name"
else
  image_fullname="$image_name"
fi

echo "Building docker image $image_fullname"
docker build -t "$image_fullname" .

echo "Pushing docker image"
docker push $image_fullname
