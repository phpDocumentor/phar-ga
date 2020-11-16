FROM composer:2.0.6 AS composer

FROM php:7.4-alpine

COPY . /opt/phpdoc
WORKDIR /opt/phpdoc

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN composer install
RUN apk add --no-cache git gnupg ncurses

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
