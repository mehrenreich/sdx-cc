# Coding Challenge

We want to fulfill high-security standards. Project images are based on self-created base images in our registry.

We create base images in Jenkins, nightly. The image hierarchy is:
- Project image used by SDA SE teams
- Application image with java/nodejs/nginx/. . . • Self-created base image for other base images • Official Image

We use the concept infrastructure as code.

## Task

Your task is to create base images, which can be used by our development teams.

## Description

Please create base images with nodejs versions which are not EOL. Each image has to include the latest version of that nodejs release to provide up to date base images.

Semantic versioning is a concept to show the version of a dependency that is used in our software development. The provided solution needs to satisfy the following requirements from different development teams:

- As a project, I want to pin a specific base image for stability reasons
- As a project, I want to refer to a major and/or minor version of an image to automatically receive updates during the build

## Environment

We use buildah to create our images. You are free to choose a tool that you are comfortable with. You can choose a linux based distribution for the base images. While we create our images with Jenkins, you are free to choose a lightweight solution. A cronjob for periodically builds is not needed.

## Solution Defence

Please prepare yourself to defend your solution. A sample question is the impact on the development process.
