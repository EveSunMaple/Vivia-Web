#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx hexo generate && git add . && git config --global http.sslVerify "false"