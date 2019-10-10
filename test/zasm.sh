#!/bin/sh

# wrapper around ./emul/zasm/zasm that prepares includes CFS prior to call
DIR=$(dirname $(readlink -f "$0"))
ZASMBIN="${HOME}/.local/bin/zasm"
CFSPACK="${HOME}/.local/bin/cfspack"
INCCFS=$(mktemp)

for p in "$@"; do
    "${CFSPACK}" "${p}" "*.h" >> "${INCCFS}"
    "${CFSPACK}" "${p}" "*.asm" >> "${INCCFS}"
done

"${ZASMBIN}" "${INCCFS}"
RES=$?
rm "${INCCFS}"
exit $RES
