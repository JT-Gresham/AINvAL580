#!/usr/bin/env bash
source AINvAL580/libref
####  This file is for you to add any code you want to execute just before ComfyUI launches.  This will not be updated when AINvAL580 or ComfyUI updates.
####  This is useful if you want to create custom presets and make sure your code, links, etc gets put back after an official update from the ComfyUI team.
####  I'll include the code I wrote to load my own custom preset as an example.  I didn't wnat to do this every time the ComfyUI team updated...

####  THIS CODE STARTS IN YOUR PARENT DIRECTORY
####    eg: where the AINvAL580 directory is located

#### EXAMPLE CODE ####

#  Change directory to make things easier
#cd $pdirectory/AINvAL580

#  Copy files (without overwritting) from my custom preset directory (ComfyUI_Presets) I created in the AINvAL580 shared folder
#cp --no-clobber -R shared/presets/ComfyUI/* ComfyUI/presets/

#  Change into the ComfyUI directory for the next part.
#cd ComfyUI/modules

#   If you already have Fooocus installed in AINvAL580 then uncomment the below to tie in your custom styles and wildcards
#rm -r $pdirectory/AINvAL580/ComfyUI/custom_nodes/Fooocus_Nodes/sdxl_styles
#rm -r $pdirectory/AINvAL580/ComfyUI/custom_nodes/Fooocus_Nodes/wildcards
#ln -sf $pdirectory/shared/sdxl_styles/Fooocus/ $pdirectory/AINvAL580/ComfyUI/custom_nodes/Fooocus_Nodes/sdxl_styles
#ln -sf $pdirectory/shared/wildcards/ $pdirectory/AINvAL580/ComfyUI/custom_nodes/Fooocus_Nodes/wildcards

# If you already have OmniGen installed in AINvAL580 then uncomment the code below and install the OmniGen-ComfyUI by AFISH custom nodes in ComfyUI. This will tie in your existing installation. Make sure to get the right one since there's several packages available.
#rm -r $pdirectory/AINvAL580/ComfyUI/custom_nodes/OmniGen-ComfyUI/OmniGen
#ln -sf $pdirectory/AINvAL580/OmniGen/OmniGen/ $pdirectory/AINvAL580/ComfyUI/custom_nodes/OmniGen-ComfyUI/OmniGen
#### MODEL SPECIFIC - I have renamed my OmniGen model to OmniGen-v1.safetensors...you must change the name in the link below to match yours.
#ln -sf $pdirectory/AINvAL580/shared/LLMs/OmniGen/OmniGen-v1.safetensors $pdirectory/AINvAL580/ComfyUI/models/OmniGen/OmniGen-v1/model.safetensors

#### Creates a new output folder with today's date
#cd $pdirectory/AINvAL580/ComfyUI
#outputdir=$(echo $(date +%Y)"-"$(date +%m)"-"$(date +%d))
#mkdir -p "output/Remote/"$outputdir

# Clears the persistent input cache directory of any used uploaded images *privacy protection* - Done before the ComfyUI launches
#cd $pdirectory/AINvAL580
#cp ComfyUI/input/example.png /tmp/
#rm -r ComfyUI/input
#mkdir -p ComfyUI/input/3d
#cp /tmp/example.png ComfyUI/input/

# Tie RoopUL models to ComfyUI for the ComfyUI-FaceSwap package
#cd $pdirectory/AINvAL580
#rm -r $pdirectory/AINvAL580/ComfyUI/models/roop
#ln -sf $pdirectory/AINvAL580/shared/RoopUL/models/ $pdirectory/AINvAL580/ComfyUI/models/roop

# Fixes for ComfyUI-roop-node (not comfyui-roop) SEE: https://codeberg.org/Gourieff/comfyui-reactor-node
#pip install --upgrade albumentations==1.4.16 #fixes albucore requirement so nodes will load (Also allows ComfyUI-FaceSwap to load)
