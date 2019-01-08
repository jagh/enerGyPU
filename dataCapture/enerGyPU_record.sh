#!/bin/bash

###########################################################################
#																			#
# enerGyPU for monitoring performance and power consumption on Multi-GPU  #
#																			#
###########################################################################				

# enerGyPU_record.sh
# Data extration and write one separate file for each GPU on "testbed":
# Power consumption, streeming multiprocessor clock and memory clock frequency.
###########################################################################

## Execution with enerGyPU_run.sh
Dir=$1
ARGV=$2

## Execution in background without enerGyPU_run.sh
#Dir=../testbed/
#HOST=$(hostname)
#APP="matrixMul"
#DATA=`date +%Y%m%d%H%M`
#ARGV=$HOST-$APP-$DATA
#mkdir $Dir/$ARGV

## Identification of the GPU in the machine
i=0; for id in $(nvidia-smi | grep 0000 | awk '{print $8}'); do GPU[$i]=$id; i=$i+1; done; 
echo ${#GPU[@]} : ${GPU[*]};

## Recording data while the application is running
for gpu in $(seq 1 ${#GPU[@]}); do
    nvidia-smi -i ${GPU[$(($gpu - 1))]} --query-gpu=timestamp,pstate,clocks.sm,clocks.mem,memory.total,memory.used,memory.free,power.draw,utilization.gpu,utilization.memory,temperature.gpu,pcie.link.gen.max,pcie.link.gen.current --format=csv,noheader,nounits -lms 1000 >> $Dir/$ARGV-"gpu"$(($gpu - 1))".csv" &
done


