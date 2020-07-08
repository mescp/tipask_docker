#!/bin/bash

touch .env && chmod 777 -R .env storage bootstrap/cache

if [[ $# -eq 0 ]]; then
    exec apache2-foreground
else
    exec "$@"
fi