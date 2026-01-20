FROM php:8.2-apache

# App Runner listens on 8080 by default; let's configure Apache to match
RUN sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# Copy the index.php and composer files from the DigitalOcean repo
COPY . /var/www/html/

# Optional: If the app has dependencies, install them (the DO repo has a composer.json)
# RUN apt-get update && apt-get install -y unzip && \
#     curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
#     composer install

EXPOSE 8080
