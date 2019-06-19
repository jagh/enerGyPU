
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
#TFPS=$3	## TensorFlow parameter server
MASTER=$3
HOST=$(hostname)

## Execution in background without enerGyPU_run.sh
#Dir=../testbed/
#HOST=$(hostname)
#APP="matrixMul"
#DATA=`date +%Y%m%d%H%M`
#ARGV=$APP-$DATA
#mkdir $Dir/$ARGV
## TensorFlow parameter server
#TFPS="134.59.132.20:2222"
#MASTER=134.59.132.111

## Get host from TensorFlow parameter server 
#FLAG=0
#for addr in $(echo $TFPS | tr ":" "\n")
#do
#   if [ $FLAG == 0 ]; then
#      MASTER=$addr
#      FLAG=1
#   fi
#done

## Recording data while the application is running
#while true; do
#Time=`date +%s`
#sudo iftop -t -f "host $MASTER" | grep -e "Total" -e "Cumulative" | awk '{print '$Time'";;"$0 >> "'$Dir/$ARGV/$HOST-$ARGV'-bandwidth.txt"}'


sudo iftop -t -f "host $MASTER" | grep -e "Total" -e "Cumulative" |
 awk '{print $0 >> "'$Dir/$ARGV/$HOST-$ARGV'-bandwidth.txt"}'


#sleep 0.9s
#done
