
.PHONY: dev
dev:
	docker compose -f docker-compose.dev.yml up -d --force-recreate

prod:
	docker build . -t hmrf_prod