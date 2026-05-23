#!/bin/bash
rm -rf train
rm -rf val
mkdir -p train/labels
mkdir -p train/images
mkdir -p val/labels
mkdir -p val/images
python3 generate_train_and_val.py
python3 yolo_train.py

