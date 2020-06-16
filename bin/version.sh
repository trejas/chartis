#!/bin/bash
cat VERSION | tr -d '\n' | xargs -I{} echo {}"-${DRONE_BUILD_NUMBER}" > VERSION
