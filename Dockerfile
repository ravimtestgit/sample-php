FROM php:8.2-apache

# 1. App Runner listens on 8080 by default; configure Apache to match
RUN sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# 2. Install system dependencies needed for Composer
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. Install Composer (using the official image as a shortcut)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Set working directory and copy app files
WORKDIR /var/www/html/
COPY . /var/www/html/

# 5. Run Composer to install dependencies (Fixes the "Fatal Error")
# We use --no-dev for a smaller, production-ready image
RUN composer install --no-dev --optimize-autoloader

# 6. Set correct permissions for Apache
RUN chown -R www-data:www-data /var/www/html

EXPOSE 8080
