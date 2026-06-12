#!/bin/sh

# Generate a certificate signing request (CSR) and private key.
openssl req -out printer.csr -new -newkey rsa:2048 -sha256 \
  -noenc -keyout printer-key.pem \
  -subj "/CN=HP5218DA/L=<City>/ST=<State>/C=MY/O=Hewlett-Packard/OU=HP-IPG"

# Sign the CSR using the CA to produce a signed certificate.
openssl x509 -in printer.csr \
  -req -sha256 -out printer-crt.pem \
  -days 365 -extfile config \
  -CA ../CA/cacert.pem \
  -CAkey ../CA/cakey.pem \
  -CAserial ../CA/cacert.srl

# Convert both cert and key to PKCS12
openssl pkcs12 -export -out printer-crt.pfx \
  -inkey printer-key.pem -in printer-crt.pem
