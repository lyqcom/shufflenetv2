#!/bin/bash

if [[ $# -lt 3 || $# -gt 4 ]]; then
    echo "Usage: bash run_onnx.sh [ONNX_PATH] [DATASET_PATH] [PLATFORM] [DEVICE_ID](optional) "
exit 1
fi

get_real_path(){
  if [ "${1:0:1}" == "/" ]; then
    echo "$1"
  else
    echo "$(realpath -m $PWD/$1)"
  fi
}
onnx_path=$(get_real_path $1)
data_path=$(get_real_path $2)
platform=$3
device_id=0
if [ $# == 4 ]; then
    device_id=$4
fi

echo "ONNX path: "$onnx_path
echo "dataset path: "$data_path
echo "platform: "$platform
echo "device_id: "$device_id

function infer()
{
    python ./infer_shufflenetv2_onnx.py --onnx_path=$onnx_path \
                                  --onnx_dataset_path=$data_path \
                                  --platform=$platform \
                                  --device_id=$device_id  > ./infer_onnx.log
}

infer
if [ $? -ne 0 ]; then
    echo " execute inference failed"
    exit 1
fi
