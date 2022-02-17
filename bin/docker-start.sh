#!/bin/bash
# AUTHOR: UMIT AYDIN

# Tells Bash to show errors and bail early
set +e

echo "~~~~~~~~~~~~~~~~~~~~ Attempting to migrate the Database ~~~~~~~~~~~~~~~~~~~~~~~"
bin/rails db:migrate 2>/dev/null
RET=$?
set -e
if [ $RET -gt 0 ]; then
echo "~~~~~~~~~~~~~~~~~~~~ Migration failed; creating new database ~~~~~~~~~~~~~~~~~~~"
bin/rails db:create

echo "~~~~~~~~~~~~~~~~~~~~ Migrating database ~~~~~~~~~~~~~~~~~~~"
bin/rails db:migrate
bin/rails db:test:prepare

echo "~~~~~~~~~~~~~~~~~~~~ Seeding database ~~~~~~~~~~~~~~~~~~~"
bin/rails db:seed
fi
echo "~~~~~~~~~~~~~~~~~~~~ Removing old server PID ~~~~~~~~~~~~~~~~~~~"
rm -f tmp/pids/server.pid
echo "~~~~~~~~~~~~~~~~~~~~ Starting web server ~~~~~~~~~~~~~~~~~~~"
bin/rails server -p 3000 -b "0.0.0.0"