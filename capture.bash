#!/bin/bash
############################
#
# CUrrent credentials config are not encrypted
#
############################
source "functions.bash" 
camListFile="camlist.config"
camuser=$(cat credentials.config | cut -f1 -d:)
campass=$(cat credentials.config | cut -f2 -d:)
basepath="/data/video"
cam1="livingroom"
cam2="frontdoor"
fps="24"
recordTime="600" #record time in seconds
readarray -t camlist < $camListFile

camipport1=""
camipport2=""

timestamp=$(date +%Y-%m-%d)

counter=1
for i in "${camlist[@]}"
do
	camip=$(echo $i | cut -f1 -d:)
	camport=$(echo $i | cut -f2 -d:)
	protocol=$(echo $i | cut -f3 -d:)
	location=$(echo $i | cut -f4 -d:)
	echo "Current CAM: $camip:$camport $protocol"
	timestamp=$(date +%Y-%m-%d)
	if [ $protocol = "mjpeg" ]
	then
		ffmpeg -i "http://$camip:$camport/videostream.cgi?user=$camuser&pwd=$campass" -r $fps -vcodec copy -t $recordTime $basepath/$location-$counter-$timestamp.mp4 2> $basepath/$location-$counter-$timestamp.log &
	elif [ $proctocol = "rtsp" ] 
		ffmpeg -i "rtsp://$camuser:$campass@$campip:$camport/cam/realmonitor?channel=1&subtype=0" -r $fps -vcodec copy -an -t $recordTime $basepath/$location-$counter-$timestamp.mp4 2> $basepath/$location-$counter-$timestamp.log &
	fi
	counter+=1
done

#ffmpeg -i rtsp://username:password@192.168.1.201:80/videoMain -r 30 -vcodec copy -an -t 900 $RECpath/cam01/$name.mp4 </dev/null >/dev/null 2>/tmp/cam01.log &
#ffmpeg -i "http://$camlist[1]/videostream.cgi?user=$camuser&pwd=$campass" -r 24 -vcodec copy -t 600 $basepath/$cam1.mp4 2> $basepath/$cam1.log &

#ffmpeg -i "rtsp://$camuser:$campass@$campiport2/cam/realmonitor?channel=1&subtype=0" -r 24 -vcodec copy -an -t 600 $basepath/$cam2.mp4 2> $basepath/$cam2.log &
