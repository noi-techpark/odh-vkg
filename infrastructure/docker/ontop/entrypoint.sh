#!/bin/bash

set -xeo pipefail

echo "Entrypoint - Run Flyway Migrations"
/usr/local/bin/flyway -locations=filesystem:"${ONTOP_FLYWAY_MIGRATION_PATH}" migrate

echo "Entrypoint - Starting Ontop Endpoint"
/opt/ontop/entrypoint.sh
