#!/bin/bash
set +e
echo "[i] Migrating..."
bin/rails db:migrate @>/dev/null
RET=$?
set -e
if [$RET -gt 0]; then
    echo "[!] Migration FAILED; Re-creating Database!..."
    bin/rails db:create
    
        bin/rails db:migrate

    bin/rails db:test:prepare

echo "[i] Populating Database with fake data..."    
    bin/rails db:seed
fi

echo "[!] Removing old server PID!"
rm -f tmp/pids/server.pid

echo "[i] Starting Server!"
bin/rails server -p 3000 -b '0.0.0.0'