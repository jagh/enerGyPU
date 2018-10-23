#!/bin/bash

#############################################################################
#                                                                         	#
# enerGyPU for monitoring performance and power consumption on Multi-GPU  	#
#                                                                         	#
#############################################################################
# enerGyPU_run.sh															#
# Execution steps and the application libraries are declared.				#
#############################################################################


# Global workload parameters
# For the sample matrixMul the dimensions of A & B matrices must be equal.
DIM=1024
nGPU=1

# Location of the power consumption measures
Dir=../testbed/
HOST=$(hostname)
APP="matrixMul"
DATA=`date +%Y%m%d%H%M`
ARGV=$HOST-$APP-$DIM-$nGPU-$DATA
mkdir $Dir/$ARGV

###############################################
## OLD-Version
## Identification of the GPU in the machine
#i=0; for id in $(nvidia-smi | grep 0000 | awk '{print $8}'); do GPU[$i]=$id; i=$i+1; done;
#echo ${#GPU[@]} : ${GPU[*]};
#if [ ${#GPU[@]} == 1 ]
#then	
#	## Executes the enerGyPU_record.sh
#	./enerGyPU_record-desktop.sh $Dir $ARGV &
#
#elif [ ${#GPU[@]} == 8 ]
#then
#	## Executes the enerGyPU_record.sh
#    ./enerGyPU_record-cluster.sh $Dir $ARGV &
#
#else
#	echo "++ no NVIDIA GPU detected ++"
#fi
###############################################

## Executes the enerGyPU_record.sh
./enerGyPU_record.sh $Dir $ARGV &

## Add path of the application and libraries necessaries
nvprof --print-gpu-trace -o $Dir/$ARGV/$ARGV-matrixMul.nvprof ./../samples/matrixMul/matrixMul -device=$nGPU -wA=$DIM -wB=$DIM -hA=$DIM -hB=$DIM


kill %1
