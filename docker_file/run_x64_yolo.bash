#!/bin/bash

xhost +local:docker

is_yolo=$(docker image ls dddmr | grep yolo | cut -c14-17)
is_yolo_l4t_r36=$(docker image ls dddmr | grep yolo_l4t_r36 | cut -c7-18)

if [[ $is_yolo_l4t_r36 == "yolo_l4t_r36" ]]; then
    echo "Detect image of dddmr:"$is_yolo_l4t_r36
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
        --name="dddmr_yolo_train2onnx" \
        dddmr:yolo_l4t_r36

elif [[ $is_yolo == "yolo" ]]; then
    echo "Detect image of dddmr:"$is_yolo
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
        --name="dddmr_yolo_train2onnx" \
        dddmr:yolo
fi
