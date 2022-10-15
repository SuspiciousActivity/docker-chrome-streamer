# Docker Chrome Streamer

Docker image to run Chrome on a linux VPS and stream it on wherever you want. (Default is YouTube)

## Disclaimer

Code is based on [https://github.com/siedi/docker-xvfb-twitch](https://github.com/siedi/docker-xvfb-twitch).

## Features

Runs `xvfb` with the window manager `fluxbox`, `vnc` so you can connect from remote and then `chrome`. It includes a separate script to start the stream on YouTube by launching `ffmpeg`.
It also records system audio, which `docker-xvfb-twitch` was lacking, and is the reason for this project.

## Build image

Just as every other image: `docker build . -t chrome-streamer`, or just `./build.sh`

## Launch Container

```
docker run -p 127.0.0.1:5900:5900 --rm -v /etc/localtime:/etc/localtime:ro -v /dev/shm/:/dev/shm/ -e TZ=Europe/Berlin -e VNC_SERVER_PASSWORD=<password> -e SERVER_KEY=<your streaming key from youtube> --user chrome --name chrome-streamer --privileged chrome-streamer
```

**Note**: The MacOS VNC client will not be able to login unless you set a password for the VNC server.

Once the container is running, you can VNC into it at `127.0.0.1` (if you are running the container on a VPS, you might have to start a ssh tunnel first using `ssh -L 5900:localhost:5900 my_vps`)

Launch Chrome from a terminal window by running.

```
google-chrome
```

You can also start Google Chrome by right-clicking the Desktop and selecting:
```
Applications > Network > Web Browsing > Google Chrome
```

## Launch stream

Once everything is set up, you can launch the stream
`docker exec -ti chrome-streamer bash /stream.sh`

If you want to stop it, just press `CTRL-C`

## Changing the streaming service

Edit the `stream.sh` and change the stream URL to your streaming service, then rebuild. You may also change some quality settings or change the `ffmpeg` command directly.

## Security concerns
This image starts a X11 VNC server which spawns a framebuffer. Google Chrome
also requires that the image be run with the `--privileged` flag set. This flag
disables security labeling for the resulting container. Be very careful if you
run the container on a non-firewalled host.

Some applications (such as Google Chrome) will not run under the root user. A
non-root user named `chrome` is included for such scenarios.

