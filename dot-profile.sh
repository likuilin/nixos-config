#!/bin/bash

alias persist-check="sudo du -x / | grep -v ^0"
alias dc="docker compose"

# edge case, incoming ssh with x forwarding causes DISPLAY to be set but XAUTHORITY to not be set
# instead, ~/.Xauthority is used and i'm not sure if sshd (or is this in the wm?) can be configured
# to set $XAUTHORITY instead. so, only copy from systemctl env if both are unset
if [ -z "$XAUTHORITY" -a -z "$DISPLAY" ]; then
  export $(systemctl --user show-environment | grep -e ^XAUTHORITY= -e ^DISPLAY=);
fi
