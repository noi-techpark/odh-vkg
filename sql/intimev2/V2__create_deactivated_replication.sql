CREATE SUBSCRIPTION ${mobility_subscription_name}
CONNECTION 'host=${mobility_host} dbname=${mobility_db} user=${mobility_user} password=${mobility_password}'
PUBLICATION ${mobility_publication_name}
WITH (enabled = true);
