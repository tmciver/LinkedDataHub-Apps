#!/bin/bash

[ -z "$SCRIPT_ROOT" ] && echo "Need to set SCRIPT_ROOT" && exit 1;

if [ "$#" -ne 3 ]; then
  echo "Usage:   $0 $base $cert_pem_file $cert_password" >&2
  echo "Example: $0" 'https://linkeddatahub.com/atomgraph/app/ ../../../certs/martynas.localhost.pem Password' >&2
  echo "Note: special characters such as $ need to be escaped in passwords!" >&2
  exit 1
fi

base="$1"
cert_pem_file=$(realpath -s "$2")
cert_password="$3"

pushd . && cd "$SCRIPT_ROOT"

parent=$(
./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Copenhagen" \
--slug "copenhagen" \
--parent "$base" \
"$base"
)

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Places" \
--slug "places" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Bicycle parkings" \
--slug "bicycle-parkings" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Charging stations" \
--slug "charging-stations" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Libraries" \
--slug "libraries" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Parking facilities" \
--slug "parking-facilities" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Playgrounds" \
--slug "playgrounds" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Schools" \
--slug "schools" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Sport centers" \
--slug "sports-centers" \
--parent "$parent" \
"$parent"

./create-container.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Public toilets" \
--slug "public-toilets" \
--parent "$parent" \
"$parent"

popd