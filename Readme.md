
This repo provides a docker image for [dnsdbq](https://github.com/dnsdb/dnsdbq). You can provide an API key either through the `APIKEY` environment variable or by mounting your own `.dnsdb-query.conf` file into the container.

Build Command:
```bash
docker build -t dnsdbq .
# or
docker build -f alpine.Dockerfile -t dnsdbq:alpine .
```


Example Usage:
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
