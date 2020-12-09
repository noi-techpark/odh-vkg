#!/bin/bash

set -xeo pipefail

echo "### Entrypoint - Run Flyway Migrations"
for file in /opt/ontop/sql/*; do
    if [ -d "$file" ]; then
        dir=$(basename "$file")
        echo "# Migrating schema '$dir'."
        /usr/local/bin/flyway -X -locations=filesystem:"/opt/ontop/sql/$dir" -schemas="$dir" migrate
    fi 
done

echo "### Entrypoint - Starting Ontop Endpoint"
/opt/ontop/entrypoint.sh
