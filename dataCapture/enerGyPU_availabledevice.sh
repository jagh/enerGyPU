#!/bin/bash

###########################################################################
#                                                                         #
# enerGyPU for monitoring performance and power consumption on Multi-GPU  #
#                                                                         #
###########################################################################                             

# enerGyPU_availabledevice.sh
# Uses the "nvidia-smi pmon" command-line for monitoring the availeble GPU.
###########################################################################

# Execution with enerGyPU_run.sh

## Identification of the GPU in the machine
## and append to 'GPU[$i]' with all IDx
i=0; for id in $(nvidia-smi | grep 0000 | awk '{print $8}'); do GPU[$i]=$id; i=$i+1; done;
#echo ${#GPU[@]} : ${GPU[*]};

## Recording the #gpu, pid, type, fb and command by each '${GPU[$i]}'
## The 'nvidia-smi pmon -s m- is used for show les information
## and 'nvidia-smi pmon -c 1' is used for show only one report
for ((i = 0; i < ${#GPU[@]}; i++))
do 
	nvidia-smi pmon -s m -i ${GPU[$i]} -c 1 | 
	awk '{ if(NR == 3 && $2=="-") 
		print $1 >> "availabledevice.txt"}'
done



freeGPU=$(head -n 1 availabledevice.txt)
echo $freeGPU


rm "availabledevice.txt"
