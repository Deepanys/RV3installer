#!/bin/bash

echo "Debug_log Script Starting"


################ Remounting #######################
mount -o remount,rw /

#Enableing Console Log
touch /tmp/EnterDebug.dat 

#Creating File Name using Date stamp
FileName=$(date +'RV3D_%Y:%m:%d:%T.log')

#Creating File using Date stamp in /home/DataLog Dir
touch /home/DebugLog/$FileName


/usr/local/bin/RoboVision3DService>/home/DebugLog/$FileName

echo "DebugLog Started...."