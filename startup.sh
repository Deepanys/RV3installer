#!/bin/bash

# add RTC device
echo ds1307 0x68 > /sys/class/i2c-adapter/i2c-1/new_device

# Check Root Partition for any Corrution
sh /etc/partCheck.sh

# Set systemtime from HardwareClock(I2C RTC)
hwclock -s

# log the boot up time
echo `date +%Y:%m:%d:%T` > /tmp/StartTime.dat
#echo `date +%Y:%m:%d:%T` > /media/Extended/RoboVision3D/HealthStatus/StartTime.dat

# ResetApp : (initLEDs,Reset Sensor,monitor ResetIn input pin,
#                provide clock to supervisorIC, safe-shutdown based on POE Power, CPU temperature based fanc control


/etc/Boardresetservice start
#/root/stride/exe/scripts/sensorCtrl.sh 1
sleep 1

# start Apache Server
/usr/local/apache2/bin/apachectl start


# IPMonitor : Monitor  IPaddress change. upon any change restart logmein-hamachi and RoboVision3DService
IPMonitor

# 
rm -f /media/Extended/RoboVision3D/CarrierSignal.dat

# Start RoboDiscoveryService
RoboDiscoveryService

# Read UniqueID
/root/stride/exe/UniqueIDTest

# Start RoboVision3DService for people counting
#RoboVision3DService
################ Logging ################
#/usr/local/bin/RoboVision3DService &> /home/DebugLog/StrideConsole.log
sh /etc/RoboV.sh 
#/root/stride/exe/testIntelSensor  > /dev/null 2>&1 &		# Start Intel Realsense test application

service cron start
	
# Disable Power of HDMI
#tvservice -o

# Start NTP Service
sh /etc/init.d/ntp start

# Set Hostname of board
hostname -F /etc/hostname

# 
iptables -A INPUT -p icmp -m icmp --icmp-type 13 -j DROP
iptables -A INPUT -p icmp -m icmp --icmp-type 14 -j DROP

# 
sysctl -w net.ipv4.tcp_timestamps=0

sleep 10

# Start RoboVision3DMonitor to check status of various PCS services 
RoboVision3DMonitor

# Start VPNMonitor
VPNMonitor

sh /etc/watch.sh&

echo "PCS services are running"
