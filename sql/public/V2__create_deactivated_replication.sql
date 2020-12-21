CREATE SUBSCRIPTION ${tourism_subscription_name}
CONNECTION 'host=${tourism_host} dbname=${tourism_db} user=${tourism_user} password=${tourism_password}'
PUBLICATION ${tourism_publication_name}
WITH (enabled = false);
