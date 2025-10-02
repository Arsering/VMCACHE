vmcache: vmcache.cpp tpcc/*pp
	g++-10 -DNDEBUG -O2 -std=c++20 -fnon-call-exceptions vmcache.cpp -o vmcache -laio -lpthread

clean:
	rm vmcache
