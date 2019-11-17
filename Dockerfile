FROM ruby:2.6-alpine3.10

RUN mkdir /app
COPY ./source/ /app/
WORKDIR /app

RUN bundle install
