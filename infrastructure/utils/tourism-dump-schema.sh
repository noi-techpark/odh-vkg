#!/bin/bash
set -euo pipefail

ORIGINAL_POSTGRES_HOST="prod-postgres-tourism-2.co90ybcr8iim.eu-west-1.rds.amazonaws.com"
ORIGINAL_POSTGRES_USERNAME="pmoser"
ORIGINAL_POSTGRES_DB="tourism"

echo "# Starting pg_dump of $ORIGINAL_POSTGRES_USERNAME@$ORIGINAL_POSTGRES_HOST/$ORIGINAL_POSTGRES_DB"

echo "
--
-- Tourism Database Schema Dump
--
-- Please use the script infrastructure/utils/tourism-dump-schema.sh to update this dump
--
" > orig-tourism-dump.sql

pg_dump \
    -v \
    --host="$ORIGINAL_POSTGRES_HOST" \
    --username="$ORIGINAL_POSTGRES_USERNAME" \
    --no-acl \
    --no-owner \
    --no-publications \
    --no-subscriptions \
    --no-comments \
    --schema-only \
    "$ORIGINAL_POSTGRES_DB" | \
    grep -v -e '^SET .*$' | \
    grep -v -E 'll_to_earth' | \
    sed -z -e "s#)\nWITH (autovacuum_analyze_threshold='2E9'##g" | \
    grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON\ EXTENSION)' | \
    grep -v -e '^--.*$' | \
    grep -v -e '^[[:space:]]*$' >> orig-tourism-dump.sql

cat orig-tourism-dump.sql > ../../sql/V1__initial_setup.sql
rm orig-tourism-dump.sql
echo "# Updating sql/V1__initial_setup.sql"
echo "> READY."
exit 0