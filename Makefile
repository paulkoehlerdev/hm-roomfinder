
.PHONY: dev
dev: build-dev
	docker compose -f docker-compose.dev.yml up -d

.PHONY: build-dev
build-dev:
	docker compose -f docker-compose.dev.yml build

.PHONY: attach-frontend
attach-frontend: dev
	docker compose -f docker-compose.dev.yml attach frontend

.PHONY: build-prod
build-prod:
	docker build . -t hmrf_prod