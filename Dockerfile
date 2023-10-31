FROM node:18.18.2-alpine@sha256:435dcad253bb5b7f347ebc69c8cc52de7c912eb7241098b920f2fc2d7843183d

ARG REACT_APP_ENV=local

RUN apk add --no-cache \
  curl

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN yarn global add serve

COPY package.json yarn.lock .npmrc ./
COPY patches ./patches
RUN yarn install --frozen-lockfile

COPY . .

RUN REACT_APP_ENV=$REACT_APP_ENV yarn build

CMD ["serve", "-s", "build"]
