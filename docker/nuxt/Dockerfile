FROM alpine:3.20
LABEL ch.taywa.ch.image.authors="Yves Serrano <ys@taywa.ch>"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
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
    jq \
    git
WORKDIR /opt/nuxt3/
RUN mkdir -p /opt/nuxt3 /opt/node_modules && ln -s /opt/node_modules /opt/nuxt3/node_modules \
    && cd /opt/nuxt3 \
    && echo "prefix = /opt/node_modules" > /root/.npmrc \
    && npm install -g pnpm@9.4.0 \
    && pnpm config set store-dir /opt/.pnpm-store

COPY ./package/01/package.json ./package/01/pnpm-lock.yaml /opt/nuxt3/
RUN pnpm install
COPY ./package/02/package.json ./package/02/pnpm-lock.yaml /opt/nuxt3/
RUN pnpm install

EXPOSE 3000
