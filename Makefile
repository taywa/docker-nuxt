NUXT_VERSION=2.14.7j
NUXT_VERSION_PREV=2.14.7i

.PHONY: all

build-arch:
	cd docker && DOCKER_BUILDKIT=1 \
	docker buildx build \
		--load \
		--platform linux/`arch|sed 's/x86_64/amd64/'` \
		--cache-from taywa/nuxt:$(NUXT_VERSION_PREV) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t taywa/nuxt:$(NUXT_VERSION) \
		nuxt

build-push:
	cd docker && DOCKER_BUILDKIT=1 \
	docker buildx build \
		--push \
		--platform linux/arm64,linux/amd64 \
		--cache-from taywa/nuxt:$(NUXT_VERSION_PREV) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t taywa/nuxt:$(NUXT_VERSION) \
		nuxt
