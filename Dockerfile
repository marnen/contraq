FROM elixir:1.6-alpine
MAINTAINER Marnen Laibow-Koser <marnen@marnen.org>

RUN apk add --update yarn
RUN apk add inotify-tools

# Install or upgrade Hex and Rebar.
RUN mix local.hex --force
RUN mix local.rebar --force

ARG workdir=/contraq/phoenix/contraq
ARG srcdir=./phoenix/contraq

WORKDIR ${workdir}

COPY ${srcdir}/mix.exs ${srcdir}/mix.lock ${workdir}/
RUN mix deps.get

COPY ${srcdir}/assets/package.json ${srcdir}/assets/yarn.lock ${workdir}/assets/
WORKDIR ${workdir}/assets/
RUN yarn install

WORKDIR ${workdir}
COPY . ${workdir}

ARG port=4000

EXPOSE ${port}
ENV PORT ${port}

CMD ["mix", "phx.server"]
