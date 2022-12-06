#!/bin/bash

if [ $# != 1 ]
then
    echo "Usage: sh run.sh [DATASET_VAL_PATH]"
exit 1
fi

# check the DATASET_VAL_PATH
if [ ! -d $1 ]
then
    echo "error: DATASET_VAL_PATH=$1 is not a path"
exit 1
fi

export LD_LIBRARY_PATH=${MX_SDK_HOME}/lib:${MX_SDK_HOME}/lib/modelpostprocessors:${MX_SDK_HOME}/opensource/lib:${MX_SDK_HOME}/opensource/lib64:/usr/local/Ascend/ascend-toolkit/latest/acllib/lib64:${LD_LIBRARY_PATH}

# run
./shufflenetv2 $1
