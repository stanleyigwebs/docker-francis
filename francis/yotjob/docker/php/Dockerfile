#https://github.com/emad-zaamout/laravel-docker-aws-deployment-course-start/blob/main/Dockerfile

# Used for production build.
FROM php:8.3-fpm

# Install dependencies.
RUN apt-get update && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx libonig-dev

# Install Node.js
RUN apt-get update && apt-get install -y curl gnupg && curl -sL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

#Install dependencies for optimizing image
#https://github.com/spatie/image-optimizer#optimization-tools
RUN apt-get update && apt-get install -y jpegoptim optipng pngquant gifsicle webp
# Install SVGO globally using npm
RUN npm install -g svgo

# Install PHP extensions.
#pcntl is important for job timeout: https://laravel.com/docs/11.x/queues#timeout
RUN docker-php-ext-install mysqli pdo pdo_mysql bcmath curl mbstring opcache pcntl

#Install Redis
#https://github.com/laradock/laradock/blob/505130302703a85415cfb011ed320eddd88c92e4/php-fpm/Dockerfile#L300
RUN pecl install -o -f redis && rm -rf /tmp/pear && docker-php-ext-enable redis

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy composer executable.
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

ARG APP_ENV=local

COPY scripts /scripts
COPY configurations /configurations

# Change permissions on all scripts to make them executable
RUN chmod +x /scripts/*

RUN /bin/bash -c '/scripts/configuration.sh'

# Set working directory to /var/www/html.
WORKDIR /var/www/html

# Copy existing application directory permissions
COPY --chown=www-data:www-data . .

# Adjust user permission & group
RUN usermod --uid 1000 www-data
RUN groupmod --gid 1001 www-data

# Change current user to www-data
USER www-data

# Start php-fpm server
CMD ["php-fpm"]

# Port 9000 is for fpm upstream
EXPOSE 9000
