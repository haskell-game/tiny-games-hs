#!/usr/bin/env sh

settings="$1"
if [ -z "$settings" ]
then
    echo "Usage: `basename $0` [settings]"
    echo "Available settings:"
    echo *.env
    exit 1
else
    . ./"$settings"
fi

export before_depth="$(($depth - 1))"
export after_depth="$(($depth + 1))"
target=swish."${settings%.env}".hs

envsubst < swish.hs > swish.envsubst.hs
cabal ../../minify.hs --source swish.envsubst.hs --target "$target"
chmod +x "$target"
