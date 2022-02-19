CREATE OR REPLACE FUNCTION audit_table_data()
    RETURNS TRIGGER AS $audit_table_data_trigger$
    BEGIN

        IF (TG_OP = 'INSERT') THEN

            EXECUTE
                'INSERT INTO '
                || 'audit_tables ('
                || '    table_name,'
                || '    action,'
                || '    user_id,'
                || '    new_values'
                || ') VALUES ('
                || '    $1,'
                || '    $2,'
                || '    $3,'
                || '    $4'
                || ')'
            USING
                TG_TABLE_NAME,
                LOWER(TG_OP),
                NEW.last_interacted_by,
                ROW_TO_JSON(NEW);

            RETURN NEW;

        ELSEIF (TG_OP = 'UPDATE') THEN

            EXECUTE
                'INSERT INTO '
                || '.audit_tables ('
                || '    table_name,'
                || '    action,'
                || '    user_id,'
                || '    old_values,'
                || '    new_values'
                || ') VALUES ('
                || '    $1,'
                || '    $2,'
                || '    $3,'
                || '    $4,'
                || '    $5'
                || ')'
            USING
                TG_TABLE_NAME,
                LOWER(TG_OP),
                NEW.last_interacted_by,
                ROW_TO_JSON(OLD),
                ROW_TO_JSON(NEW);

        ELSEIF (TG_OP = 'DELETE') THEN

            EXECUTE
                'INSERT INTO '
                || '.audit_tables ('
                || '    table_name,'
                || '    audit_action,'
                || '    old_value'
                || ') VALUES ('
                || '    $1,'
                || '    $2,'
                || '    $3'
                || ')'
            USING
                TG_TABLE_NAME,
                LOWER(TG_OP),
                ROW_TO_JSON(OLD);

            RETURN OLD;

        END IF;

        RETURN NULL;

    END;

$audit_table_data_trigger$ LANGUAGE plpgsql;
