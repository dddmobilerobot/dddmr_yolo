#!/bin/bash

xhost +local:docker

is_cuda=$(docker image ls dddmr | grep anylabeling | cut -c14-24)
is_l4t_r36=$(docker image ls dddmr | grep anylabeling_l4t_r36 | cut -c7-25)

if [[ $is_l4t_r36 == "anylabeling_l4t_r36" ]] ;then
    echo "Detect image of dddmr:anylabeling_l4t_r36"
    docker run -it \
        --privileged \
        --network=host \
        --runtime=nvidia \
        --env="NVIDIA_VISIBLE_DEVICES=all"\
        --env="NVIDIA_DRIVER_CAPABILITIES=all"\
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp:/tmp" \
        --volume="/dev:/dev" \
        --volume="${HOME}/dddmr_bags:/root/dddmr_bags" \
        --volume="${HOME}/dddmr_yolo:/root/dddmr_yolo" \
        --name="dddmr_anylabeling_l4t_r36" \
        dddmr:anylabeling_l4t_r36
        
elif [[ $is_cuda == "anylabeling" ]]; then
    echo "Detect image of dddmr:"$is_cuda
    docker run -it \
        --privileged \
        --network=host \
        --gpus=all \
        --env="NVIDIA_VISIBLE_DEVICES=all"\
        --env="NVIDIA_DRIVER_CAPABILITIES=all"\
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp:/tmp" \
        --volume="/dev:/dev" \
        --volume="${HOME}/dddmr_bags:/root/dddmr_bags" \
        --volume="${HOME}/dddmr_yolo:/root/dddmr_yolo" \
        --name="dddmr_anylabeling" \
        dddmr:anylabeling
fi

