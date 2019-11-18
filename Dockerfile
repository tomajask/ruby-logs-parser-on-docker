FROM ruby:2.6-alpine3.10

RUN apk update && apk add gcc less libc-dev make

RUN mkdir /app
COPY ./source/Gemfile ./source/Gemfile.lock /app/
WORKDIR /app

RUN bundle install --jobs=4
