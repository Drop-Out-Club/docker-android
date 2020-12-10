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
`docker build --build-arg ANDROID_VERSION=10.0 --build-arg API_LEVEL=29 --build-arg CHROME_DRIVER=74.0.3729.6 --build-arg BROWSER=chrome --build-arg SYS_IMG=x86`

## Running
You must have a folder called `ssh_keys` in the same directory as `docker-compose.yml` that has permissions `600` and owner `root:root`. In order to be able to connect via SSH there must be a file called `ssh_keys/authorized_keys` that contains the public key of the key you want to use to connect via SSH.

### With docker-compose
`docker-compose up`

### Without docker-compose
`docker run --privileged -d -p 8200:8200 -e DEVICE="Nexus 5" --name android-container xenum/docker-android-x86-10.0`
