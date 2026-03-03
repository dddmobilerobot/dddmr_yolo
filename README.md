# dddmr_yolo
This package includes:

0. docker file to create a docker environment
1. Example depth image dataset from Robosense Airy
2. The labeled datset using anylabeling
3. A script to convert the json file to yolo-seg txt file - label2yolo_seg_label
4. The converted yolo label - selected_rgb_yolo_label
5. train and val folder is a subset from selected_rgb_from_anylabeling and selected_rgb_yolo_label
6. A training script that train the model using yolo11n-seg and export .pt to .onnx with image size 640 and batch 100

To sum up, this package is capable of training gray scale depth using yolo11 and export to onnx.

Next step is to convert onnx to tensorrt for the fast edge inference in Jetson Orin:

https://github.com/dfl-rlab/dddmr_navigation/blob/main/src/dddmr_lego_loam/lego_loam_bor/engine/onnx2trt.bash

The docker file includes the docker image that can run anylabeling.

## Create docker images
> [!NOTE]
> Anylabelling is not supported in l4t.

```
cd ~/dddmr_yolo/docker_file/
./build.bash
x64
```
## Download labelled data
```
cd ~/dddmr_yolo/src/yolov8_dataset/
./download_dataset.bash
```

## Labeling
```
./run_x64_anylabeling.bash
start_anylabeling
anylabeling
```
<p align='center'>
    <img src="https://github.com/dddmobilerobot/dddmr_documentation_materials/blob/main/dddmr_yolo/anylabeling.png" width="480" height="420"/>
</p>

## Training
Include directories (labelled by anylabeling) you want to train.
```
./run_x64_yolo.bash
cd dddmr_yolo/src/yolov8_dataset/
nano pick_label_and_image.py
```
Modify following line to include your own dataset or remove default dataset:

https://github.com/dddmobilerobot/dddmr_yolo/blob/cb7238b7631d27d89af0be6c836cc5820fab74ab/src/yolov8_dataset/pick_label_and_image.py#L17

Then simply train customized model by run:
```
./training.bash
```

## Weight
After training is done. You can find onnx file at:
> [!NOTE]
> train folder will be appended under segment folder as train1, train2, train3 depending on how many times you train, find your new onnx model in corresponding folder (usually the last one)

```
/root/dddmr_yolo/src/yolov8_dataset/runs/segment/train/weights
```
