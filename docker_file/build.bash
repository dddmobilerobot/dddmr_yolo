#!/bin/bash

function build_x64(){
    docker build --network host -t dddmr:x64 -f Dockerfile_x64 .
}

#-----select image
echo -n "Select image type (x64_cuda/l4t): "
read image_type

if [[ $image_type == "x64_cuda" ]]; then
 
    docker build --network host -t dddmr:yolo -f Dockerfile_yolo .
    docker build --network host -t dddmr:anylabeling -f Dockerfile_anylabeling .

elif [[ $image_type == "l4t" ]]; then
    echo "----> Creating l4t image"
    docker build --network host -t dddmr:l4t_r36 -f Dockerfile_x64_l4t_r36 .
    docker build --network host -t dddmr:yolo_l4t_r36 -f Dockerfile_yolo_l4t_r36 .
    docker build --network host -t dddmr:anylabeling_l4t_r36 -f Dockerfile_anylabeling_l4t_r36 .
else
    echo "Invalid image type. Please choose x64/l4t"
fi

