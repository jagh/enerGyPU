#!/bin/bash

###########################################################################
#                                                                         #
# enerGyPU for monitoring performance and power consumption on Multi-GPU  #
#                                                                         #
###########################################################################

# enerGyPU_record for Jetson TX2
# Data extration and write one separate file for each GPU on "testbed":
# Power consumption, streeming multiprocessor clock and memory clock frequency.
#####################################################################


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

## Recording data while the application is running
while true
do

Time=`date +%s`

#sudo ./tegrastats |
sudo ../enerGyPU/dataCapture/tegrastats |
awk '{print '$Time'";;"$0 >> "'$Dir/$ARGV/$ARGV'-jetson.txt"}' 

#echo "$(/usr/bin/python -c 'import re; import sys; tegrastats = "Hello"; print tegrastats')"


#mport re
#string1 = "RAM 1677/8765 CPU [20%1322,10%88756]\r\nRAM 1677/8765 CPU [20%1322,10%88756]"
#catch = re.findall("RAM \d+/\d+ CPU \[(\d+)%(\d+),\d+%\d+\]", string1)
#print catch

#nvidia-smi -q -i ${GPU[*]} -d MEMORY,UTILIZATION,TEMPERATURE,POWER,CLOCK |
#grep -e "Timestamp" -e "MiB" -e "W" -e "MHz" |
#awk '{if(NR == 1){TIMENV=$6;}
#      if($1 == "Used" && NR==3) USED=$3; 
# else if($1 == "Free" && NR==4) FREE=$3;
# else if($2 == "Draw" && NR==8) DRAW=$4;
# else if($1 == "Graphics" && NR==9) GRAPHICS=$3;
# else if($1 == "SM"&& NR==18) SM=$3;
# else if($1 == "Memory"&& NR==19) MEMORY=$3;
# else if(NR%26 == 0)
# print TIMENV";"'$Time'";"GRAPHICS";"SM";"MEMORY";"USED";"FREE";"DRAW >> "'$Dir/$ARGV/$ARGV-'gpu0.csv"}'

#sleep 0.9s
done
