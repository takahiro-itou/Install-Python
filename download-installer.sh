#!/bin/bash  -xue

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")

source  "${script_dir}/config.rc"

##################################################################
##
##    1.  引数チェック
##

target_version=$1


##################################################################
##
##    2.  パッケージをダウンロード
##

download_url_base='https://www.python.org/ftp/python'
archive_name="Python-${target_version}.tgz"
download_url="${download_url_base}/${target_version}/${archive_name}"
