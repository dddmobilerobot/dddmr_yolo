import os
import json
import yaml
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
'airy_45deg_labelled_dataset/one_people_0',
'airy_45deg_labelled_dataset/one_people_1',
'airy_45deg_labelled_dataset/one_people_2',
'airy_45deg_labelled_dataset/three_people_0',
'airy_45deg_labelled_dataset/two_people_0']

for j in target_dir_list:

    target_dir = j
    specific_directory_files = list_files_in_directory(target_dir)

    json_files = []
    for i in specific_directory_files:
        if(".json" in i):
            json_files.append(i)
            
    #print(f"Files in current directory: {json_files}")

    for i in json_files:
        
        image_name = i.split(".")[0]
        # in random sample, push to train
        try:
            shutil.copyfile(target_dir+"/"+image_name+".png", "selected_rgb_from_anylabeling/"+image_name+".png")
            shutil.copyfile(target_dir+"/"+i, "selected_rgb_from_anylabeling/"+i)
        except FileNotFoundError:
            print(f"Error: Source file '{image_name}' not found.")
        except Exception as e:
            print(f"An error occurred: {e}")



