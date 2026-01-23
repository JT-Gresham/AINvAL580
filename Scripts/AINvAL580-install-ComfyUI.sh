#!/usr/bin/env bash

source /etc/AINvAL580/AINvAL580_path
source $AINvAL580dir/libref
source $AINvAL580dir/AINvAL580_env/bin/activate
ainvalpkg="ComfyUI"
ainvalpkgURL="https://github.com/comfyanonymous//$ainvalpkg.git"

echo "########## $ainvalpkg for Intel Arc GPUs on Arch Linux ##########"
echo "##################### framework by JT Gresham #####################"
echo ""
echo "*     This installer requires that you have up-to-date drivers for your Intel Arc GPU."
echo "*     This installer requires that you have the AINvAL580 already installed."
echo "*     This installer will create a customized start script by using the information you enter."
echo ""
echo "Press enter to continue the installation..."
read go
echo "Your installation will be installed in $AINvAL580dir/$ainvalpkg"
echo ""
AINvAL580_update
echo "Changing directory ->$AINvAL580dir/$ainvalpkg"
cd $AINvAL580dir/$ainvalpkg
echo ""
echo "Cloning official $ainvalpkg repository to $ainvalpkg"

#### GIT CLONE COMMAND  URL HERE ####
git clone "$ainvalpkgURL" "/tmp/$ainvalpkg"
mv -f "/tmp/$ainvalpkg/.git" "$AINvAL580dir/$ainvalpkg/"
mv -f "/tmp/$ainvalpkg/sdxl_styles/"* "$AINvAL580dir/shared1/sdxl_styles/"
cd $AINvAL580dir/$ainvalpkg
git checkout .
rm -r /tmp/$ainvalpkg
source $AINvAL580dir/$ainvalpkg/libref-$ainvalpkg
echo ""
echo "Applying AINvAL580 modifications to original $ainvalpkg..."
AINvAL580_update_$ainvalpkg
cp $AINvAL580dir/$ainvalpkg/user_customize_$ainvalpkg_example.sh $AINvAL580dir/$ainvalpkg/user_customize_$ainvalpkg.sh
echo ""
echo "Installing packages from requirements.txt..."
cd $AINvAL580dir/$ainvalpkg
sleep 1
AINvAL580 update AINvAL
AINvAL580 update Torch
pip install -r requirements.txt
pip install -r requirements_$ainvalpkg.txt
echo ""
echo "Creating the launcher file ($ainvalpkg-Start.sh)"
cp "user_customize_"$ainvalpkg"_example.sh" "user_customize_"$ainvalpkg".sh"
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager
cd ..
touch $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "#!/usr/bin/env bash" > $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "source /etc/AINvAL580/AINvAL580_path" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "source $AINvAL580dir/libref" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "source $AINvAL580dir/$ainvalpkg/libref-$ainvalpkg" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "source $AINvAL580dir/AINvAL580_env/bin/activate" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "AINvAL580_update" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh

#### Executable below
echo "AINvAL580_update_$ainvalpkg" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "# DEFAULT Executable" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "python $AINvAL580dir/$ainvalpkg/main.py --port 7865 \"\$@\"" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "#python $AINvAL580dir/$ainvalpkg/main.py --use-split-cross-attention --async-offload --port 7865 \"\$@\"" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "#python /home/LACII14/Archive-M1/AI/AINvAL580/ComfyUI/main.py --novram --bf16-unet --cpu-vae --use-split-cross-attention --disable-smart-memory --async-offload --oneapi-device-selector level_zero:gpu --port 7865 "$@"
" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh

echo "sleep 60"
#echo "echo "ComfyUI is still running in the background. Enter command: ComfyUI-exit to close down ComfyUI.""
#echo "" >> $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh
echo "Creating executable link in /usr/bin --> AINvAL580-$ainvalpkg"
sudo ln -sf "$AINvAL580dir/$ainvalpkg/$ainvalpkg-Start.sh" "/usr/bin/AINvAL580-$ainvalpkg"
echo "Installation complete. Start with command: AINvAL580-$ainvalpkg with any ComfyUI arguments afterward"
echo "--Press any key to exit installer--"
read go
exit 0
