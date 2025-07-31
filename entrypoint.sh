#!/usr/bin/env bash
set -e

# If /quartz (the bind-mounted or named-volume path) is empty, seed it
if [ ! -d /quartz ] || [ -z "$(ls -A /quartz)" ]; then
  echo "⚙️  Initializing /quartz from build copy…"
  mkdir -p /quartz
  # move both visible and hidden (e.g. .git) files
  mv /quartz_build/* /quartz/ 2>/dev/null || true
  mv /quartz_build/.[!.]* /quartz/ 2>/dev/null || true
  # clean up
  rm -rf /quartz_build
else
  echo "✅  /quartz already initialized, skipping."
fi

# exec the normal CMD
exec "$@"
