# Docker Android

## Build Dependancies
- docker
- docker-compose (optional)

## Run Dependancies
- docker
- docker-compose (optional)

## Building
(Assumes you are running every command as a user in the `docker` group, or as `root`)

###  With docker-compose
`docker-compose build`

### Without docker-compose
[comment]: <> (`docker build --build-arg ANDROID_VERSION=8.1 --build-arg API_LEVEL=29 --build-arg CHROME_DRIVER=74.0.3729.6 --build-arg BROWSER=chrome --build-arg SYS_IMG=x86 docker`)
Install docker-compose

## Running

### With docker-compose
`docker-compose up`

But with the current docker-compose.yml this won't do much.

### Without docker-compose
`docker run --privileged --rm -p 8200:8200 -e DEVICE="Nexus 5" -e ACCESS_KEY="<ssh public key>" -e SCREEN_WIDTH="<width in pixels>" -e SCREEN_HEIGHT="<height in pixels>" --runtime runc --name android-container cycle/docker-android-x86-8.1`

Note that if you want persistant user data you'll need to mount folders to `/home/user/.android` and `/home/user/android_emulator`

## Connecting to container over SSH

The recommended way to connect to this container (assuming you're not using one of the Cycle clients), is to use SSH to forward any ports you need.
- 5037 : adb (make sure to also use `-R 27183:localhost:27183`)
- 4000 : HTTP audio stream
- 554 : RTSP audio stream
- 5900 : VNC

For example, if you want to use [scrcpy](https://github.com/Genymobile/scrcpy) over adb with a HTTP audio stream, you could use the following command:
```bash
ssh user@$CONTAINER_IP -L 5037:localhost:5037 -R 27183:localhost:27183 -L 4000:localhost:4000 -p 8200
```
