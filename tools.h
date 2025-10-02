#include <sys/time.h>
#include <fstream>
#include <cassert>
#include <sstream>

size_t get_time_in_ms(){
    struct timeval tv;
    gettimeofday(&tv, nullptr);  // 获取当前时间
    
    // 计算总微秒数：秒数*1000000 + 微秒数
    return tv.tv_sec * 1000000LL + tv.tv_usec;
 
}

 std::tuple<size_t, size_t> SSD_io_bytes(const std::string& device_name) {
    std::ifstream stat("/proc/diskstats");
    assert(!!stat);
  
    uint64_t read = 0, write = 0;

    bool find_device_line = false;
    for (std::string line; std::getline(stat, line);) {
      if (line.find(device_name) != std::string::npos) {
        find_device_line = true;
        std::istringstream iss(line);
        std::vector<std::string> strs((std::istream_iterator<std::string>(iss)),
                                      std::istream_iterator<std::string>());
        if (strs.size() >= 10) {
          read += std::stoull(strs[5]) * 512;
          write += std::stoull(strs[9]) * 512;
        }
      }
    }
    return {read, write};
  }