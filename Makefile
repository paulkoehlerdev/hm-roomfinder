
.PHONY: dev
dev:
	docker compose -f docker-compose.dev.yml up -d

.PHONY: build-dev
build-dev:
	docker compose -f docker-compose.dev.yml build

.PHONY: attach-frontend
attach-frontend:
	docker compose -f docker-compose.dev.yml attach frontend

.PHONY: build-prod
build-prod:
	docker build . -t hmrf_prod