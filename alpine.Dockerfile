FROM alpine:3.9 as builder

ARG DNSDBQ_RELEASE=v1.4.0

RUN apk --no-cache add \
    make \
    g++ \
    curl-dev \
    jansson-dev

RUN cd /tmp && \
  wget https://github.com/dnsdb/dnsdbq/archive/${DNSDBQ_RELEASE}.tar.gz && \
  tar xzf ${DNSDBQ_RELEASE}.tar.gz --strip-components=1 && \
  # requires a patch to compile on alpine
  sed -i -e 's_^#include <sys/errno.h>$_#include <errno.h>_' dnsdbq.c && \
  make
  # These steps aren't needed due to multi-stage Dockerfile
  # make install && \
  # make clean && \
  # cd / && \
  # rm -rf ${DNSDBQ_RELEASE}*

FROM alpine:3.9

RUN apk --no-cache add \
    curl \
    jansson

# mimic "make install"
COPY --from=builder /tmp/dnsdbq /usr/local/bin/
COPY --from=builder /tmp/dnsdbq.man /usr/local/share/man/man1/dnsdbq.1

COPY docker-entrypoint.sh /bin/

ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD ["-h"]

