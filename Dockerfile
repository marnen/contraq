FROM ruby:2.5-alpine
MAINTAINER Marnen Laibow-Koser <marnen@marnen.org>

ENV dependencies /dependencies
ENV workdir /contraq
ENV port 3000

# Install build tools and packages needed for native extensions
RUN apk add --update build-base postgresql-dev
# Install JS runtime. TODO: do we want to use therubyracer instead?
RUN apk add nodejs
# See https://github.com/phusion/passenger-docker/issues/195
RUN apk add tzdata
RUN apk add yarn

RUN gem install bundler

# Use temporary build directory for dependencies to improve layer caching
WORKDIR ${dependencies}
COPY Gemfile Gemfile.lock ${dependencies}/
RUN bundle install
COPY package.json yarn.lock ${dependencies}/
RUN yarn install --verbose

EXPOSE ${port}

WORKDIR ${workdir}
COPY . ${workdir}

ENV BUNDLE_GEMFILE Gemfile
RUN cp -r ${dependencies}/node_modules ${workdir}
RUN rm -rf ${dependencies}

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
