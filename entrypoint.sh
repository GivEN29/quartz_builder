#!/usr/bin/env bash
set -e

# If quartz.config.ts doesn't exist, populate /quartz from the build copy
if [ ! -f /quartz/quartz.config.ts ]; then
  echo "⚙️  Seeding /quartz from build copy…"
  mkdir -p /quartz
  # move all files (including hidden) from /quartz_build
  mv /quartz_build/*   /quartz/ 2>/dev/null || true
  mv /quartz_build/.[!.]* /quartz/ 2>/dev/null || true
  rm -rf /quartz_build
else
  echo "✅  quartz.config.ts found — skipping initialization."
fi

# Finally, exec whatever CMD you passed in
exec "$@"
