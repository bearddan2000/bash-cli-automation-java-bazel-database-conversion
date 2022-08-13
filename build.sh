#! /bin/bash

function rm_Dockerfile() {
  #statements
  local parent=$(pwd)
  local target=$1

  #change to bin dir
  cd $target

  #go up one level
  cd ../

  #remove Dockerfile if exists in prj_dir
  if [[ -e ./Dockerfile ]]; then
    #statements
    rm -f ./Dockerfile

    #copy Dockerfile from .src
    cp $parent/.src/Dockerfile .

  fi

  #switch baxk to project dir
  cd $parent
}

function create_bazel_wrkspace() {
  #statements

  local prj_dir=$1
  local tmp_dir=$2
  local db=""

  case $prj_dir in
    *h2* ) db="h2" ;;
    *hsqldb* ) db="hsqldb" ;;
    *derby* ) db="derby" ;;
  esac

  cp .src/$db/WORKSPACE $tmp_dir/WORKSPACE

  cp .src/$db/BUILD $tmp_dir/src/main/BUILD

  rm -f $tmp_dir/build.gradle

  rm_Dockerfile $tmp_dir
}

function log_path() {
  #statements
  local file=$1
  local old="\/app"
  local new="\/src\/workspace"

  sed -i "s/${old}/${new}/" $file
}
d=$1

for e in `find $d -type d -name bin`; do
  #statements
  create_bazel_wrkspace $d $e

  log_path $e/src/main/java/example/Main.java

  if [[ -e $e/src/main/java/example/dto/Dog.java ]]; then
    #statements
    log_path $e/src/main/java/example/dto/Dog.java
  else
    log_path $e/src/main/java/example/dto/Generic.java
  fi
done
