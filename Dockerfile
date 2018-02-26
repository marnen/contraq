FROM elixir:1.6-alpine
MAINTAINER Marnen Laibow-Koser <marnen@marnen.org>


ARG workdir=/contraq/phoenix
# Install or upgrade Hex.
RUN mix local.hex --force

WORKDIR ${workdir}
