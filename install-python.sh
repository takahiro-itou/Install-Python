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
##    2.  ファイルの確認とダウンロード
##

dlpinfo_file=$(mktemp dlpinfo.XXXXXXXX)
/bin/bash -xue "${script_dir}/download-package.sh" "${target_version}"  \
    | tee "${dlpinfo_file}"
eval $(cat "${dlpinfo_file}")


##################################################################
##
##    3.  ビルド環境の確認
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


##################################################################
##
##    4.  対象ディレクトリに python をインストール
##

python_configure_opts="--with-openssl=${openssl_dir}"
python_configure_opts+=' --with-ssl-default-suites=openssl'

export  PYTHON_CONFIGURE_OPTS=${python_configure_opts}
export  LDFLAGS="-Wl,-rpath,${openssl_dir}/lib"

mkdir -p "${install_base_dir}/builds"
pushd "${install_base_dir}/builds"
tar -xzf "${installer_file}"
cd "Python-${target_version}"

./configure  \
    --prefix="${target_prefix}"  \
    --enable-optimizations  \
    ${python_configure_opts}  \
    ;
make -j 2
make install
popd
