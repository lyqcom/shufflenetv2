#!/bin/bash

if [ $# -lt 1 ] || [ $# -gt 2 ]
then
    echo "Usage: 
          sh run_standalone_train_for_gpu.sh [DATASET_PATH] [PRETRAINED_CKPT_FILE](optional) 
          "
exit 1
fi

# check dataset path
if [ ! -d $1 ]
then
    echo "error: DATASET_PATH=$1 is not a directory"    
exit 1
fi

# check PRETRAINED_CKPT_FILE
if [ $# == 2 ] && [ ! -f $2 ]
then
    echo "error: PRETRAINED_CKPT_FILE=$2 is not a file"    
exit 1
fi

if [ -d "../train" ];
then
    rm -rf ../train
fi
mkdir ../train
cd ../train || exit

if [ $# == 1 ]
then
    python ../train.py --platform='GPU' --enable_tobgr=True --normalize=False --use_nn_default_loss=False --dataset_path=$1 > train.log 2>&1 &
fi

if [ $# == 2 ]
then
    python ../train.py --platform='GPU' --enable_tobgr=True --normalize=False --use_nn_default_loss=False --dataset_path=$1 --resume=$2 > train.log 2>&1 &
fi
