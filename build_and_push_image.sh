#!/bin/bash

echo "Checking if you are logged in on DockerHub"
username=$(docker info | sed '/Username:/!d;s/.* //')

if [[ $username == "" ]]; then
  echo "You are not, please login below"
  echo
  docker login
  if [[ $? -eq 1 ]]; then
    exit 1
  fi
  username=$(docker info | sed '/Username:/!d;s/.* //')
else
  echo "You are already logged in"
fi

echo
read -p "Image name: " repository 

echo "Building docker image $username/$repository"
docker build -t "$username/$repository" .

echo "Pushing docker image"
docker push $username/$repository
