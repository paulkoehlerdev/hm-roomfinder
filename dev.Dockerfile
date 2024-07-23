FROM golang:1.22-bullseye AS backend-dev

# install spatialite
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y --no-install-recommends sqlite3 libsqlite3-mod-spatialite
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD go run ./cmd/hmrf -config config/dev.hcl

FROM ghcr.io/cirruslabs/flutter:latest AS frontend-dev

WORKDIR /app

RUN apt update
RUN apt install -y --no-install-recommends entr
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY docker/frontend-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh