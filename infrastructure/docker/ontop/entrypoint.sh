#!/bin/bash

set -xeo pipefail

echo "### Entrypoint - Run Flyway Migrations"
for dir in /opt/ontop/sql/*; do
    if [ -d "$dir" ]; then
        echo "# Migrating schema in directory '$dir'."
        /usr/local/bin/flyway -locations=filesystem:"/opt/ontop/sql/$dir" -schemas="$dir" migrate
    fi 
done

echo "### Entrypoint - Starting Ontop Endpoint"
/opt/ontop/entrypoint.sh
