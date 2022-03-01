NUXT_VERSION=2.14.7l
NUXT_VERSION_PREV=2.14.7k

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

build-archs:
	cd docker && DOCKER_BUILDKIT=1 \
	docker buildx build \
		--platform linux/arm64,linux/amd64 \
		--cache-from taywa/nuxt:$(NUXT_VERSION_PREV) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t taywa/nuxt:$(NUXT_VERSION) \
		nuxt

build-push:
	cd docker && DOCKER_BUILDKIT=1 \
	docker buildx build \
		--push \
		--progress=plain \
		--platform linux/arm64,linux/amd64 \
		--cache-from=type=registry,ref=taywa/nuxt:$(NUXT_VERSION_PREV) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t taywa/nuxt:$(NUXT_VERSION) \
		nuxt

#  --cache-from taywa/nuxt:$(NUXT_VERSION_PREV) \
#  --cache-to=type=registry,ref=taywa/nuxt:$(NUXT_VERSION_PREV),mode=max \
