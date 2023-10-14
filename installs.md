#Installing Verbose Debugging script in Raspberrypi 

#1.Clone the Rv3 Repo to your Directory 
git clone https://github.com/Deepanys/RV3installer.git

#2.Move from current working Dir to installer dir
cd  RV3installer

#3.Revoke the Executable permission to install script
chmod +x install.sh

#4.Execute the install script
./install.sh

#5.Verify that DebugLog Dir is created in your home dir
 cd /home/DebugLog
