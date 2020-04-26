#!/bin/bash

set +x
set -e
set -o errexit
set -o pipefail

echo "Pixelfed ${PIXELFED} entrypoint"

function waitdb() {
    # pixelfed supported types: mysql, pgsql, sqlite
    # see https://docs.pixelfed.org/technical-documentation/env.html

    # set default values
    if [ -z "${DB_CONNECTION}" ]; then
        export DB_CONNECTION='mysql'
    fi
    if [ -z "${DB_HOST}" ]; then
        export DB_HOST='127.0.0.1'
    fi
    if [ -z "${DB_PORT}" ]; then
        export DB_PORT='3306'
    fi
    if [ -z "${DB_DATABASE}" ]; then
        export DB_DATABASE='pixelfed'
    fi

    # wait for database
    if [ "$DB_CONNECTION" == "mysql" ]; then
      while ! mysqladmin --host="$DB_HOST" --port="$DB_PORT" --user="$DB_USERNAME" --password="$DB_PASSWORD" ping; do
        echo "Waiting for $DB_CONNECTION database..."
        sleep 5
      done
    elif [ "$DB_CONNECTION" == "pgsql" ]; then
      echo "Using $DB_CONNECTION database"
      # to be done
    elif [ "$DB_CONNECTION" == "sqlite" ]; then
      echo "Using $DB_CONNECTION database"
      # nothing to do
    else
      echo "ERROR: Invalid database type $DB_CONNECTION"
      exit 128
    fi
    echo "Database ready..."
}

function initialize() {
    if [ -n "$TZ" ]; then
      echo "Setting timezone to $TZ"
      echo "$TZ" > /etc/TZ
      ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime
    else
      echo "Timezone is set to $(cat /etc/TZ)"
    fi

    if [ ! -f "storage/app/cities.json" ]; then
        echo "Copy storage template..."
        cp -a storage.tpl/* storage/
    fi

    touch /home/project/pixelfed/.env
    chown -R project:project /home/project/pixelfed/storage

    echo "Storage..."
    su -c "php artisan storage:link" project

    echo "Database..."
    su -c "php artisan migrate --force" project
    su -c "php artisan update" project

    echo "Enable horizon..."
    su -c "php artisan horizon:install" project

    if [ ! -f "storage/oauth-private.key" ]; then
        echo "Creating oauth keys..."
        su -c "php artisan passport:keys" project
        if [ ! "$SKIP_CITIES_IMPORT" == "y" ]; then
          echo "Importing cities..."
          su -c "php artisan import:cities" project
        fi
    fi

    echo "Cache warmup..."
    su -c "php artisan config:cache" project
    su -c "php artisan route:cache" project
    su -c "php artisan view:cache" project

    echo "Pixelfed ${PIXELFED} ready..."
}

case "${1-}" in
    'bash')
        exec /bin/bash;
        ;;
    'web')
        waitdb
        initialize
        exec supervisord;
        ;;
    'worker')
        initialize
        rm /etc/supervisor/conf.d/nginx.conf
        rm /etc/supervisor/conf.d/nginx.conf
        exec supervisord;
        ;;
    *)
        exec /bin/sh -c "$@";
        ;;
esac
