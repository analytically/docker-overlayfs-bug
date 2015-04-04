FROM ubuntu:14.10

ADD test-unix-domain-socket.sh /etc/
ADD supervisord.conf /etc/

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qy python-dev curl \
    && curl -o - https://bootstrap.pypa.io/get-pip.py | python2.7 \
    && pip install supervisor \
    && chmod +x /etc/test-unix-domain-socket.sh

# Run supervisord when starting container
CMD ["/usr/local/bin/supervisord", "-k", "-c", "/etc/supervisord.conf"]
