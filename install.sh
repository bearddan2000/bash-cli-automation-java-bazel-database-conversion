#! /bin/bash

for d in `ls -la | grep ^d | awk '{print $NF}' | egrep -v '^\.'`; do

#  rm -f $d/install.sh

#  cp .src/install.sh $d

  ./readme.sh $d "cli"

  ./build.sh $d
#
  ./folder.sh $d

done
