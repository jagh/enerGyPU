#!/bin/bash

###########################################################################
#									  #
# enerGyPU for monitoring performance and power consumption on Multi-GPU  #
#									  #
###########################################################################

# enerGyPU_record.sh
# Data extration and write one separate file for each GPU on "testbed":
# Power consumption, streeming multiprocessor clock and memory clock frequency.
###########################################################################


# execution in background without enerGyPU_run.sh
Dir=../testbed/
HOST=$(hostname)
DATA=`date +%Y%m%d%H%M`
APP='test'
mkdir $Dir/$HOST-$DATA-$APP

# Identification of the GPU in the machine
i=0; for id in $(nvidia-smi | grep 0000 | awk '{print $8}'); do GPU[$i]=$id; i=$i+1; done; 
echo ${GPU[*]};
