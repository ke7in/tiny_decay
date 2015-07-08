# tiny_decay
test: url_shortener with expiry

Build Instructions

*Ruby version shouldn't matter, but built with Ruby 2.1.1.

gem install bundler -> Bundler is required
bundle install -> to install required gems from Gemfile
redis-server -> to start redis server (download redis: http://redis.io/download)
compass compile -> shouldn't be needed unless sass is added to
rackup -> should start sinatra server at http://localhost:9292/
