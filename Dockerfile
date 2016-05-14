FROM java:8-jre-alpine
ENV ALLUXIO_VERSION 1.0.1

RUN apk add --no-cache --virtual .fetch-deps curl 
RUN apk add --no-cache bash
RUN apk add --no-cache openssh
RUN apk add --no-cache procps
RUN set -ex \ 
	&& mkdir -p /root/.ssh \
	&& ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa \
	&& chmod 600 /root/.ssh/id* \
	&& cp /root/.ssh/id_rsa /etc/ssh/ssh_host_key \
	&& cp /root/.ssh/id_rsa /etc/ssh/ssh_host_rsa_key \
	&& cp /root/.ssh/id_rsa /etc/ssh/ssh_host_ecdsa_key \
	&& cp /root/.ssh/id_rsa /etc/ssh/ssh_host_dsa_key \
	&& cp /root/.ssh/id_rsa /etc/ssh/ssh_host_ed25519_key \
	&& cat /root/.ssh/id_rsa.pub >>/root/.ssh/authorized_keys \ 
	&& echo "localhost" $(cat /root/.ssh/id_rsa.pub | cut -d ' ' -f 1-2) >>/root/.ssh/known_hosts

# RUN curl -fSL http://alluxio.org/downloads/files/${ALLUXIO_VERSION}/alluxio-${ALLUXIO_VERSION}-bin.tar.gz -o alluxio.tar.gz
ADD alluxio-1.0.1-bin.tar.gz /usr/local

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 22 19999

CMD ["bash"]
