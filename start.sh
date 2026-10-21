#!/bin/bash

if sudo docker compose up -d --wait --wait-timeout=60; then

    MONGO_CONTAINER=$(sudo docker ps -a --filter "ancestor=mongo:7" --format "{{ .Names }}")

    if sudo docker cp ./mongo_archive "$MONGO_CONTAINER":/tmp/mongo_archive; then
        if sudo docker exec "$MONGO_CONTAINER" mongorestore --archive=/tmp/mongo_archive; then
            echo "Restore successfull"
        else
            echo "Fail to restore"
        fi
    else 
        echo "Fail to copy the archive"
    fi
else 
    echo "Fail to start the containers"
fi

