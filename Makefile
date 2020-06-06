NUXT_VERSION=0.2.4

.PHONY: all

build:
	cd docker && DOCKER_BUILDKIT=1 docker build -t taywa/nuxt:$(NUXT_VERSION) nuxt

push:
	docker push taywa/nuxt:$(NUXT_VERSION)
