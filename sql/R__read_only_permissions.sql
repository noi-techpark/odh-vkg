GRANT USAGE ON SCHEMA ${tourism_schema_vkg} TO ${copy_user_readonly};
GRANT SELECT ON ALL TABLES IN SCHEMA ${tourism_schema_vkg} TO ${copy_user_readonly};
GRANT SELECT ON ALL SEQUENCES IN SCHEMA ${tourism_schema_vkg} TO ${copy_user_readonly};

GRANT USAGE ON SCHEMA ${mobility_schema_vkg} TO ${copy_user_readonly};
GRANT SELECT ON ALL TABLES IN SCHEMA ${mobility_schema_vkg} TO ${copy_user_readonly};
GRANT SELECT ON ALL SEQUENCES IN SCHEMA ${mobility_schema_vkg} TO ${copy_user_readonly};
