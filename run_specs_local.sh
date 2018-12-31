#!/bin/bash

# Assumes database is running prior
# Should be source'd, not executed.
#
# To run database via docker, use:
#   docker run -p 5432:5432 -d postgres:9.6-alpine
# To provision the database, use:
#   psql -c 'create database test;' -U postgres --host=localhost --port=5432

rvm use

if [ $? -ne 0 ]; then
  echo "Error setting ruby version. Is RVM installed and working?"
  exit 1
fi

bundle install

export DATABASE_URL=postgres://postgres:@localhost:5432/test
export SENDER_EMAIL=sendfrom@mynonprofit.org
export OWNER_EMAIL=owner@mynonprofit.org
export CODECOV_TOKEN="0caa47ce-4ba0-437a-827c-f42820c18b8f"

bundle exec rake db:migrate

bundle exec rspec
