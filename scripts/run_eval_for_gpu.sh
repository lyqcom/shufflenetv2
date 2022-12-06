#!/bin/bash

if [ $# != 2 ]
then
    echo "Usage: sh run_eval_for_gpu.sh [DATASET_PATH] [CHECKPOINT]"
exit 1
fi

# check dataset file
if [ ! -d $1 ]
then
    echo "error: DATASET_PATH=$1 is not a directory"    
exit 1
fi

# check checkpoint file
if [ ! -f $2 ]
then
    echo "error: CHECKPOINT=$2 is not a file"    
exit 1
fi

export DEVICE_ID=0

if [ -d "../eval" ];
then
    rm -rf ../eval
fi
mkdir ../eval
cd ../eval || exit

python ../eval.py --platform='GPU' --device_id=$DEVICE_ID --enable_tobgr=True --normalize=False --use_nn_default_loss=False --dataset_path=$1 --checkpoint=$2 > ./eval.log 2>&1 &
