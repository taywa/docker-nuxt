NUXT_VERSION=2.15.0-edge
NUXT_VERSION_PREV=2.14.12

.PHONY: all

build:
	cd docker && DOCKER_BUILDKIT=1 \
	docker build nuxt \
		--cache-from taywa/nuxt:$(NUXT_VERSION_PREV) \
		--build-arg BUILDKIT_INLINE_CACHE=1 -t taywa/nuxt:$(NUXT_VERSION)

push:
	docker push taywa/nuxt:$(NUXT_VERSION)
