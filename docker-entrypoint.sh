#!/bin/bash
set -ex

/usr/sbin/sshd

ALLUXIO_ROOT=/usr/local/alluxio-${ALLUXIO_VERSION}
export PATH=$ALLUXIO_ROOT/bin:$PATH
export ALLUXIO_UNDERFS_ADDRESS=/tmp

cp ${ALLUXIO_ROOT}/conf/alluxio-env.sh.template ${ALLUXIO_ROOT}/conf/alluxio-env.sh
sed  -i 's/sudo//g' ${ALLUXIO_ROOT}/bin/alluxio-mount.sh # Remove 'sudo' because we use root and isn't installed on our environment

${ALLUXIO_ROOT}/bin/alluxio format
${ALLUXIO_ROOT}/bin/alluxio-start.sh local

exec "$@"
