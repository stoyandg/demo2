#!/bin/bash

if [ $CODEBUILD_BUILD_SUCCEEDING = 0]; then
    echo "Build has failed!"
else
    echo "Build has been successfully deployed!"
fi