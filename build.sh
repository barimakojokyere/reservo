#!/bin/bash

action=$1

export POSTGRES_DB="rsvodb"
export POSTGRES_USER="rsvodbadmin"
export POSTGRES_PASSWORD="changeme"

if [[ $action == "create" ]]; then
    # Pulls down and creates images and starts containers

    # Pull postgres image
    docker pull postgres

    # Build UI image
    docker build --no-cache -t rsvogui ./dev/rsvogui

    # Bring up containers
    docker compose -f ./docker-compose.yml up -d
elif [[ $action == "spin-up" ]]; then
    # Images already pulled down and created so start containers
    docker compose -f ./docker-compose.yml up -d
elif [[ $action == "tear-down" ]]; then
    # Tear down containers
    docker compose -f ./docker-compose.yml down
fi