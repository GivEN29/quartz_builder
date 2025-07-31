#!/usr/bin/env bash
set -e

# If /quartz is empty (i.e. first time), clone & install
if [ ! -d /quartz/.git ]; then
  echo "⚙️  Initializing /quartz…"
  git clone https://github.com/jackyzha0/quartz.git /quartz
  cd /quartz
  npm install
else
  echo "✅  /quartz already initialized"
fi

# Exec the normal command (so CMD still works)
exec "$@"
