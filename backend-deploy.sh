# This will be copied into a process, so there is no need to specify this [#!/bin/bash]

cd "projects/$PROJECT_NAME/backend"

restart_php_fpm_service(){
    SERVICE_NAME=$1

    #Restart is done for opcache to clear cache
    #Restarting the container with |docker restart $CONTAINER_NAME| is another way, but i think this is more efficient
    docker compose exec $SERVICE_NAME /bin/bash -c "\
    kill -USR2 1 2>&1; if [ \$? -eq 0 ]; then echo '$SERVICE_NAME restart successful'; else echo '$SERVICE_NAME restart failed'; fi"
}

PHP_SERVICE="php"
CRON_SERVICE="cron"

#Gracefully stop the cron service
#Interrupt is for subminute tasks: https://laravel.com/docs/11.x/scheduling#interrupting-sub-minute-tasks
docker compose exec $CRON_SERVICE /bin/bash -c "\
php artisan schedule:interrupt && \
php artisan queue:restart"

docker compose down $CRON_SERVICE

#Make code changes reflect
restart_php_fpm_service $PHP_SERVICE

docker compose exec $PHP_SERVICE /bin/bash -c "\
php artisan optimize && \
php artisan pulse:restart"

# Run migrations if necessary, which includes maintenance mode handling
if [ "$DATABASE_MIGRATIONS_CHANGED" = "true" ]; then
docker compose exec $PHP_SERVICE php artisan migrate:fresh --seed --force
fi

# Start the cron service
docker compose up -d $CRON_SERVICE