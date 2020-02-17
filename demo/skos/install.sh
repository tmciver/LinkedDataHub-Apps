#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage:   $0 $base $cert_pem_file $cert_password" >&2
  echo "Example: $0" 'https://localhost:4443/ ../../../LinkedDataHub/certs/owner.pem Password' >&2
  echo "Note: special characters such as $ need to be escaped in passwords!" >&2
  exit 1
fi

base="$1"
cert_pem_file=$(realpath -s "$2")
cert_password="$3"

pushd . && cd ./admin

printf "\n### Creating authorization to make the app public\n\n"

./make-public.sh "$base" "$cert_pem_file" "$cert_password"

cd model

printf "\n### Creating constructor queries\n\n"

./create-constructors.sh "$base" "$cert_pem_file" "$cert_password"

printf "\n### Creating classes\n\n"

./create-classes.sh "$base" "$cert_pem_file" "$cert_password"

printf "\n### Creating constraints\n\n"

./create-constraints.sh "$base" "$cert_pem_file" "$cert_password"

printf "\n### Creating restrictions\n\n"

./create-restrictions.sh "$base" "$cert_pem_file" "$cert_password"

popd

pushd . && cd ./admin

printf "\n### Clearing ontologies\n\n"

./clear-ontologies.sh "$base" "$cert_pem_file" "$cert_password"

popd

printf "\n### Creating containers\n\n"

./create-containers.sh "$base" "$cert_pem_file" "$cert_password"