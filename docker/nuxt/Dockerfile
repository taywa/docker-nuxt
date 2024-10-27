FROM alpine:3.20.3
LABEL ch.taywa.ch.image.authors="ys@taywa.ch"

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PATH=$PATH:/opt/node_modules/bin

# essential layer
RUN apk add --no-cache \
    curl \
    nodejs \
    npm \
    the_silver_searcher \
    make \
    rsync \
    bash \
    busybox-extras \
    jq \
    git \
    libintl\
    icu \
    icu-data-full \
    musl-locales \
    musl-locales-lang
ARG S6_OVERLAY_VERSION=v3.2.0.2
ENV S6_STAGE2_HOOK=/etc/s6-overlay/setup-user-services.sh
ENV PATH="${PATH}:/command"
RUN wget -q -O - https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-noarch.tar.xz | \
    xzcat | tar x --exclude=./*/*/*/*/*/*/*/*/legacy-cont-init --exclude=./*/*/*/*/*/*/legacy-cont-init --exclude=./*/*/*/*/*/*/legacy-services --exclude=./*/*/*/*/*/*/*/*/legacy-services -C /
RUN wget -q -O -  https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-`arch`.tar.xz | \
    xzcat | tar x -C /

WORKDIR /opt/nuxt3/
RUN mkdir -p /opt/nuxt3 /opt/node_modules && ln -s /opt/node_modules /opt/nuxt3/node_modules \
    && cd /opt/nuxt3 \
    && echo "prefix = /opt/node_modules" > /root/.npmrc \
    && npm install -g pnpm@9.12.2 \
    && pnpm config set store-dir /opt/.pnpm-store

COPY ./package/05/package.json ./package/05/pnpm-lock.yaml /opt/nuxt3/
RUN pnpm install

COPY s6/etc/s6-overlay /etc/s6-overlay
ENTRYPOINT ["/init"]
EXPOSE 3000
