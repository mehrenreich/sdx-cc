# README

The script `build-node-images.sh` is used to create a bunch of Docker images to provide node.js versions.

Some remarks:

Following non-eol node.js versions are supported as of today:

- `14`
- `16`
- `18`

For each of these major version, a Docker container image is being created, each with the latest minor version:

- `14.19.3`
- `16.15.1`
- `18.4.0`

As a base image, a `ubuntu:22.04` has been chosen.

For all images, there are Dockerfiles used:

- `Dockerfile.base` for creating the base image
- `Dockerfile.node` for creating the node images

These Dockerfile are parametrized and shouldn't be used without passing `--build-args`.

All images are prefixed with the string `sdx-`.

## Preflight check

Ensure that you've installed these programs to use this script:

- bash shell
- Docker
- n (https://www.npmjs.com/package/n)

## Usage

Even if not beig part of this exercise, this script can also be used to create the base image itself:

`./build-node-images.sh base`

Creating all node versions by running:

`./build-node-images.sh node`

Or all together:

`./build-node-images.sh all`

## Output

So what's being created?

### Base image

The base image is named/tagged: `sdx-base:22.04`.

```
REPOSITORY          TAG        IMAGE ID       CREATED             SIZE
sdx-base            22.04      8e2f962f001e   About an hour ago   119MB
```

### Node images

Each image is tagged with the node.js version as well as the minors and majors:

```
REPOSITORY        TAG              IMAGE ID       CREATED              SIZE
sdx-node          v18              b70796818fca   11 seconds ago       274MB
sdx-node          v18.4            b70796818fca   11 seconds ago       274MB
sdx-node          v18.4.0          b70796818fca   11 seconds ago       274MB
sdx-node          v16              0d0f35a958c8   17 seconds ago       214MB
sdx-node          v16.15           0d0f35a958c8   17 seconds ago       214MB
sdx-node          v16.15.1         0d0f35a958c8   17 seconds ago       214MB
sdx-node          v14              422942af04e1   27 seconds ago       221MB
sdx-node          v14.19           422942af04e1   27 seconds ago       221MB
sdx-node          v14.19.3         422942af04e1   27 seconds ago       221MB
```
