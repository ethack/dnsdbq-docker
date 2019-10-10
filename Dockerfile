FROM debian:8 as builder

ARG DNSDBQ_RELEASE=v1.4.0

RUN apt-get update && apt-get install -y \
    build-essential \
    libcurl4-openssl-dev \
    libjansson-dev \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
  wget https://github.com/dnsdb/dnsdbq/archive/${DNSDBQ_RELEASE}.tar.gz && \
  tar xzf ${DNSDBQ_RELEASE}.tar.gz --strip-components=1 && \
  make
  # These steps aren't needed due to multi-stage Dockerfile
  # make install && \
  # make clean && \
  # cd / && \
  # rm -rf ${DNSDBQ_RELEASE}*

FROM debian:8-slim

RUN apt-get update && apt-get install -y \
    libcurl3 \
    libjansson4 \
  && rm -rf /var/lib/apt/lists/*

# mimic "make install"
COPY --from=builder /tmp/dnsdbq /usr/local/bin/
COPY --from=builder /tmp/dnsdbq.man /usr/local/share/man/man1/dnsdbq.1

COPY docker-entrypoint.sh /bin/

ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD ["-h"]
