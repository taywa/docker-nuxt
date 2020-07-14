NUXT_VERSION=2.13.3b

.PHONY: all

build:
	cd docker && DOCKER_BUILDKIT=1 docker build -t taywa/nuxt:$(NUXT_VERSION) nuxt

push:
	docker push taywa/nuxt:$(NUXT_VERSION)
