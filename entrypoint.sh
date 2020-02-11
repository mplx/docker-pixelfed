#!/bin/bash

set +x
set -e
set -o errexit
set -o pipefail

echo "Pixelfed ${PIXELFED} entrypoint"

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
        echo "Importing cities..."
        su -c "php artisan import:cities" project
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
