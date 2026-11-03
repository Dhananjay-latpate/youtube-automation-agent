#!/bin/sh
set -eu
# Keep SQLite, generated media, and OAuth credentials on the Railway volume.
for directory in data config uploads logs; do
  mkdir -p "/persist/$directory"
  if [ -d "/app/$directory" ] && [ ! -L "/app/$directory" ]; then
    cp -an "/app/$directory/." "/persist/$directory/"
    rm -rf "/app/$directory"
  fi
  ln -sfn "/persist/$directory" "/app/$directory"
done
exec "$@"
