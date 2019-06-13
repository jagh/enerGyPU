#!/bin/bash
#################################################################################
## Launcher: 
## Declare the execution steps for the application, libraries and the monitor
## Example using an MPI application
#################################################################################

## Application workload parameters
APP="cnn"
MPI_NPROC=12

## Location of the power consumption tracks 
Dir=enerGyPU/testbed/
DATA=`date +%Y%m%d%H%M`
ARGV=$APP-$MPI_NPROC-$DATA
mkdir $Dir/$ARGV

## Global parameters for distributed computing
Dir_remote=cloud/Version1/$Dir
IP_hosts=("ip_host1" "ip_host2" "ip_host3")


## Turn-on the computational resources monitor on distributed platform
for ip_host in "${IP_hosts[@]}"; do
	ssh  mpiuser@$ip_host 'bash -s' < /home/mpiuser/cloud/Version1/enerGyPU/dataCapture/enerGyPU_record-jetson.sh $Dir_remote $ARGV &
done

## Turn-on the computational resources monitor on local machine
#./enerGyPU/dataCapture/enerGyPU_record-jetson.sh $Dir $ARGV &


## MPI aplication execution
mpiexec -n 12 --hostfile h-workers python mpirun.py $Dir $ARGV

## Local execution
#mpiexec -n 4 python mpirun.py $Dir $ARGV


## Turn-off the computational resources monitor for each host
for ip_host in "${IP_hosts[@]}"; do
	ssh -t mpiuser@$ip_host "sudo killall -9 tegrastats"
done

#sudo killall -9 iftop
kill %1
