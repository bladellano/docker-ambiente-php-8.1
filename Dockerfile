FROM php:8.1-apache
RUN apt-get update && apt-get install -y \
		  ruby-dev \
      rubygems \
      imagemagick \
      graphviz \
      memcached \
      libmemcached-tools \
      libmemcached-dev \
      libjpeg62-turbo-dev \
      libmcrypt-dev \
      libxml2-dev \
      libxslt1-dev \
      default-mysql-client \
      sudo \
      git \
      vim \
      zip \
      wget \
      htop \
      iputils-ping \
      dnsutils \
      linux-libc-dev \
      libyaml-dev \
      libpng-dev \
      zlib1g-dev \
      libzip-dev \
      libicu-dev \
      libpq-dev \
      bash-completion \
      libldap2-dev \
      libssl-dev \
      libonig-dev \
	&& docker-php-ext-configure gd --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd

RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev \
        && docker-php-ext-install zip

# Install php extensions + added mysqli install
RUN docker-php-ext-install opcache pdo pdo_mysql && docker-php-ext-install mysqli

# Installation of Composer
RUN cd /usr/src && curl -sS http://getcomposer.org/installer | php
RUN cd /usr/src && mv composer.phar /usr/bin/composer

# Installation of drush 8 & 9
RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
RUN cp -r /usr/local/src/drush/ /usr/local/src/drush8/
RUN cp -r /usr/local/src/drush/ /usr/local/src/drush9/
RUN cd /usr/local/src/drush8 && git checkout -f 8.1.0
RUN cd /usr/local/src/drush8 && composer update && composer install
RUN ln -s /usr/local/src/drush8/drush /usr/bin/drush8
RUN cd /usr/local/src/drush9 && git checkout 9.1.0
RUN cd /usr/local/src/drush9 && composer update && composer install
RUN ln -s /usr/local/src/drush9/drush /usr/bin/drush9

# Custom Opcache
RUN ( \
  echo "opcache.memory_consumption=128"; \
  echo "opcache.interned_strings_buffer=8"; \
  echo "opcache.max_accelerated_files=20000"; \
  echo "opcache.revalidate_freq=5"; \
  echo "opcache.fast_shutdown=1"; \
  echo "opcache.enable_cli=1"; \
  ) >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
# RUN apt-get update
# RUN apt-get install -y git libzip-dev zip unzip npm
# RUN docker-php-ext-install pdo pdo_mysql zip
RUN a2enmod rewrite



