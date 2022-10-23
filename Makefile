NUXT_VERSION=2.14.7p

.PHONY: all

build-arch:
	cd docker && DOCKER_BUILDKIT=1 \
	docker buildx build \
		--load \
		--platform linux/`arch|sed 's/x86_64/amd64/'` \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		-t taywa/nuxt:$(NUXT_VERSION)-`arch|sed 's/x86_64/amd64/'` \
		nuxt

# build-archs:
# 	cd docker && DOCKER_BUILDKIT=1 \
# 	docker buildx build \
# 		--platform linux/arm64,linux/amd64 \
# 		--build-arg BUILDKIT_INLINE_CACHE=1 \
# 		-t taywa/nuxt:$(NUXT_VERSION) \
# 		nuxt

# build-push:
# 	cd docker && DOCKER_BUILDKIT=1 \
# 	docker buildx build \
# 		--push \
# 		--platform linux/arm64,linux/amd64 \
# 		--build-arg BUILDKIT_INLINE_CACHE=1 \
# 		-t taywa/nuxt:$(NUXT_VERSION) \
# 		nuxt

push-arch:
	docker tag taywa/nuxt:$(NUXT_VERSION) taywa/nuxt:$(NUXT_VERSION)-`arch|sed 's/x86_64/amd64/'`
	docker push taywa/nuxt:$(NUXT_VERSION)-`arch|sed 's/x86_64/amd64/'`

push-manifest:
	manifest-tool --debug push from-args \
		--platforms linux/amd64,linux/arm64 \
		--template taywa/nuxt:$(NUXT_VERSION)-ARCH \
		--target taywa/nuxt:$(NUXT_VERSION)
