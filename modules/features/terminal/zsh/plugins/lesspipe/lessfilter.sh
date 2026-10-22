#! /usr/bin/env sh
# this is a example of .lessfilter, you can change it
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}
if [ -d "$1" ]; then
  ls -vF --color --group-directories-first "$1"
elif [ "$category" = image ] && command -v chafa >/dev/null 2>&1; then
  chafa "$1"
  exiftool "$1"
elif [ "$category" = text ]; then
  bat --color=always "$1"
else
  $ZPLUGINDIR/lesspipe.sh "$1" | bat --color=always
fi
