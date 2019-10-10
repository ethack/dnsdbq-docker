#!/bin/sh

# Add the API key to the config file from the DNSDBQ_APIKEY envrionment variable
if ! grep -sq '^APIKEY=' ~/.dnsdb-query.conf && [ -n "$APIKEY" ]; then
	echo "APIKEY=$APIKEY" >> ~/.dnsdb-query.conf
fi

dnsdbq "$@"
