FROM elixir:1.6-alpine
MAINTAINER Marnen Laibow-Koser <marnen@marnen.org>

# Install or upgrade Hex.
RUN mix local.hex

ARG workdir=/contraq/phoenix

WORKDIR ${workdir}
