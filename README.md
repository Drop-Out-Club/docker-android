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
`docker build --build-arg ANDROID_VERSION=11.0 --build-arg API_LEVEL=30 --build-arg CHROME_DRIVER=74.0.3729.6 --build-arg BROWSER=chrome --build-arg SYS_IMG=x86`

## Running

### With docker-compose
`docker-compose up`

### Without docker-compose
`docker run --privileged -d -p 5554:5554 -p 5555:5555 -p 5900:5900 -e DEVICE="Nexus 5" --name android-container xenum/docker-android-x86-10.0`
