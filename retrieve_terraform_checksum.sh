#!/bin/bash
version=$1
url="https://releases.hashicorp.com/terraform/${version}/terraform_${version}_SHA256SUMS"

if [[ -z "${version}" ]]; then
    echo "Terraform version not provided. Aborting.."
    exit 1
fi

echo "The script will retrieve SHA256 for the given version of Terraform and output it in YAML format"
echo

if curl --output /dev/null --silent --head --fail "${url}"; then
    echo -e "  '${version}':"
    curl -sL ${url} | sed -e "s/terraform_${version}_//; s/.zip//" | awk '{print "    "$2": sha256:"$1}'
else
    echo "Remote URL: ${url} cannot be found"
    exit 2
fi