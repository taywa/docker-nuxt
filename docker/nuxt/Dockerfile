# syntax=docker/dockerfile:experimental
FROM alpine:3.11.5
MAINTAINER Yves Serrano <ys@taywa.ch>

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV YARN_CACHE_FOLDER /tmp/yarn_cache

# essential layer
RUN apk add --no-cache \
        curl \
        nodejs \
        yarn \
        make
RUN mkdir -p /opt/nuxt /node_modules /tmp/yarn_cache && ln -s /node_modules /opt/nuxt/node_modules
WORKDIR /opt/nuxt/

# s6 overlay
ARG S6_OVERLAY_VERSION=v1.22.1.0
RUN curl -Ls https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz | tar xz -C /

# nuxt/node layer 00
COPY ./package/00/package.json ./package/00/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

# nuxt/node layer 01 / added apollo
COPY ./package/01/package.json ./package/01/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

# COPY s6/etc/services.d /etc/services.d
# COPY s6/etc/cont-init.d /etc/cont-init.d
ENV PATH=$PATH:/node_modules/.bin
ENTRYPOINT ["/init"]
EXPOSE 3000
