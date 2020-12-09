CREATE SUBSCRIPTION ${mobility_subscription_name}
CONNECTION 'host=${mobility_ip} dbname=${mobility_db} user=${mobility_user} password=${mobility_password}'
PUBLICATION ${mobility_publication_name}
WITH (enabled = false);
