#!/bin/bash

if [ "$(sudo docker inspect -f '{{.State.Running }}' app_tp_devops-tp-mongo-1)" = "true" ]; then
    sudo docker exec app_tp_devops-tp-mongo-1 mongodump --archive=/tmp/mongo_archive
    sudo docker cp app_tp_devops-tp-mongo-1:/tmp/mongo_archive ./mongo_archive

    if [ $? ]; then
        sudo docker compose stop
        if [ $(sudo docker compose ps --status running | tail -n +2 | wc -l ) -eq 0 ]; then
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



