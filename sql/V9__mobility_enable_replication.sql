SELECT pg_catalog.set_config('search_path', '${mobility_schema_vkg}', false);
ALTER SUBSCRIPTION ${mobility_subscription_name} ENABLE;
