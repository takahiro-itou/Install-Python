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
    pushd "${installer_dir}"    1>&2
    wget "${download_url}"
    popd    1>&2
fi

if [[ ! -f "${installer_file}" ]] ; then
    echo "FATAL : Installer file ${installer_file} is NOT available!!"  1>&2
    exit  2
fi

if ! tar -tf "${installer_file}" 1> /dev/null ; then
    echo "FATAL : Installer ile ${installer_file} is NOT valid!!"   1>&2
    exit  2
fi


##################################################################
##
##    3.  必要な情報を標準出力に書き込む
##

echo  "installer_file=${installer_file}"
