#!/usr/bin/env bash
AINvALuser="$(whoami)"

echo "########## AI Framework for Intel Arc GPUs on Arch Linux ##########"
echo "################### created by JT Gresham ####################"
echo ""
echo "*  This installer requires that you have up-to-date drivers for your Intel Arc GPU."
echo "*  You also need to have Python 3.12 installed since this installer creates your"
echo "       python virtual environment with it. It can be found in the AUR (python312)"
echo "*  This installer will check/install a couple of packages via PACMAN. These are installed"
echo "       from the offical Arch repositories so you will be asked to authorize the install with"
echo "       your password."
echo "*  Installing this framework will provide a more efficient installation of popular AI packages."
echo "   This installation will create custom launchers by using the information you enter here."
echo ""
echo "Press enter to continue the installation..."
read go
echo "AINvAL installer needs to check/install some PACMAN packages...Please authorize to continue..."
#sudo pacman -S --needed intel-compute-runtime intel-graphics-compiler ocl-icd opencl-headers level-zero-loader
wget git python-pipx 
echo ""
echo "--- Important Notes:"
echo "   * This directory can get pretty big in size as you add AI Software, LLMs, Checkpoints...etc!"
echo "   * Make sure you've got storage space to accomodate your future needs!"
echo "   * To avoid potential issues, the FULL PATH should not contain any spaces or special characters."
echo ""
echo "What is the FULL PATH of directory where you want to install \"AINvAL\"?"
echo "---IMPORTANT: Exclude the trailing \"/\"---"
read pdirectory
echo ""
echo "Your installation will be installed in $pdirectory/AINvAL"
echo ""
echo "Changing directory -> $pdirectory"
cd $pdirectory
echo ""
echo "Creating the AINvAL-update command..."
sudo echo "#!/usr/bin/env bash" > /usr/bin/AINvAL-update
sudo echo "" >> /usr/bin/AINvAL-update
sudo echo "source $pdirectory/AINvAL/AINvAL_env/bin/activate" >> /usr/bin/AINvAL-update
sudo echo "source $pdirectory/AINvAL/libref" >> /usr/bin/AINvAL-update
sudo echo "AINvAL_update" >> /usr/bin/AINvAL-update
sudo chmod +x /usr/bin/AINvAL-update
git clone https://github.com/JT-Gresham/AINvAL.git
echo ""
cd $pdirectory/AINvAL/Scripts
sudo mkdir /etc/AINvAL
sudo touch /etc/AINvAL/AINvAL_path
sudo chmod 777 /etc/AINvAL/AINvAL_path
echo "#!/usr/bin/env bash" > /etc/AINvAL/AINvAL_path
echo "" > /etc/AINvAL/AINvAL_path
echo "pdirectory=$pdirectory" > /etc/AINvAL/AINvAL_path
echo "AINvALdir=$pdirectory/AINvAL" >> /etc/AINvAL/AINvAL_path
source /etc/AINvAL/AINvAL_path
bash $pdirectory/AINvAL/Scripts/librefgen
echo "Changing directory ->$pdirectory/AINvAL"
cd $pdirectory/AINvAL
echo ""
echo "Creating python 3.12 environment (AINvAL_env)"
/usr/bin/python3.12 -m venv $pdirectory/AINvAL/AINvAL_env
echo ""
echo "Activating environment -> AINvAL_env"
source $pdirectory/AINvAL/AINvAL_env/bin/activate
echo "Installing pip..."
cd $pdirectory/AINvAL/Scripts
curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
cd $pdirectory/AINvAL
echo ""
echo "Installing wheel package..."
pip install wheel
echo ""
echo "Installing packages from requirements_AINvAL_nvidia.txt..."
pip install -r requirements_AINvAL580.txt
echo ""
#echo "Initializing the AINvAL command."
#ln -sf $pdirectory/AINvAL/Scripts/AINvAL $pdirectory/AINvAL/AINvAL_env/bin/AINvAL
#sudo ln -sf $pdirectory/AINvAL/AINvAL_env/bin/AINvAL /bin/AINvAL
#sudo chmod +x /bin/AINvAL
#sudo chmod +x $pdirectory/AINvAL/AINvAL_env/bin/AINvAL
echo "Creating initial \"Shared\" directory...replace with yours afterward, if necssary (symlink allowed)"
if [ ! -d "$pdirectory/AINvAL/Shared" ]; then
  mv ./shared1 ./shared
fi
echo "AINvAL framework is now installed. AI program installers are located in the \"Scripts\" directory."
echo "AINvAL is updated \(if necessary\) whenever a framework program is started, however..."
echo "   you can also use the command: \"AINvAL-update\" in your terminal to update AINvAL whenever you wish."
echo ""
echo "Thank you for trying out AINvAL...this is a lot of work."
echo ""
echo "Before you press a key to exit the installer, a small request:"
echo "   I'd appreciate it if you'd consider supporting my work by using one of the methods listed on the main github page. - OCD"
read go
#Run after git pull
