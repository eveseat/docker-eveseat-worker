#!/bin/sh
set -e

# Wait for the database
while ! mysqladmin ping -h${DB_HOST} --silent; do

    echo "MariaDB container might not be ready yet... sleeping..."
    sleep 10
done

# Ensure we have vendor/ ready.
while [ ! -f /var/www/seat/vendor/autoload.php ]
do
    echo "SeAT code volume might not be ready yet... sleeping..."
    sleep 10
done

su www-data -s /bin/sh -c 'php /var/www/seat/artisan horizon'
