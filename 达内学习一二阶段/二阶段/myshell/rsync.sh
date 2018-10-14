#!/bin/bash
#需要提前准备tools.tar.gz包
tar -xf tools.tar.gz 
cd tools/
tar -xf inotify-tools-3.13.tar.gz 
cd inotify-tools-3.13/
./configure 
make
make install
