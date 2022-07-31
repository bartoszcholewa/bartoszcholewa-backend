#!/bin/bash

SUPERUSER_EMAIL=${DJANGO_SUPERUSER_EMAIL:-"root@root.pl"}
# shellcheck disable=SC2164
cd /app/

python manage.py migrate --noinput
