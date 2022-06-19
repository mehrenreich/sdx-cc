# README

The script `build-node-images.sh` is used to create a bunch of Docker images to provide node.js versions.

Some remarks:

Following non-eol node.js versions are supported as of today:

- `16`
- `17`
- `18`

For each of these major version, a Docker container image is being created, each with the latest minor version:

- `16.15.1`
- `17.9.1`
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

The base image is named/tagged: `sdx-base:latest`. Actually I don't recommend using "latest" tags in an automated/unattended process, but since this is maintained by me, I can guarantee the stability resp. steady state of the image.

```
REPOSITORY          TAG        IMAGE ID       CREATED             SIZE
sdx-base            latest     8e2f962f001e   About an hour ago   119MB
```

### Node images

Each image is tagged with the node.js version as well as the minors and majors:

```
REPOSITORY          TAG        IMAGE ID       CREATED             SIZE
sdx-node            v18        3d210e6eb227   About an hour ago   275MB
sdx-node            v18.4      3d210e6eb227   About an hour ago   275MB
sdx-node            v18.4.0    3d210e6eb227   About an hour ago   275MB
sdx-node            v17        c6ae7fe23026   About an hour ago   269MB
sdx-node            v17.9      c6ae7fe23026   About an hour ago   269MB
sdx-node            v17.9.1    c6ae7fe23026   About an hour ago   269MB
sdx-node            v16        1a068a3e31af   About an hour ago   215MB
sdx-node            v16.15     1a068a3e31af   About an hour ago   215MB
sdx-node            v16.15.1   1a068a3e31af   About an hour ago   215MB
```

