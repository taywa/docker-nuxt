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
RUN mkdir -p /opt/nuxt /opt/node_modules /tmp/yarn_cache && ln -s /opt/node_modules /opt/nuxt/node_modules \
    && echo "--modules-folder ../node_modules" > /opt/nuxt/.yarnrc
WORKDIR /opt/nuxt/
ENV PATH=$PATH:/opt/node_modules/.bin

# s6 overlay
ARG S6_OVERLAY_VERSION=v1.22.1.0
RUN curl -Ls https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz | tar xz -C /

# nuxt/node layer 01
COPY ./package/01/package.json ./package/01/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

# nuxt/node layer 02
COPY ./package/01/package.json ./package/01/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    yarn install --ignore-optional

COPY s6/etc/services.d /etc/services.d
COPY s6/etc/cont-init.d /etc/cont-init.d
ENTRYPOINT ["/init"]
EXPOSE 3000
