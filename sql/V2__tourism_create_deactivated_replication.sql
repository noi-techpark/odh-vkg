SELECT pg_catalog.set_config('search_path', '${tourism_schema_vkg}', false);
CREATE SUBSCRIPTION ${tourism_subscription_name}
CONNECTION 'host=${tourism_ip} dbname=${tourism_db} user=${tourism_user} password=${tourism_password}'
PUBLICATION ${tourism_publication_name}
WITH (enabled = false);
