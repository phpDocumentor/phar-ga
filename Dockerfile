FROM composer:2.0.9 AS composer

FROM php:8.0.7-alpine

COPY . /opt/phpdoc
WORKDIR /opt/phpdoc

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN composer install
RUN apk add --no-cache git gnupg ncurses

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
