#!/bin/sh

#openssl req -out cacert.pem -newkey rsa:2048 -sha256 -noenc -keyout cakey.pem \
#  -x509 -days 365 -subj "/C=MY/CN=Local-Root-CA"

openssl req -out cacert.pem -sha256 -new -noenc -keyout cakey.pem \
  -x509 -days 3650 -config root-ca.cnf
