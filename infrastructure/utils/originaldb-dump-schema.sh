#!/bin/bash
set -euo pipefail

ORIGINAL_POSTGRES_HOST="test-pg-bdp.co90ybcr8iim.eu-west-1.rds.amazonaws.com"
ORIGINAL_POSTGRES_USERNAME="pmoser"
ORIGINAL_POSTGRES_DB="bdp"
ORIGINAL_POSTGRES_SCHEMA="intimev2"
ODH_DOMAIN="mobility"
OUTPUT="../../sql/V6__mobility_initial_setup.sql"

TMP_FILE="orig-database-$ODH_DOMAIN-schemadump.sql"

echo "# Starting pg_dump of $ORIGINAL_POSTGRES_USERNAME@$ORIGINAL_POSTGRES_HOST/$ORIGINAL_POSTGRES_DB/$ORIGINAL_POSTGRES_SCHEMA"

echo "
--
-- Database Schema Dump of '$ORIGINAL_POSTGRES_HOST/$ORIGINAL_POSTGRES_DB/$ORIGINAL_POSTGRES_SCHEMA'
--
-- Please use the script infrastructure/utils/originaldb-dump-schema.sh to update this dump
--
" > "$TMP_FILE"

pg_dump \
    -v \
    --host="$ORIGINAL_POSTGRES_HOST" \
    --username="$ORIGINAL_POSTGRES_USERNAME" \
    --schema="$ORIGINAL_POSTGRES_SCHEMA" \
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
    sed -e "s/$ORIGINAL_POSTGRES_SCHEMA\.//g" | \
    grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON\ EXTENSION|CREATE\ SCHEMA)' | \
    grep -v -e '^--.*$' | \
    grep -v -e '^[[:space:]]*$' >> "$TMP_FILE"

cat "$TMP_FILE" > "$OUTPUT"
rm "$TMP_FILE"
echo "# Updating $OUTPUT"
echo "> READY."
exit 0