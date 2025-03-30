#!/bin/bash

alias persist-check="sudo du -x / | grep -v ^0"
alias dc="docker compose"

export GPG_TTY=$(tty)
