FROM ruby:2.2-alpine
RUN apk add --no-cache make g++ libc-dev

WORKDIR /app

ADD Gemfile* ./
RUN bundle install

ADD . .

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]