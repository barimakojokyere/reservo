#!/bin/bash

action=$1

export POSTGRES_DB="rsvodb"
export POSTGRES_USER="rsvodbadmin"
export POSTGRES_PASSWORD="changeme"

if [[ $action == "create" ]]; then
    # Pulls down and creates images and starts containers

    # Pull postgres image
    docker pull postgres

    # Build backend go binary
    go build -o ./dev/rsvosrc/reservo ./dev/rsvosrc/main.go

    # Build backend image
    docker build --no-cache -t rsvobackend ./dev/rsvosrc

    # Build UI image
    docker build --no-cache -t rsvogui ./dev/rsvogui

    # Bring up containers
    docker compose -f ./docker-compose.yml up -d

    # Clean up
    rm -rf ./dev/rsvosrc/reservo

elif [[ $action == "spin-up" ]]; then
    # Images already pulled down and created so start containers
    docker compose -f ./docker-compose.yml up -d
elif [[ $action == "tear-down" ]]; then
    # Tear down containers
    docker compose -f ./docker-compose.yml down

    # Remove images
    docker rmi -f $(docker images -aq)

    # Remove any cache
    echo "y" | docker system prune
fi