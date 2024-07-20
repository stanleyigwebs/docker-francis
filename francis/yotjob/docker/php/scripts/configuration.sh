#!/bin/bash

# Ensure script is running as root to change system configurations
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Navigate to the parent directory
cd "$SCRIPT_DIR/.."

# Copy base configuration files
cp "configurations/php.ini" /usr/local/etc/php/php.ini
cp "configurations/php-fpm.conf" /usr/local/etc/php-fpm.d/www.conf

# Add the appropriate configuration based on the environment
if [ "$APP_ENV" = "production" ]; then
    echo "Applying production configurations..."
    { echo; cat configurations/php-production.ini; } >> /usr/local/etc/php/php.ini
else
    echo "Applying development configurations..."
    { echo; cat configurations/php-development.ini; } >> /usr/local/etc/php/php.ini
fi

#for debugging purposes
#exit 1
