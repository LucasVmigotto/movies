CREATE TYPE permission_type AS ENUM ('admin', 'viewer');
CREATE TYPE permission_type AS ENUM ('action', 'comedy', 'drama', 'fantasy', 'horror', 'mystery', 'romance', 'thriller');
CREATE TYPE transaction_type AS ENUM ('create', 'update', 'delete');

CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL,
    display_name VARCHAR(64) NOT NULL,
    permission permission_type DEFAULT 'viewer'
);
CREATE TRIGGER users_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW EXECUTE PROCEDURE audit_table_data();


CREATE TABLE IF NOT EXISTS logins (
    login_id SERIAL,
    username VARCHAR(24) NOT NULL,
    pswd VARCHAR(256) NOT NULL,
    user_id INTEGER NOT NULL,
    CONSTRAINT logins_user_id_foreign_key
        FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TRIGGER logins_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON logins
    FOR EACH ROW EXECUTE PROCEDURE audit_table_data();

CREATE TABLE IF NOT EXISTS movies (
    movie_id SERIAL,
    title VARCHAR(64) NOT NULL,
    year INTEGER(4) DEFAULT NULL
);
CREATE TRIGGER movies_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON movies
    FOR EACH ROW EXECUTE PROCEDURE audit_table_data();

CREATE TABLE IF NOT EXISTS audit_tables_transactions (
    audit_id SERIAL,
    table_name VARCHAR(64) NOT NULL,
    user_id INTEGER,
    action transaction_type NOT NULL,
    new_values JSONB DEFAULT NULL,
    old_values JSONB DEFAULT NULL,
    action_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
