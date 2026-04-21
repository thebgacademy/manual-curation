#!/usr/bin/env bash
# Wait for an XFCE desktop indicator (xfce4-panel) and a DISPLAY to be available,
# then open xfce4-terminal to run the user setup script.
set -euo pipefail

# Path to the user setup script
SETUP_SCRIPT="/home/kasm-user/_setup_and_intro.sh"

# Maximum time to wait (seconds)
MAX_WAIT=60
WAITED=0

# Wait for DISPLAY socket and xfce4-panel (indicates the desktop is up).
while true; do
  # Ensure DISPLAY is set or X socket exists
  if [ -n "${DISPLAY:-}" ] || [ -e "/tmp/.X11-unix/X0" ]; then
    # Check for xfce4-panel process (desktop present)
    if pgrep -x xfce4-panel >/dev/null 2>&1; then
      break
    fi
  fi
  sleep 1
  WAITED=$((WAITED + 1))
  if [ "$WAITED" -ge "$MAX_WAIT" ]; then
    # give up and try anyway
    break
  fi
done

# Run the setup script in a new xfce4-terminal window and keep terminal open.
# Use a shell -c wrapper for robust quoting.
xfce4-terminal --hold --command="/bin/bash -lc '\"$SETUP_SCRIPT\"; exec /bin/bash -i'" >/dev/null 2>&1 &

exit 0
