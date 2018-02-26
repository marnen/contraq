FROM elixir:1.6-alpine
MAINTAINER Marnen Laibow-Koser <marnen@marnen.org>

RUN apk add --update yarn

# Install or upgrade Hex.
RUN mix local.hex --force

ARG workdir=/contraq/phoenix/contraq
ARG srcdir=./phoenix/contraq

WORKDIR ${workdir}

COPY ${srcdir}/mix.exs ${srcdir}/mix.lock ${workdir}/
RUN mix deps.get

COPY ${srcdir}/assets/package.json ${srcdir}/assets/yarn.lock ${workdir}/assets/
WORKDIR ${workdir}/assets/
RUN yarn install

COPY . ${workdir}
