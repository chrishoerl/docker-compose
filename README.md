# Docker, docker-compose and git

This docker image has `docker-compose` and `git` installed on top of `docker`.
This is very useful for CI/CD pipelines, this is a nested docker image, to run docker in docker.

## Versions / ARGS
- **latest**

Includes the current versions of `docker` and `docker-compose`:
- docker 19.03.13
- docker-compose 1.27.3

## Usage example for Gitlab CI/CD

This image is for use in a `.gitlab-ci.yml` file:

```` yml
image: chrishoerl/docker-compose

stages:
  - build
  - deploy
  - test

before_script:
  - docker info
  - docker-compose --version
  - git --version
  - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
  
build-your-images:
  stage: build
  script:
    - docker-compose build
    - docker tag myimage myregistry/myimage:$version
    - docker-compose push
    
deploy-your-image:
  stage: deploy
  script:
    - docker-compose up
    
test-my-app
  stage: test
  script:
    - docker logs -f my-docker-compose-app
````
