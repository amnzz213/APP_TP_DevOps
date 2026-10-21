#!/bin/bash

MONGO_CONTAINER=$(sudo docker ps --filter "ancestor=mongo:7" --format "{{ .Names }}")

if [ "$(sudo docker inspect -f '{{.State.Running }}' "$MONGO_CONTAINER")" = "true" ]; then
    sudo docker exec "$MONGO_CONTAINER" mongodump --archive=/tmp/mongo_archive

    if sudo docker cp "$MONGO_CONTAINER":/tmp/mongo_archive ./mongo_archive; then
        sudo docker compose stop
        if sudo docker compose ps --filter "status=running" -q | wc -l; then
            echo "Shutdown : OK"
        else 
            echo "Shutwon : NOK"
        fi 
    else
        echo "Failed to retrieve the data of mongo"
    fi

else 
    echo "Mongo container is exited"
fi



