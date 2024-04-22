#!/bin/sh
echo -ne '\033c\033]0;Who Killed Cris\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Who Killed Cris.x86_64" "$@"
