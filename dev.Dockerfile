FROM golang:1.22-bullseye as backend-dev

# install spatialite
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y --no-install-recommends sqlite3 libsqlite3-mod-spatialite
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*