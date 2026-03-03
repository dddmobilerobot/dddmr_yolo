from ultralytics import YOLO
import shutil

# Load a model
model = YOLO("yolo11n-seg.yaml")  # build a new model from YAML
model = YOLO("yolo11n-seg.pt")  # load a pretrained model (recommended for training)
model = YOLO("yolo11n-seg.yaml").load("yolo11n-seg.pt")  # build from YAML and transfer weights

# Train the model
results = model.train(data="data.yaml", epochs=100, imgsz=640)
model.fuse()
model.info(verbose=False)  # Print model information

# export opset12 for anylabeling

exported_model_path = model.export(format="onnx", simplify=True)
new_name = exported_model_path.split("best.onnx")[0]
try:
    shutil.copyfile(exported_model_path, new_name+"best_opset22.onnx")
except FileNotFoundError:
    print(f"Error: Source file '{exported_model_path}' not found.")
except Exception as e:
    print(f"An error occurred: {e}")

exported_model_path = model.export(format="onnx", simplify=True, opset=12)
new_name = exported_model_path.split("best.onnx")[0]
try:
    shutil.copyfile(exported_model_path, new_name+"best_opset12.onnx")
except FileNotFoundError:
    print(f"Error: Source file '{exported_model_path}' not found.")
except Exception as e:
    print(f"An error occurred: {e}")