#!/usr/bin/env bash
AINvAL580user="$(whoami)"

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
echo "AINvAL580 installer needs to check/install some PACMAN packages...Please authorize to continue..."
#sudo pacman -S --needed intel-compute-runtime intel-graphics-compiler ocl-icd opencl-headers level-zero-loader
wget git python-pipx 
echo ""
echo "--- Important Notes:"
echo "   * This directory can get pretty big in size as you add AI Software, LLMs, Checkpoints...etc!"
echo "   * Make sure you've got storage space to accomodate your future needs!"
echo "   * To avoid potential issues, the FULL PATH should not contain any spaces or special characters."
echo ""
echo "What is the FULL PATH of directory where you want to install \"AINvAL580\"?"
echo "---IMPORTANT: Exclude the trailing \"/\"---"
read pdirectory
echo ""
echo "Your installation will be installed in $pdirectory/AINvAL580"
echo ""
echo "Changing directory -> $pdirectory"
cd $pdirectory
echo ""
echo "Creating the AINvAL580-update command..."
sudo echo "#!/usr/bin/env bash" > /usr/bin/AINvAL580-update
sudo echo "" >> /usr/bin/AINvAL580-update
sudo echo "source $pdirectory/AINvAL580/AINvAL580_env/bin/activate" >> /usr/bin/AINvAL580-update
sudo echo "source $pdirectory/AINvAL580/libref" >> /usr/bin/AINvAL580-update
sudo echo "AINvAL580_update" >> /usr/bin/AINvAL580-update
sudo chmod +x /usr/bin/AINvAL580-update
git clone https://github.com/JT-Gresham/AINvAL580.git
echo ""
cd $pdirectory/AINvAL580/Scripts
sudo mkdir /etc/AINvAL580
sudo touch /etc/AINvAL580/AINvAL580_path
sudo chmod 777 /etc/AINvAL580/AINvAL580_path
echo "#!/usr/bin/env bash" > /etc/AINvAL580/AINvAL580_path
echo "" > /etc/AINvAL580/AINvAL580_path
echo "pdirectory=$pdirectory" > /etc/AINvAL580/AINvAL580_path
echo "AINvAL580dir=$pdirectory/AINvAL580" >> /etc/AINvAL580/AINvAL580_path
source /etc/AINvAL580/AINvAL580_path
bash $pdirectory/AINvAL580/Scripts/librefgen
echo "Changing directory ->$pdirectory/AINvAL580"
cd $pdirectory/AINvAL580
echo ""
echo "Creating python 3.12 environment (AINvAL580_env)"
/usr/bin/python3.12 -m venv $pdirectory/AINvAL580/AINvAL580_env
echo ""
echo "Activating environment -> AINvAL580_env"
source $pdirectory/AINvAL580/AINvAL580_env/bin/activate
echo "Installing pip..."
cd $pdirectory/AINvAL580/Scripts
curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
cd $pdirectory/AINvAL580
echo ""
echo "Installing wheel package..."
pip install wheel
echo ""
echo "Installing packages from requirements_AINvAL580.txt..."
pip install -r requirements_AINvAL580.txt
pip install -r requirements_AINvAL580_torch.txt
echo ""
echo "Initializing the AINvAL580 command."
ln -sf $pdirectory/AINvAL580/Scripts/AINvAL580 $pdirectory/AINvAL580/AINvAL580_env/bin/AINvAL580
sudo ln -sf $pdirectory/AINvAL580/AINvAL580_env/bin/AINvAL580 /bin/AINvAL580
sudo chmod +x /bin/AINvAL580
sudo chmod +x $pdirectory/AINvAL580/AINvAL580_env/bin/AINvAL580
echo "Creating initial \"Shared\" directory...replace with yours afterward, if necssary (symlink allowed)"
if [ ! -d "$pdirectory/AINvAL580/Shared" ]; then
  mv ./shared1 ./shared
fi
echo "AINvAL580 framework is now installed. AI program installers are located in the \"Scripts\" directory."
echo "AINvAL580 is updated \(if necessary\) whenever a framework program is started, however..."
echo "   you can also use the command: \"AINvAL580-update\" in your terminal to update AINvAL580 whenever you wish."
echo ""
echo "Thank you for trying out AINvAL580...this is a lot of work."
echo ""
echo "Before you press a key to exit the installer, a small request:"
echo "   I'd appreciate it if you'd consider supporting my work by using one of the methods listed on the main github page. - OCD"
read go
#Run after git pull
