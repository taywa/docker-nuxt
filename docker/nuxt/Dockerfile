# syntax=docker/dockerfile:experimental
FROM alpine:3.12.9
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
        bash
RUN mkdir -p /opt/nuxt /opt/node_modules /tmp/yarn_cache && ln -s /opt/node_modules /opt/nuxt/node_modules \
    && echo "--modules-folder ../node_modules" > /opt/nuxt/.yarnrc
WORKDIR /opt/nuxt/
ENV PATH=$PATH:/opt/node_modules/.bin

# s6 overlay
ARG S6_OVERLAY_VERSION=v1.22.1.0
RUN curl -Ls https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-`arch|sed 's/x86_64/amd64/'`.tar.gz | tar xz -C /

# # nuxt/node layer 01 flatten includes old 02
# # nuxt/node update buefy, nuxt.js, added vue-pano, vue-matomo
# COPY ./package/01/package.json ./package/01/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#     yarn install --ignore-optional

# # nuxt/node update remove @black40x/vue-pano, vuejs-vr, added vue-pannellum
# COPY ./package/02/package.json ./package/02/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#    yarn install --ignore-optional

# # nuxt/node update added vee-validate
# COPY ./package/03/package.json ./package/03/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#    yarn install --ignore-optional

# # added composition api, nuxt-sitemap, removed vue-plyr plyr
# COPY ./package/04/package.json ./package/04/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#    yarn install --ignore-optional

# # added nuxt composition, nuxt content, babel ie11
# COPY ./package/05/package.json ./package/05/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#    yarn install --ignore-optional

# # added vue-masonry
# COPY ./package/06/package.json ./package/06/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#    yarn install --ignore-optional

# # added vue-social-sharing
# COPY ./package/07/package.json ./package/07/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#    yarn install --ignore-optional

# # added replace vue-masonry with vue-masonry-css
# COPY ./package/08/package.json ./package/08/yarn.lock /opt/nuxt/
# RUN --mount=type=cache,target=/tmp/yarn_cache \
#   yarn install --ignore-optional

# added cookie-universal-nuxt and jwt-decode
COPY ./package/09/package.json ./package/09/yarn.lock /opt/nuxt/
RUN --mount=type=cache,target=/tmp/yarn_cache \
   apk add python2 g++ \
   && yarn install --ignore-optional \
   && apk del python2 g++

COPY s6/etc/services.d /etc/services.d
COPY s6/etc/cont-init.d /etc/cont-init.d
ENTRYPOINT ["/init"]
EXPOSE 3000
