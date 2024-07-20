#https://github.com/aschmelyun/laravel-scheduled-tasks-docker/blob/master/cron.dockerfile

FROM php:8.3-fpm-alpine

# Install cron
#The alpine image comes with this directly, so we comment this out and cron will still run
#RUN apk --no-cache add cron

RUN docker-php-ext-install pdo pdo_mysql bcmath

#The location where you add scheduling commands varies based on the Linux distribution used in your Docker image. Since we're using an Alpine Linux-based image, we'll directly insert the scheduling command into the /etc/crontabs/root file. If you chose to use the Debian-based variant, instead, then the process is a bit different. Create a separate crontab file with your scheduling command and place that file in the /etc/cron.d folder to schedule tasks.

COPY crontab /etc/crontabs/root

CMD ["crond", "-f"]
