#!/bin/bash

: ${INRES:="1280x720"}
: ${FPS:="30"}
: ${GOP:="30"}

: ${OUTRES:="1280x720"}
: ${QUALITY:="ultrafast"}
: ${CBR:="2000k"}

: ${A_FREQ:="44100"}
: ${A_BITS:="128k"}

: ${SERVER:="rtmp://a.rtmp.youtube.com/live2/"}

ffmpeg \
-f alsa -ar "$A_FREQ" -ac 2 -i default \
-f x11grab -video_size "$INRES" -r "$FPS" -i :0 \
-c:v libx264 -preset "$QUALITY" -tune film -b:v "$CBR" -b:a "$A_BITS" -pix_fmt yuv420p -g "$GOP" \
-map 0:a -map 1:v \
-f flv "$SERVER$SERVER_KEY"
