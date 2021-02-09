NUXT_VERSION=2.14.12
NUXT_VERSION_PREV=2.14.7c

.PHONY: all

build:
	cd docker && DOCKER_BUILDKIT=1 \
	docker build nuxt \
		--cache-from taywa/nuxt:$(NUXT_VERSION_PREV) \
		--build-arg BUILDKIT_INLINE_CACHE=1 -t taywa/nuxt:$(NUXT_VERSION)

push:
	docker push taywa/nuxt:$(NUXT_VERSION)
