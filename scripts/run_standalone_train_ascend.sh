#!/bin/bash

if [ $# != 1 ]
then
    echo "Usage: sh run_standalone_train.sh [DATASET_PATH]"
exit 1
fi

get_real_path(){
  if [ "${1:0:1}" == "/" ]; then
    echo "$1"
  else
    echo "$(realpath -m $PWD/$1)"
  fi
}

DATASET_PATH=$(get_real_path $1)
echo $DATASET_PATH


if [ ! -d $DATASET_PATH ]
then
    echo "error: DATASET_PATH=$DATASET_PATH is not a directory"
exit 1
fi


export DEVICE_NUM=1
export DEVICE_ID=0
export RANK_ID=0
export RANK_SIZE=1

if [ -d "train" ];
then
    rm -rf ./train
fi
mkdir ./train
cp ../*.py ./train
cp -r ../modelarts ./train
cp -r ../src ./train
cp -r ../infer ./train
cd ./train || exit
echo "start training for device $DEVICE_ID"
env > env.log

python train.py \
       --dataset_path=$DATASET_PATH \
       --is_distributed=False \
       --platform=Ascend > log.txt 2>&1 &
cd ..
