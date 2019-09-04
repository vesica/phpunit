#!/bin/bash
cd /app
composer install
baseUri=$baseUri phpunit $@
