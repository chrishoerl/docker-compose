ARG DOCKER_VERSION=19.03.5
ARG COMPOSE_VERSION=1.25.1
#ARG COMPOSE_VERSION=1.25.0
#ARG COMPOSE_VERSION=1.24.1

FROM docker:${DOCKER_VERSION}

RUN apk update

RUN apk upgrade

RUN apk add --no-cache \
		ca-certificates \
		py-pip python-dev \
		libffi-dev \
		openssl-dev \
		gcc \
		libc-dev \
		make \
		bash \
		git \
		curl

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