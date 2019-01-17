"""
Monitor for recording memory, cpu and disk usage while the models are training
"""

import sys
import psutil, datetime
import numpy as np



def main():
    if len(sys.argv) != 4:
        sys.exit('usage: platform <pid> <testbed_exp> <exp_id>')
        
    p = psutil.Process(int(sys.argv[1]))
    file_metrics = str(sys.argv[2]+"/"+sys.argv[3]+'-resources_metrics.txt')


    while True:
        core_usage = str(p.cpu_percent(interval=1.0))
        num_threads = str(p.num_threads())
        memory_usage = str(np.round(p.memory_percent(), 2))
        memory_rss = str(p.memory_info().rss / 1024)
        memory_vms = str(p.memory_info().vms / 1024)
        memory_shr = str(p.memory_info().shared / 1024)
        data = str(p.memory_info().data)
        io_reads = str(p.io_counters().read_bytes / 1024)
        io_writes = str(p.io_counters().write_bytes / 1024)
        time = str(datetime.datetime.now().time())

        resources_metrics = str(time+","+memory_usage+","+memory_rss+","+memory_vms+","+memory_shr+","+
                                    core_usage+","+num_threads+","+data+","+io_reads+","+io_writes)
        
        with open(file_metrics, 'a') as f:    
            f.write(resources_metrics + '\n')
        f.close()
        
if __name__ == '__main__':
    main()