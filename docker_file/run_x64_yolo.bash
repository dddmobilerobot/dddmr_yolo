#!/bin/bash

xhost +local:docker

LS_IMAGE=$(docker image ls dddmr)
YOLO='yolo'
YOLO_L4T='yolo_l4t_r36'

if echo "$LS_IMAGE" | grep -q "$YOLO_L4T"; then
    echo "Detect image of dddmr:"$YOLO_L4T
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

elif echo "$LS_IMAGE" | grep -q "$YOLO"; then
    echo "Detect image of dddmr:"$YOLO
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
