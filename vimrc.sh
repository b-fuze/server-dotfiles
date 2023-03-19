#!/bin/bash

# This script downloads my .vimrc and its dependent
# .vim directory containing all of its vendored plugins
# and sets it up

set -e

tarball_url=https://b-fuze.dev/vimrc.tar.gz
dl_command_list=(curl wget busybox)
dl_command=
script=vimrc.sh

for cmd in "${dl_command_list[@]}"; do
  if which "$cmd" &> /dev/null; then
    if [[ $cmd = busybox ]] && ! ("$cmd" wget --help) &> /dev/null; then
      continue
    fi

    dl_command=$cmd
    break
  fi
done

if [[ ! $dl_command ]]; then
  echo "$script: error: either \`curl\` or \`wget\` required" >&2
  exit 1
fi

(
  cd # go to home dir
  case $dl_command in
    curl ) curl -sL "$tarball_url" ;;
    wget ) wget -qO - "$tarball_url" ;;
    busybox ) busybox wget -qO - "$tarball_url" ;;
  esac | tar xfz -

  echo "Done"
)