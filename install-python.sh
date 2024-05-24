#!/bin/bash  -xue

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")

source  "${script_dir}/config.rc"

##################################################################
##
##    1.  引数チェック
##

target_version=$1
: ${install_base_dir:=$2}


##################################################################
##
##    2.  ビルド環境の確認
##

openssl_bin_dir=$(dirname "$(which openssl)")
openssl_dir=$(readlink -f "${openssl_bin_dir}/..")

echo "OpenSSL Dir = ${openssl_dir}"     1>&2

pwd
echo "${CC:='gcc'}"
echo "${CXX:='g++'}"

which gcc
gcc --version
sleep  5
