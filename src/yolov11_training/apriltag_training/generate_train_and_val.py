import os
import json
import yaml
import random
import shutil

def list_files_in_directory(path='.'):
    """Lists all files in the specified directory."""
    files = []
    for entry in os.listdir(path):
        full_path = os.path.join(path, entry)
        if os.path.isfile(full_path):
            files.append(entry)
    return files


target_dir_list = [
'apriltag_record_dataset/apriltag_36h11_0_146mm',
'apriltag_record_dataset/apriltag_36h11_0_146mm',
]

for target_dir in target_dir_list:
    yolo_lable_directory_files = list_files_in_directory(target_dir)
    #collect image name only
    yolo_lable_directory_files_only_images = []
    for i in yolo_lable_directory_files:
        image_name = i.split(".")[0]
        if(i.split(".")[1] == "png"):
            yolo_lable_directory_files_only_images.append(i)

    random_sample = random.sample(yolo_lable_directory_files_only_images, int(len(yolo_lable_directory_files_only_images)*0.9))

    for i in yolo_lable_directory_files_only_images:
        image_name = i.split(".")[0]
        # in random sample, push to train
        if(i in random_sample):
            try:
                shutil.copyfile(target_dir+"/"+image_name+".png", "train/images/"+image_name+".png")
                shutil.copyfile(target_dir+"/"+image_name+".txt", "train/labels/"+image_name+".txt")
            except FileNotFoundError:
                print(f"Error: Source file '{image_name}' not found.")
            except Exception as e:
                print(f"An error occurred: {e}")
        else:
            try:
                shutil.copyfile(target_dir+"/"+image_name+".png", "val/images/"+image_name+".png")
                shutil.copyfile(target_dir+"/"+image_name+".txt", "val/labels/"+image_name+".txt")
            except FileNotFoundError:
                print(f"Error: Source file '{image_name}' not found.")
            except Exception as e:
                print(f"An error occurred: {e}")   
'''
# Example Usage:
x_min_val, y_min_val, x_max_val, y_max_val = 100, 50, 300, 250
img_w, img_h = 640, 480

normalized_coords = normalize_to_yolo(x_min_val, y_min_val, x_max_val, y_max_val, img_w, img_h)
print(f"Normalized YOLO coordinates: {normalized_coords}")
'''
