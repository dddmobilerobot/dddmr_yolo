#!/bin/bash

xhost +local:docker

TARGET_IMAGE="dddmr:yolo"
TARGET_IMAGE_L4T="dddmr:yolo_l4t_r36"

# Query docker directly using the reference filter
if [ -n "$(docker images -q --filter "reference=${TARGET_IMAGE}")" ]; then
    echo "Image '${TARGET_IMAGE}' found."
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
elif [ -n "$(docker images -q --filter "reference=${TARGET_IMAGE_L4T}")" ]; then
    echo "Image '${TARGET_IMAGE_L4T}' found."
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
fi

