FROM elixir:1.6-slim
MAINTAINER Marnen Laibow-Koser <marnen@marnen.org>

# Allow HTTPS APT sources; see https://askubuntu.com/questions/104160/method-driver-usr-lib-apt-methods-https-could-not-be-found-update-error
RUN apt-get update && apt-get install -y apt-transport-https

RUN apt-get install -y make
RUN apt-get install -y postgresql-client
RUN apt-get install -y inotify-tools

# Add Yarn public key; see https://github.com/yarnpkg/yarn/issues/4453.
RUN apt-get install -y curl
RUN curl -sS https://raw.githubusercontent.com/yarnpkg/releases/gh-pages/debian/pubkey.gpg | apt-key add -

# Install Node and Yarn.
# RUN apk add yarn
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" >/etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

# Install PhantomJS.
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >/etc/apt/sources.list.d/backports.list
RUN apt-get update && apt-get install -y phantomjs

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
