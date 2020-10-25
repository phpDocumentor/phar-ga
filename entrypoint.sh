#!/bin/sh -l

COMMAND=$(echo "${*}" | cut -c 5-)
if [ "$1" = 'box' ]; then
    sh -c "/opt/phpdoc/vendor/bin/box ${COMMAND}"
elif [ "$1" = 'gpg' ]; then
    echo "$SECRET_KEY" > keys.asc
    echo "prepare import keys"
    gpg --batch --yes --import keys.asc
    sh -c "echo $PASSPHRASE | gpg ${COMMAND}"
elif [ "$1" = 'php' ]; then
    sh -c "php ${COMMAND}"
fi
