#!/bin/bash
set -x

json_out=`pwd`/errors.json
report_out=`pwd`/report

apt-get -y install debhelper autotools-dev dh-autoreconf file libncurses5-dev libevent-dev pkg-config libutempter-dev build-essential

sh autogen.sh
./configure CC=kcc LD=kcc CFLAGS="-fissue-report=$json_out"
make -j`nproc`
 
touch $json_out && rv-html-report $json_out -o $report_out
rv-upload-report $report_out
