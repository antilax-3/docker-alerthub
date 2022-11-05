FROM node:alpine AS builder

RUN \
  echo "**** install build dependencies ****" && \
    apk add --no-cache git

RUN \
  echo "**** build node application ****" && \
  git clone https://github.com/Ardakilic/alerthub.git /app && \
  cd /app && npm install && sed -i 's/\.\.\/etc\/config/\/config\/config/g' src/index.mjs && \
  mkdir /defaults && mv etc/config.example.js /defaults/config.js && \
  rm -rf .editorconfig .eslintrc .git* CHANGELOG.md etc LICENSE package-lock.json README.md UPGRADING.md renovate.json

FROM antilax3/node

# copy executable and config
COPY --from=builder /app /app
COPY --from=builder /defaults /defaults

# set version labels
ARG build_date
ARG version
LABEL build_date="${build_date}"
LABEL version="${version}"
LABEL maintainer="Nightah"

# set environment variables
ENV NODE_CONFIG_DIR /config

# set working directory
WORKDIR /app

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 3444
VOLUME /config
