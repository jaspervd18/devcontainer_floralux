#!/bin/bash

# Define variables
path=$(dirname "$0")
outputPath=$path/../../tools/ssl/generated

# Generate a new private key (mydomain.key) with a length of 2048 bits
openssl genrsa -out $outputPath/mydomain.key 2048

# Create a new certificate signing request (mydomain.csr) using the private key (mydomain.key)
openssl req -new -key $outputPath/mydomain.key -out $outputPath/mydomain.csr -config $path/localhost.config

# Sign the CSR using the root CA certificate (rootCA.crt) and private key (rootCA.key)
# Set the validity period to 365 days and use SHA256 for the signature algorithm
openssl x509 \
  -req -in $outputPath/mydomain.csr \
  -CA $outputPath/rootCA.crt \
  -CAkey $outputPath/rootCA.key \
  -CAcreateserial \
  -out $outputPath/mydomain.crt \
  -days 365 \
  -sha256 \
  -extensions req_ext \
  -extfile $path/localhost.config

openssl pkcs12 \
  -export -out $outputPath/mydomain.pfx \
  -inkey $outputPath/mydomain.key \
  -in $outputPath/mydomain.crt \
  -certfile $outputPath/rootCA.crt \
  -passin pass:P@ssw0rd \
  -passout pass:P@ssw0rd

# View the contents of the signed certificate to verify the information
# openssl x509 -in mydomain.com.crt -text -noout