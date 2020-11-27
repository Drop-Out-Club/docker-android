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
#### Ubuntu and Ubuntu based Linux Distros
`sudo apt install docker-compose && docker-compose build`

## Running

### With docker-compose
`docker-compose up`

### Without docker-compose
`docker run --privileged -d -p 6080:6080 -p 5554:5554 -p 5555:5555 -p 5900:5900 -e DEVICE="Samsung Galaxy S6" --name android-container xenum/docker-android-x86-10.0`
