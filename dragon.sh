#!/bin/bash

create_new_dragon(){
    docker run \
        --rm --privileged --tty --interactive \
        --net=host --name dragon --hostname dragon \
        -v ~/Dragon:/Dragon \
        -v ~/Projects/dragon/.zshrc:/root/.zshrc \
        dragon:latest
}

is_dragon_alive(){
    if docker container ls | grep -q "dragon"; then
        return 0
    else
        return 1
    fi
}

ride_existing_dragon(){
    docker exec -it dragon zsh
}

if is_dragon_alive; then
    ride_existing_dragon
else
    create_new_dragon
fi
