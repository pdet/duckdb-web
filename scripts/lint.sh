#!/usr/bin/env bash

set -xeuo pipefail

fix=''
check=''
while getopts "f" opt; do
    case $opt in
        f) fix="--fix"
           check='--check --diff';;
        *) exit
    esac
done

npx markdownlint-cli docs/ dev/ _posts/ --config .markdownlint.jsonc --ignore docs/archive $fix

black scripts --skip-string-normalization $check

vale sync
vale docs/ dev/ _posts/ --glob "!docs/archive/*"
