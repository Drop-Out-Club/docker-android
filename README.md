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
`docker run --privileged -d -p 8200:8200 -e DEVICE="Nexus 5" -e ACCESS_KEY="<ssh public key>" -e SCREEN_WIDTH="<width in pixels>" -e SCREEN_HEIGHT="<height in pixels>" --runtime runc --name android-container cycle/docker-android-x86-8.1`

Note that if you want persistant user data you'll need to mount folders to `/root/.android` and `/root/android_emulator`
