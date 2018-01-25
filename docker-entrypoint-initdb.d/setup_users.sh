#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-SQL
  CREATE ROLE ${APP_DB_USERNAME} login nosuperuser nocreaterole createdb encrypted password '${APP_DB_PASSWORD}';
  CREATE DATABASE ${APP_DB_USERNAME};
  GRANT ALL PRIVILEGES ON DATABASE ${APP_DB_USERNAME} TO ${APP_DB_USERNAME};
SQL
