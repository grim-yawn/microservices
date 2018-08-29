 FROM alpine:3.7
 ENV APP_HOME /app
 RUN mkdir $APP_HOME
 WORKDIR $APP_HOME
 COPY Gemfile* $APP_HOME/
 RUN apk --update add --no-cache \
     ruby \
     ruby-dev \
     ruby-bundler \
     build-base \
     && bundle install \
     && apk del \
     ruby-bundler \
     build-base \
     ruby-dev \
     && rm -rf /var/cache/apk

 COPY . $APP_HOME

 ENV POST_SERVICE_HOST post
 ENV POST_SERVICE_PORT 5000
 ENV COMMENT_SERVICE_HOST comment
 ENV COMMENT_SERVICE_PORT 9292

 CMD ["puma"]
