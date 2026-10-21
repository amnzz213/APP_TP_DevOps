#!/bin/bash

if sudo docker compose up -d --wait --wait-timeout=60; then
    if sudo docker cp ./mongo_archive app_tp_devops-tp-mongo-1:/tmp/mongo_archive; then
        if sudo docker exec app_tp_devops-tp-mongo-1 mongorestore --archive=/tmp/mongo_archive; then
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

