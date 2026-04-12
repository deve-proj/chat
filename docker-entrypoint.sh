#!/bin/bash
set -e

wait_for_postgres() {
  echo "Waiting for PostgreSQL to be ready..."
  while ! pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" 2>/dev/null; do
    echo "PostgreSQL is not ready yet. Sleeping..."
    sleep 1
  done
  echo "PostgreSQL is ready!"
}

run_migrations() {
  echo "Running database migrations..."
  ./bin/chat eval "Chat.Release.migrate()"
}

restore_rooms() {
  echo "Restoring rooms from database..."
  ./bin/chat eval "Chat.Release.restore_rooms()"
}

case "$1" in
  "start")
    wait_for_postgres
    run_migrations
    restore_rooms
    exec ./bin/chat start
    ;;
  "migrate")
    wait_for_postgres
    run_migrations
    ;;
  "restore")
    wait_for_postgres
    restore_rooms
    ;;
  *)
    exec "$@"
    ;;
esac