
This repo provides a docker image for [dnsdbq](https://github.com/dnsdb/dnsdbq). You can provide an API key either through the `APIKEY` environment variable or by mounting your own `.dnsdb-query.conf` file into the container.

- Code Repo: https://github.com/ethack/dnsdbq-docker
- Docker Repo: https://hub.docker.com/r/ethack/dnsdbq

**Tags**
- latest - Built on Debian.
- alpine - Built on Alpine. This required a minor patch to the dnsdbq source code.

**Pull**
```bash
docker pull ethack/dnsdbq
# or
docker pull ethack/dnsdbq:alpine
```

**Build**
```bash
docker build -t dnsdbq .
# or
docker build -f alpine.Dockerfile -t dnsdbq:alpine .
```

**Example Usage**
```bash
docker run --rm -e APIKEY=yourapikeyhere dnsdbq
```

```bash
cat /path/to/.dnsdb-query.conf
APIKEY=yourapikeyhere
```

```bash
docker run --rm -v /path/to/.dnsdb-query.conf:/root/.dnsdb-query.conf dnsdbq
```
