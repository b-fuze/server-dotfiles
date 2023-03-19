#!/bin/bash

set -e

script_path=$(readlink -f "${BASH_SOURCE[0]}")
vim_bundle_dir_path=$(readlink -f "${script_path%/*}/../.vim/bundle")
git_plugin_sha1_remote_list=$vim_bundle_dir_path/git-plugin-sha1-remotes.txt

(
  cd "$vim_bundle_dir_path"
  for plugin in *; do
    plugin_git_dir=$plugin/.git
    if [[ -d $plugin_git_dir ]]; then
      (
        cd "$plugin"
        printf "%s/%s/%s\n" "$plugin" "$(git rev-parse --short HEAD)" "$(git remote get-url origin)"
      ) >> "$git_plugin_sha1_remote_list"
      rm -rf "$plugin_git_dir"
    fi
  done

  echo "Done"
)