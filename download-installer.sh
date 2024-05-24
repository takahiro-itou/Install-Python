#!/bin/bash  -xue

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")

source  "${script_dir}/config.rc"

##################################################################
##
##    1.  引数チェック
##

target_version=$1
