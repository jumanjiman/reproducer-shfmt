################################################################################
# Functions
################################################################################

PROG="$(basename "$0")"
readonly PROG

status() {
    declare -ri RC=$?

    if [[ ${RC} -ne 0 ]]; then
        err "exit status ${RC}: $*"
    fi
}

trap "status ${PROG}" EXIT

err() {
    echo
    echo "[ERROR] $*" >&2
    echo
    echo
}

info() {
    echo
    echo "[INFO] $*" >&2
}

run() {
    echo "[RUN] $*" >&2
    "$@"
    status "$*"
}
