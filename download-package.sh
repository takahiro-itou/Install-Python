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
installer_file="${installer_dir}/${archive_name}"

if [[ ! -f "${installer_file}" ]] ; then
    # ファイルを持っていないのでダウンロードする
    pushd "${installer_dir}"
    wget "${download_url}"
    popd
fi

if [[ ! -f "${installer_file}" ]] ; then
    echo "FATAL : Installer file ${installer_file} is NOT available!!"  1>&2
    exit  2
fi
