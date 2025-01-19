#!/usr/bin/env sh
	pkg update -qy
	pkg install -qy --show-progress curl grep wget coreutils build-essential gawk sharutils p7zip \
		gzip cpio bzip2 liblz4 liblzma xz-utils lzop \
		libxml2 python aria2 brotli zstd openssl

	_file="$(find $PREFIX/lib/python3.1* -name "_sysconfigdata*.py")"
	rm -rf $PREFIX/lib/python3.11/__pycache__
	cp $_file "$_file".backup
	sed -i 's|-fno-openmp-implicit-rpath||g' "$_file"

if [ $? -eq 0 ]; then
	wget -q -O get-pip.py https://bootstrap.pypa.io/get-pip.py
	python3 get-pip.py --upgrade --disable-pip-version-check --no-cache-dir
	rm -f get-pip.py
	pip3 install future requests humanize clint backports.lzma lz4 zstandard protobuf pycryptodome docopt
fi
