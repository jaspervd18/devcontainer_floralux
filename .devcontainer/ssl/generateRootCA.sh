#!/bin/bash

# Define variables
path=$(dirname "$0")
outputPath=$path/../../tools/ssl/generated

# Generate a new private key (rootCA.key) with a length of 2048 bits
openssl genrsa -out $outputPath/rootCA.key 2048

# Create a self-signed X.509 certificate (rootCA.crt) for the root CA using the private key (rootCA.key)
# Set the validity period to 365 days and use SHA256 for the signature algorithm
openssl req -x509 -new -nodes -key $outputPath/rootCA.key -sha256 -days 365 -out $outputPath/rootCA.crt -config $path/localhost.config