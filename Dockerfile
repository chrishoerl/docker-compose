ARG DOCKER_VERSION=20.10.7
#ARG DOCKER_VERSION=20.10.6
#ARG DOCKER_VERSION=20.10.5
#ARG DOCKER_VERSION=20.10.2
#ARG DOCKER_VERSION=20.10.0
#ARG DOCKER_VERSION=19.03.14
#ARG DOCKER_VERSION=19.03.13
#ARG DOCKER_VERSION=19.03.12
#ARG DOCKER_VERSION=19.03.11
#ARG DOCKER_VERSION=19.03.10
#ARG DOCKER_VERSION=19.03.9
#ARG DOCKER_VERSION=19.03.8
#ARG DOCKER_VERSION=19.03.7
#ARG DOCKER_VERSION=19.03.6
#ARG DOCKER_VERSION=19.03.5

ARG COMPOSE_VERSION=1.29.2
#ARG COMPOSE_VERSION=1.29.1
#ARG COMPOSE_VERSION=1.29.0
#ARG COMPOSE_VERSION=1.28.6
#ARG COMPOSE_VERSION=1.28.5
#ARG COMPOSE_VERSION=1.28.2
#ARG COMPOSE_VERSION=1.28.0
#ARG COMPOSE_VERSION=1.27.4
#ARG COMPOSE_VERSION=1.27.3
#ARG COMPOSE_VERSION=1.26.2
#ARG COMPOSE_VERSION=1.26.1
#ARG COMPOSE_VERSION=1.26.0
#ARG COMPOSE_VERSION=1.25.4
#ARG COMPOSE_VERSION=1.25.3
#ARG COMPOSE_VERSION=1.25.1
#ARG COMPOSE_VERSION=1.25.0
#ARG COMPOSE_VERSION=1.24.1

FROM docker:${DOCKER_VERSION}

RUN apk update

RUN apk upgrade

RUN apk add --no-cache \
		ca-certificates \
		py-pip \
		python3-dev \
		libffi-dev \
		openssl-dev \
		gcc \
		libc-dev \
		make \
		bash \
		git \
		curl \
		rust \
		cargo

RUN pip install "docker-compose${COMPOSE_VERSION:+==}${COMPOSE_VERSION}"

RUN addgroup -S -g 1000 docker && adduser -S -G docker -u 1000 docker

RUN docker --version && \
    docker-compose --version && \
    git --version

## docker-entrypoint.sh from Docker-Docker-Image
##  https://github.com/docker-library/docker/blob/4dd3f3fe1f263ea74cdc8bed6091008cf62ab751/19.03/docker-entrypoint.sh
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]