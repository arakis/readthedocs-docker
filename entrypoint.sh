#!/bin/sh

PYTHON=python3.6
set -e

cd /home/docs/readthedocs.org

UID=$(id -u);
GID=$(id -g);

if [ ! -f /data/database/dev.db ]; then
    echo "Try to popuplate direcotry /data"
    echo "If you mapped this direcotry, ensure it's owned by $UID:$GID (UID=$UID, GID=$GID)"

    mkdir /data/media
    mkdir /data/media/json
    mkdir /data/media/htmlzip
    mkdir /data/media/pdf
    mkdir /data/media/epub
    mkdir /data/database
    mkdir /data/public_web_root
    mkdir /data/user_builds

    $PYTHON  manage.py migrate
    $PYTHON manage.py collectstatic
    $PYTHON manage.py loaddata test_data
    $PYTHON manage.py shell < django-rtd-create-users.py

else
    $PYTHON  manage.py migrate
fi

$PYTHON manage.py runserver 0.0.0.0:8000
