#!/bin/bash


basepath="/data/video"
cam1="livingroom"
cam2="frontdoor"
camipport1=""
camipport2=""

timestamp=$(date +%Y-%m-%d_%H.%M)

#ffmpeg -i rtsp://username:password@192.168.1.201:80/videoMain -r 30 -vcodec copy -an -t 900 $RECpath/cam01/$name.mp4 </dev/null >/dev/null 2>/tmp/cam01.log &
ffmpeg -i "http://$camipport1/videostream.cgi?user=$camuser&pwd=$campass" -r 24 -vcodec copy -t 600 $basepath/$cam1.mp4 2> $basepath/$cam1.log &

ffmpeg -i "rtsp://$camuser:$campass@$campiport2/cam/realmonitor?channel=1&subtype=0" -r 24 -vcodec copy -an -t 600 $basepath/$cam2.mp4 2> $basepath/$cam2.log &