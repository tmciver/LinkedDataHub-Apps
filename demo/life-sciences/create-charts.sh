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

pwd=$(realpath -s $PWD)

pushd . && cd "$SCRIPT_ROOT"

query=$(
./create-select.sh  \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Molecule logp" \
--query-file "${pwd}/queries/molecule-logp.rq" \
--endpoint https://www.ebi.ac.uk/rdf/services/sparql
)

./create-result-set-chart.sh \
-b "$base" \
-f "$cert_pem_file" \
-p "$cert_password" \
--title "Partition coefficients" \
--endpoint https://www.ebi.ac.uk/rdf/services/sparql \
--query "$query" \
--chart-type https://w3id.org/atomgraph/client#BarChart \
--category-var-name "mol_name" \
--series-var-name "logp_val"

popd