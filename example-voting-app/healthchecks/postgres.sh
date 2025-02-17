#!/bin/sh
set -e -o pipefail

host="$(hostname -i || echo '127.0.0.1')"
user="${POSTGRES_USER:-postgres}"
db="${POSTGRES_DB:-$POSTGRES_USER}"
export PGPASSWORD="${POSTGRES_PASSWORD:-}"

args="--host "$host" --username "$user" --dbname "$db" --quiet --no-align --tuples-only"

if select="$(echo 'SELECT 1' | psql $args)" && [ "$select" = '1' ]; then
	exit 0
fi

exit 1
