echo -n "Do you want to download depth images from Robosense Airy files (178MB)? (Y/N):"
read d_depth
if [ "$d_depth" != "${d_depth#[Yy]}" ] ;then 
  echo "Download .zip"
  cd curl -L -c cookies.txt 'https://drive.usercontent.google.com/uc?export=download&id='1ggOBtTbLaMyYnpheVm6Q2hbPNE5PVukJ \
      | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p' > confirm.txt
  curl -L -b cookies.txt -o airy_depth_image.zip \
      'https://drive.usercontent.google.com/download?id='1ggOBtTbLaMyYnpheVm6Q2hbPNE5PVukJ'&confirm='$(<confirm.txt)
  rm -f confirm.txt cookies.txt
  unzip airy_depth_image.zip
fi