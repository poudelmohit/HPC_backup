#!/bin/bash

cd /network-share/Student/SOFTWARE

wget https://catchenlab.life.illinois.edu/stacks/source/stacks-2.66.tar.gz
tar -vxf stacks-2.66.tar.gz
cd stacks-2.66
./configure --prefix /home/mp067823/local
make
make install
cd ~/local/bin && ls
mkdir stacks
export PATH="~/local/bin/stacks:$PATH"