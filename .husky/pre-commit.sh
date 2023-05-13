#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx hexo clean && hexo generate && git add . && git config --global --unset http.proxy && git config --global --unset https.proxy