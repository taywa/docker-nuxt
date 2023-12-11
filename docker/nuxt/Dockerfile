# syntax=docker/dockerfile:experimental
FROM alpine:3.12.12
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
        make \
        rsync \
        bash \
        jq \
        git
RUN mkdir -p /opt/nuxt /opt/node_modules /tmp/yarn_cache && ln -s /opt/node_modules /opt/nuxt/node_modules \
    && echo "--modules-folder ../node_modules" > /opt/nuxt/.yarnrc
WORKDIR /opt/nuxt/
ENV PATH=$PATH:/opt/node_modules/.bin

# s6 overlay
ARG S6_OVERLAY_VERSION=v1.22.1.0
RUN curl -Ls https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-`arch|sed 's/x86_64/amd64/'`.tar.gz | tar xz -C /

# flatten layer with rss feed
COPY ./package/11/package.json ./package/11/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
    apk add python2 g++ \
    && yarn install --ignore-optional \
    && apk del python2 g++

# added keycloak-js
COPY ./package/12/package.json ./package/12/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
  yarn install --ignore-optional

# added vue-plyr
COPY ./package/13/package.json ./package/13/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
  yarn install --ignore-optional

# updated composition api
COPY ./package/14/package.json ./package/14/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
  yarn install --ignore-optional

# add jq and git
RUN apk add --no-cache jq git

COPY s6/etc/services.d /etc/services.d
COPY s6/etc/cont-init.d /etc/cont-init.d
ENTRYPOINT ["/init"]
EXPOSE 3000
