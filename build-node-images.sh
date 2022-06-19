#!/usr/bin/env bash
#
# Filename: build-node-images.sh
#
# Purpose: Create base Docker images with node.js installed. See the README file for details.
#
# Created: 2022-06-19 Michael Ehrenreich
#
#

##
# Variables - modify to your needs
#
UBUNTU_VERSION="22.04"
NODE_MAJOR_VERSIONS="16 17 18"

DOCKER_NAME_PREFIX="sdx"
DOCKER_REGISTRY_NAMESPACE="zipslack" # relates to docker.io/library
DOCKER_PUSH_TO_REGISTRY=true

##
# Get the latest avaiable minor version for the given major version.
#
# Input:
# - major_version: Major version, e.g. "16"
#
get_latest_node_version () {
    local major_version=$1
    n lsr $major_version | grep "^\\d" | head -n1
}

##
# Triggers the creation of the base image.
# Please note: It's not part of this exercise, but needed, so I kept it.
#
# Input:
# - dockerfile: name of the Dockerfile
# - tags: list (space-separated) of tags to use
# - build_args: list (space-separated) of build_args to use
#
create_base_image () {
    local dockerfile="Dockerfile.base"
    local tags="${DOCKER_NAME_PREFIX}-base:latest"
    local build_args="UBUNTU_VERSION=${UBUNTU_VERSION}"

    create_image "${dockerfile}" "${tags}" "${build_args}"
}

##
# Triggers the creation of a node image.
#
# Input:
# - node_version: full version string w/o leading "v", e.g. "16.15.1"
# - dockerfile: name of the Dockerfile
# - tags: list (space-separated) of tags to use
# - build_args: list (space-separated) of build_args to use
#
create_node_image () {
    local node_version=$1
    local dockerfile="Dockerfile.node"
    local tags="${DOCKER_NAME_PREFIX}-node:${node_version} ${DOCKER_NAME_PREFIX}-node:${node_version%.*} ${DOCKER_NAME_PREFIX}-node:${node_version%.*.*}"
    local build_args="NODE_VERSION=${node_version}"

    create_image "${dockerfile}" "${tags}" "${build_args}"
}

##
# This function actually creates the image.
#
# Input:
# - dockerfile: name of the Dockerfile
# - tags: list (space-separated) of tags to use
# - build_args: list (space-separated) of build_args to use
#
create_image () {
    local dockerfile=$1
    local tags=$2
    local build_args=$3
    
    local tag_list=""
    local build_arg_list=""

    if [[ ! -f $dockerfile ]] ; then
        echo "Missing Dockerfile ${dockerfile}" >/dev/stderr
        exit 255
    fi

    for t in $tags ; do
        tag_list="${tag_list} -t ${t}"
        tag_list="${tag_list} -t ${DOCKER_REGISTRY_NAMESPACE}/${t}"
    done

    for b in $build_args ; do
        build_arg_list="${build_arg_list} --build-arg ${b}"
    done

    docker build ${tag_list} ${build_arg_list} -f ${dockerfile} .
}

##
# Pushes an image with the given name:tag to a remote registry
#
# Input:
# - image: the image to be pushed. Format: name:tag
#
push_image_to_registry () {
    local image=$1
    docker push $image
}


case "$1" in
    base)
        create_base_image
        ;;
    node)
        for major_version in $NODE_MAJOR_VERSIONS ; do
            for node_version in $(get_latest_node_version $major_version) ; do
                create_node_image "v${node_version}"

                if [[ $DOCKER_PUSH_TO_REGISTRY == true ]] ; then
                    push_image_to_registry "${DOCKER_REGISTRY_NAMESPACE}/${DOCKER_NAME_PREFIX}-node:v${node_version}"
                fi
            done
        done
        ;;
    all)
        $0 base
        $0 node
        ;;
    *)
        echo "Usage: $0 {base | node | all}"
        exit
        ;;
esac
