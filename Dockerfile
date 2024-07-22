
FROM node:22.5.1 AS frontend-build

COPY frontend .

RUN npm i
RUN npm run build


FROM golang:1.22 AS backend-build

COPY . .

COPY --from=frontend-build build frontend/build

RUN apt-get update && apt-get install -y gcc libc6-dev

RUN go get ./...
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /build/hmrf ./cmd/hmrf

FROM debian:bullseye-slim

# Install spatialite
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y --no-install-recommends sqlite3 libsqlite3-mod-spatialite
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY --from=backend-build /build/hmrf /bin/hmrf

CMD ["/bin/hmrf", "--config", "config.hcl"]