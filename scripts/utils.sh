#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPTS_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")

# shellcheck source=./colors.sh
. "${SCRIPTS_DIR}/colors.sh"

VERSION=0.3.1

function not_installed() {
  [ ! -x "$(command -v "$@")" ]
}

function ask_for_sudo() {
  # Ask for the administrator password upfront.
  sudo -v &>/dev/null

  # Update existing `sudo` time stamp
  # until this script has finished.
  #
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &>/dev/null &
}