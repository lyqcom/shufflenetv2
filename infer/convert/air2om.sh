#!/bin/bash

if [ $# != 2 ]
then
    echo "Usage: sh air2om.sh [INPUT_MODEL_FILE] [OUTPUT_MODEL_NAME]"
exit 1
fi

# check the INPUT_MODEL_FILE
if [ ! -f $1 ]
then
    echo "error: INPUT_MODEL_FILE=$1 is not a file"
exit 1
fi

input_model_file=$1
output_model_name=$2

/usr/local/Ascend/atc/bin/atc \
--model=$input_model_file \
--framework=1 \
--output=$output_model_name \
--input_format=NCHW --input_shape="actual_input_1:1,3,224,224" \
--disable_reuse_memory=0 \
--enable_small_channel=0 \
--log=error \
--soc_version=Ascend310 \
--insert_op_conf=./aipp.config
