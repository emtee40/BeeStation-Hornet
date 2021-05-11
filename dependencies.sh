#!/bin/bash

#Project dependencies file
#Final authority on what's required to fully build the project

# byond version
# Extracted from the Dockerfile. Change by editing Dockerfile's ARG commands. Otherwise, this is set by Docker's envrionment variables
if [[ -f "Dockerfile" ]]; then
	LIST=($(sed -n 's/.*byond:\([0-9]\+\)\.\([0-9]\+\).*/\1 \2/p' Dockerfile))
	export BYOND_MAJOR=${LIST[0]}
	export BYOND_MINOR=${LIST[1]}
	unset LIST
fi

#rust_g git tag
export RUST_G_VERSION=0.4.7.1

#node version
export NODE_VERSION=12

# SpacemanDMM git tag to use for fetching prebuilt release
export SPACEMAN_DMM_VERSION=suite-1.6

# SpacemanDMM commit to use for building from source
export SPACEMAN_DMM_COMMIT_HASH=9c756347decf8e167ab6dc193f9423d3632a6c81
