#!/bin/bash

#export BPATH=$(pwd)

# build requirements
#if [-x "$(command -v dnf)" ];then
#	{
#		#red-hat compile
#		dnf update && dnf install -y boost-atomic boost-thread boost-system boost-date-time boost-regex boost-filesystem boost-random boost-chrono boost-serialization ninja-build vim git openssl openssl-devel cmake gcc-c++ boost-devel
#		cd $BPATH && git clone -b 0.8.0 --depth 1 https://github.com/zaphoyd/websocketpp && \
#	        cd websocketpp && mkdir build && cd build && cmake .. && make install
#	}
#elif [-x "$(command -v apt)" ];then
#	{
#		#debian compile
#		apt-get install g++ git libboost-atomic-dev libboost-thread-dev libboost-system-dev libboost-date-time-dev libboost-regex-dev libboost-filesystem-dev libboost-random-dev libboost-chrono-dev libboost-serialization-dev libwebsocketpp-dev openssl libssl-dev ninja-build
#	}
#else
#	{
#		echo "unsupported, Please rely on yourself !"
#		exit 1
#	}

# build 
#cd $BPATH && git clone -b v2.10.18 --depth 1 https://github.com/microsoft/cpprestsdk && \
	cd /build/cpprestsdk && \
	mkdir build && cd build && cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Static && \
	ninja && cd Release/Binaries/ && tar zcvf cpprestsdk-linux-loong64.tar.gz && \
	bash /build/lib/curl.sh cpprestsdk-linux-loong64.tar.gz microsoft/cpprestsdk 2.10.18

