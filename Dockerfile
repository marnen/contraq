FROM ruby:2.5-alpine
MAINTAINER Marnen Laibow-Koser <marnen@marnen.org>

ENV workdir /contraq
ENV port 3000

WORKDIR ${workdir}
COPY . ${workdir}

# Install build tools and packages needed for native extensions
RUN apk add --update build-base postgresql-dev
# Install JS runtime. TODO: do we want to use therubyracer instead?
RUN apk add nodejs
# See https://github.com/phusion/passenger-docker/issues/195
RUN apk add tzdata

RUN gem install bundler
RUN bundle install

EXPOSE ${port}

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
