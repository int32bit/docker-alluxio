#!/bin/bash
set -ex

echo "root:alluxio" | chpasswd # update root  password
sed -i '/^root/c root:x:0:0:root:/root:/bin/bash' /etc/passwd # change root shell to bash
echo "PermitRootLogin yes" >>/etc/ssh/sshd_config # Permit root remote login

/usr/sbin/sshd # sshd re-exec requires execution with an absolute path

ALLUXIO_ROOT=/usr/local/alluxio-${ALLUXIO_VERSION}
export PATH=$ALLUXIO_ROOT/bin:$PATH
export ALLUXIO_UNDERFS_ADDRESS=/tmp
echo "export PATH=$ALLUXIO_ROOT/bin:$PATH" >>/root/.bashrc

cp ${ALLUXIO_ROOT}/conf/alluxio-env.sh.template ${ALLUXIO_ROOT}/conf/alluxio-env.sh
sed  -i 's/sudo//g' ${ALLUXIO_ROOT}/bin/alluxio-mount.sh # Remove 'sudo' because we use root and isn't installed on our environment

${ALLUXIO_ROOT}/bin/alluxio format
${ALLUXIO_ROOT}/bin/alluxio-start.sh local

exec "$@"
