FROM php:8.0-apache
#ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    mariadb-client \
    libpng-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    dos2unix \
    supervisor



ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions  intl


RUN apt-get clean && rm -rf /var/lib/apt/lists/*
#RUN docker-php-ext-install intl

#RUN docker-php-ext-install mbstring pdo pdo_mysql \ 
#   && a2enmod rewrite  \
#  && docker-php-ext-install intl

RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod proxy

RUN service apache2 restart

#RUN docker-php-ext-install intl
COPY --chown=www-data:www-data . /var/www/html/ 
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf 

WORKDIR /var/www/html
EXPOSE 443
