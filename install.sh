#!/bin/bash

######################################
#
#AUTHOR      : DEEPAN
#Version     : 1.0.1
#Description : Script to enable verbose logging
#
######################################

echo "Robovision Verbose logging script."
#revoking permision
mount -o remount, rw /

#creating Datalog folder
dir="/home/DebugLog"


if [ -d $dir ]
then
    echo "Directory $dir exists. Moving forward :>"

else
    echo "Directory does not exist. Creating Directory"
    mkdir $dir
fi

if [ -d $dir ]
then
    echo "Directory making done. Moving forward :>"
    echo "Moving Robov"
    mv RoboV.sh /etc/

    if [ -f "/etc/startup.sh" ]
	then
    	echo "Startup script Found"
    	echo "Renaming old start-up script"
   	    mv /etc/startup.sh /etc/olDstartup.sh
	else
    	echo "No startup script Creating new"
    	
	fi

    echo "Moving new Starup script"
    mv startup.sh /etc/

    echo "Done Moving stuff.."
    echo " "
    echo "Revoking execution for current user"
    chmod +x /etc/startup.sh
    chmod +x /etc/RoboV.sh

    #revoking permision to read
	mount -o remount, r /

	echo "Done editing file system, you can find logs in $dir"
    exit 0


else
    echo "Oops :: Failed to create  Directory . terminating bash..!!!"
    #revoking permision to read
	mount -o remount, r /
    exit "File system error"
    
fi


#revoking permision to read
#mount -o remount, r /