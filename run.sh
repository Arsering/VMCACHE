make 

CUR_DIR=.

export time=$(date "+%Y-%m-%d-%H:%M:%S")
export LOG_DIR=${CUR_DIR}/logs/${time}
mkdir -p ${LOG_DIR}
cp -r ./$0 ${LOG_DIR}/run.sh



echo 1 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/drop_caches

memory_capacity=$(python3 -c "print(int(20* 1024 * 1024 * 1024))")
# echo ${memory_capacity} > /sys/fs/cgroup/memory/yz_variable/memory.limit_in_bytes

ulimit -v unlimited

FILE_SIZE_PAGE=$(python3 -c "print(int(256*1024*10))")
export RNDREAD=0 
# export BLOCK=/mnt/nvme/vmcache_test/vm_file
export BLOCK=/dev/loop1
export THREAD=1
export DATASIZE=${FILE_SIZE_PAGE}
export VIRTGB=32
export PHYSMB=$(python3 -c "print(int(1024*3))")
export EXMAP=1

./vmcache &> ${LOG_DIR}/log.log