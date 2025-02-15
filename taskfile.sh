#!/bin/bash
# Enable shell strict mode
set -euo pipefail

NUXT_VERSION="3.13.2d"

build() {
	cd docker
	DOCKER_BUILDKIT=1 docker buildx build \
		--load \
		--platform linux/`arch|sed 's/x86_64/amd64/'` \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t taywa/nuxt:$NUXT_VERSION-`arch|sed 's/x86_64/amd64/'` \
		nuxt
}

push() {
	cd docker
	DOCKER_BUILDKIT=1 docker buildx build \
		--push \
		--platform linux/arm64,linux/amd64 \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t taywa/nuxt:$NUXT_VERSION \
		nuxt

}

# execute passed string as function
"$@"
