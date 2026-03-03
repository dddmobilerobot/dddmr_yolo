#!/bin/bash
rm -rf selected_rgb_from_anylabeling
mkdir -p selected_rgb_from_anylabeling
python3 pick_label_and_image.py
rm -rf train
rm -rf val
mkdir -p train/labels
mkdir -p train/images
mkdir -p val/labels
mkdir -p val/images
rm -rf selected_rgb_yolo_label
mkdir selected_rgb_yolo_label
python3 anylabeling2yololabel_then_generate_train_and_val.py
python3 yolo_train.py

