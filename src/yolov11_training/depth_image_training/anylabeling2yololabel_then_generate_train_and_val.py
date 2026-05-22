import os
import json
import yaml

try:
    with open('data.yaml', 'r') as file:
        lable_config = yaml.safe_load(file)

except FileNotFoundError:
    print("Error: 'data.yaml' not found.")
except yaml.YAMLError as e:
    print(f"Error parsing YAML file: {e}")

label_config_dict = {}
for i in lable_config["names"]:
    label_config_dict.update({lable_config["names"][i]:i})

def list_files_in_directory(path='.'):
    """Lists all files in the specified directory."""
    files = []
    for entry in os.listdir(path):
        full_path = os.path.join(path, entry)
        if os.path.isfile(full_path):
            files.append(entry)
    return files

target_dir = 'selected_rgb'
specific_directory_files = list_files_in_directory(target_dir+'_from_anylabeling')

json_files = []
for i in specific_directory_files:
    if(".json" in i):
        json_files.append(i)
        
#print(f"Files in current directory: {json_files}")

for i in json_files:
    with open(target_dir+'_from_anylabeling'+"/"+i, 'r') as file:
        # Load the JSON data from the file
        data = json.load(file)
        print("Processing file: %s" % i)
    
    json_name = i.split(".")
    write_file = False
    with open(target_dir+"_yolo_label/"+json_name[0]+".txt", "w") as file:
        for index,i in enumerate(data['shapes']):
            #check label number
            try:
                to_be_write = str(label_config_dict[i["label"]])
                to_be_write += " "
                shapes_dict = i
                for a_pt in shapes_dict['points']:
                    x_nor = a_pt[0]/data['imageWidth']
                    y_nor = a_pt[1]/data['imageHeight']
                    to_be_write = to_be_write + " " + str(x_nor)
                    to_be_write = to_be_write + " " + str(y_nor)
                file.write(to_be_write+"\n")
                write_file = True
            except:
                continue
    
    filename = target_dir+"_yolo_label/"+json_name[0]+".txt"
    if (not write_file and os.path.exists(filename)):
        try:
            os.remove(filename)
            print(f"Empty file '{filename}' has been deleted successfully.")
        except PermissionError:
            print(f"Permission denied: unable to delete the file '{filename}'.")
        except Exception as e:
            print(f"Error occurred while deleting the file: {e}")

import random
import shutil
# generae train and val
yolo_lable_directory_files = list_files_in_directory(target_dir+'_yolo_label')
random_sample = random.sample(yolo_lable_directory_files, int(len(yolo_lable_directory_files)*0.9))
for i in yolo_lable_directory_files:
    image_name = i.split(".")[0]
    
    # in random sample, push to train
    if(i in random_sample):
        try:
            shutil.copyfile(target_dir+'_from_anylabeling'+"/"+image_name+".png", "train/images/"+image_name+".png")
            shutil.copyfile(target_dir+'_yolo_label'+"/"+image_name+".txt", "train/labels/"+image_name+".txt")
        except FileNotFoundError:
            print(f"Error: Source file '{image_name}' not found.")
        except Exception as e:
            print(f"An error occurred: {e}")
    else:
        try:
            shutil.copyfile(target_dir+'_from_anylabeling'+"/"+image_name+".png", "val/images/"+image_name+".png")
            shutil.copyfile(target_dir+'_yolo_label'+"/"+image_name+".txt", "val/labels/"+image_name+".txt")
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
