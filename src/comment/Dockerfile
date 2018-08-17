FROM ruby:2.2-alpine
RUN apk add --no-cache make gcc libc-dev

WORKDIR /app

ADD Gemfile* ./
RUN bundle install

ADD . .

ENV COMMENT_DATABASE_HOST post_db
ENV COMMENT_DATABASE comments

CMD ["puma"]