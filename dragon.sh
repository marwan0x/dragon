#!/bin/bash

create_new_dragon(){
    docker run \
        --rm --tty --interactive \
        --net=host --dns='8.8.8.8' --name dragon --hostname dragon \
        --cap-add=NET_ADMIN --device=/dev/net/tun \
        -v ~/Dragon:/Dragon \
        -v ~/Projects/dragon/.zshrc:/home/w1nt3r/.zshrc:ro \
        -v ~/ObsidianNetwork:/ObsidianNetwork \
        -v ~/.config/nvim:/home/w1nt3r/.config/nvim \
        -v ~/.local/share/nvim:/home/w1nt3r/.local/share/nvim \
        -v ~/.local/state/nvim:/home/w1nt3r/.local/state/nvim \
        -v ~/.cache/nvim:/home/w1nt3r/.cache/nvim \
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
