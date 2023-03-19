#!/bin/bash

dist_tarball_filename=vim-dotfiles.tar.gz
script_path=$(readlink -f "${BASH_SOURCE[0]}")
dist_dir_name=dist
dist_dir_path=$(readlink -f "${script_path%/*}/../$dist_dir_name")

(
  cd "$dist_dir_path/.."

  vim_files=()
  for file in .vim*; do
    case $file in
      .viminfo ) ;;
      * ) vim_files+=("$file") ;;
    esac
  done

  tar cfz "$dist_dir_name/$dist_tarball_filename" "${vim_files[@]}"
  echo "Done"
)