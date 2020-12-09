SELECT pg_catalog.set_config('search_path', '${tourism_schema_vkg}', false);
ALTER SUBSCRIPTION ${tourism_subscription_name} ENABLE;
