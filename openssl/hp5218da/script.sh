#!/usr/bin/env zsh

# Generate a certificate signing request (CSR) and private key.
openssl req -out ca.csr -new -noenc -keyout printer-key.pem \
  -subj "/CN=HP5218DA/L=<city>/ST=<state>/C=MY/O=HP/OU=HP-IPG"

# Sign the CSR using the CA to produce a signed certificate.
openssl x509 -in ca.csr -req -out printer-cert.pem \
  -days 1095 -extfile _domains.ext \
  -CA ~/pki/myca/cacert.pem \
  -CAkey ~/pki/myca/private/cakey.pem \
  -CAserial ~/pki/myca/cacert.srl
#  -CAcreateserial

# Convert both cert and key to PKCS12
openssl pkcs12 -export -out printer-cert.pfx \
  -inkey printer-key.pem -in printer-cert.pem  
