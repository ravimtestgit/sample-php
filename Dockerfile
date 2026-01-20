# 1. Match the PHP version requested in composer.json
FROM php:8.4-apache

# 2. Configure Apache for App Runner
RUN sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# 3. Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html/
COPY . /var/www/html/

# 5. Fix "Dubious Ownership" and install dependencies
RUN git config --global --add safe.directory /var/www/html && \
    composer install --no-dev --optimize-autoloader

# 6. Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 8080
