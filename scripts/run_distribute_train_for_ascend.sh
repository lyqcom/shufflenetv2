#!/bin/bash

if [ $# -ne 2 ]
then 
    echo "Usage: sh run_distribute_train_for_ascend.sh [RANK_TABLE_FILE] [DATASET_PATH]"
exit 1
fi

if [ ! -f $1 ]
then 
    echo "error: RANK_TABLE_FILE=$1 is not a file"
    exit 1
fi

if [ ! -d $2 ]
then
    echo "error: DATASET_PATH=$2 is not a directory"    
exit 1
fi

ulimit -u unlimited
export HCCL_CONNECT_TIMEOUT=600
export DEVICE_NUM=8
export RANK_SIZE=8
export RANK_TABLE_FILE=$1

for((i=0; i<${DEVICE_NUM}; i++))
do
    export DEVICE_ID=$i
    export RANK_ID=$i
    rm -rf ./train_parallel$i
    mkdir ./train_parallel$i
    cp ../*.py ./train_parallel$i
    cp *.sh ./train_parallel$i
    cp -r ../src ./train_parallel$i
    cd ./train_parallel$i || exit
    echo "start training for rank $RANK_ID, device $DEVICE_ID"
    env > env.log
    python train.py \
                   --dataset_path=$2 \
                   --is_distributed=True \
                   --platform=Ascend > log.txt 2>&1 &
    cd ..
done
