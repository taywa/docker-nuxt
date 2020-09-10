# syntax=docker/dockerfile:experimental
FROM alpine:3.12.0
MAINTAINER Yves Serrano <ys@taywa.ch>

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV YARN_CACHE_FOLDER /tmp/yarn_cache

# essential layer
RUN apk add --no-cache \
        curl \
        nodejs \
        yarn \
        the_silver_searcher \
        make
RUN mkdir -p /opt/nuxt /node_modules /tmp/yarn_cache && ln -s /node_modules /opt/nuxt/node_modules
WORKDIR /opt/nuxt/
ENV PATH=$PATH:/node_modules/.bin

# s6 overlay
ARG S6_OVERLAY_VERSION=v1.22.1.0
RUN curl -Ls https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz | tar xz -C /

# nuxt/node layer 00
COPY ./package/00/package.json ./package/00/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

# nuxt/node layer 01, update nuxt, added date-fns
COPY ./package/01/package.json ./package/01/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

# nuxt/node layer 02 added raw loader for xml
COPY ./package/02/package.json ./package/02/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

# nuxt/node layer 03 updated nuxt 2.14.4 added express
COPY ./package/03/package.json ./package/03/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

# nuxt/node layer 04 vue number counter
COPY ./package/04/package.json ./package/04/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

COPY s6/etc/services.d /etc/services.d
COPY s6/etc/cont-init.d /etc/cont-init.d
ENTRYPOINT ["/init"]
EXPOSE 3000
