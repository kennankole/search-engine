#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

bundle exec rake assets:precompile

bundle exec rake db:create db:migrate

bundle exec rails assets:clean
bundle exec rails assets:precompile