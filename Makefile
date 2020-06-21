NUXT_VERSION=2.13.0

.PHONY: all

build:
	cd docker && DOCKER_BUILDKIT=1 docker build -t taywa/nuxt:$(NUXT_VERSION) nuxt

push:
	docker push taywa/nuxt:$(NUXT_VERSION)
