#!/bin/bash

DOCKER_IMAGE=$1
DOCKER_IMAGE_TAG=$2
TRUNCATED_TAG=$(echo "${DOCKER_IMAGE_TAG}" | cut -c 1-7)

ssh -i ~/.ssh/id_rsa root@159.223.170.64 "docker pull ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG} && docker stop ${DOCKER_IMAGE} || true && docker rm ${DOCKER_IMAGE} || true && docker run -d --restart always --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${TRUNCATED_TAG}"
