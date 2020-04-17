NUXT_VERSION=0.1.0

.PHONY: all

build:
	cd docker && DOCKER_BUILDKIT=1 docker build -t taywa/nuxt:$(NUXT_VERSION) nuxt

push:
	docker push taywa/nuxt:$(NUXT_VERSION)
