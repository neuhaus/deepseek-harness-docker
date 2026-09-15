#!/usr/bin/env sh

set -eu

port=${DSH_WEB_PORT:-3080}
# dsh serves a 401 for unauthenticated index requests; either 200 or 401
# proves the web server is up.
code=$(curl --silent --show-error --max-time 3 \
  --output /dev/null --write-out '%{http_code}' \
  "http://127.0.0.1:${port}/")
case "$code" in
  200 | 401) exit 0 ;;
  *) exit 1 ;;
esac
