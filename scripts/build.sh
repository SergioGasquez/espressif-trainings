#!/bin/bash

# Gitpod and VsCode Codespaces tasks do not source the user environment
if [ "${USER}" == "gitpod" ]; then
    # which idf.py >/dev/null || {
        source ~/export-esp.sh
    # }
else
    # which idf.py >/dev/null || {
        source ~/export-esp.sh
    # }
fi

case "$1" in
"" | "release")
    ~/.cargo/bin/cargo build --release
    ;;
"debug")
    ~/.cargo/bin/cargo build
    ;;
*)
    echo "Wrong argument. Only \"debug\"/\"release\" arguments are supported"
    exit 1
    ;;
esac
