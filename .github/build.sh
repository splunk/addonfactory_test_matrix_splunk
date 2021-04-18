#!/usr/bin/env bash

find packages -type f -name app.* -exec sed -i -e "s/0.0.0/${1}/g" {} +
find packages -type d -name default -exec ./.github/package.sh {} \;