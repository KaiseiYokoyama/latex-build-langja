#!/bin/sh

set -e

root_file="$1"
working_directory="$2"
compiler="$3"
args="$4"
extra_tex_package="$5"

if [ -n "$extra_tex_package" ]; then
  tlmgr update --self --all
  for pkg in $extra_tex_package; do
    echo "Install $pkg by apt"
    tlmgr install "$pkg"
  done
fi

echo "Install BXcoloremoji"
git clone https://github.com/zr-tex8r/BXcoloremoji.git
cp -r BXcoloremoji/emoji_images emoji_images
cp BXcoloremoji/bxcoloremoji.sty bxcoloremoji.sty
cp BXcoloremoji/bxcoloremoji-names.def bxcoloremoji-names.def

if [ -n "$working_directory" ]; then
  cd "$working_directory"
fi

"$compiler" $args "$root_file"
