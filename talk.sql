-- To run this command whenever you save in Vim, run:
-- :autocmd BufWritePost talk.sql call jobstart('psql -1 -f talk.sql parrot')

-- Set up permissions

-- CREATE ROLE parrot_super WITH LOGIN PASSWORD 'SUPER_SECRET_PASSWORD';
-- CREATE ROLE parrot_authenticator WITH LOGIN PASSWORD 'ANOTHER_PASSWORD' NOINHERIT;
-- CREATE ROLE parrot_viewer;
-- GRANT parrot_viewer TO parrot_authenticator;
-- CREATE DATABASE parrot OWNER parrot_super;
-- REVOKE ALL ON DATABASE parrot FROM public;
-- GRANT CONNECT ON DATABASE parrot TO parrot_super;
-- GRANT CONNECT ON DATABASE parrot TO parrot_authenticator;
-- GRANT ALL ON DATABASE parrot TO parrot_super;

-- Clear out any existing database

DROP SCHEMA IF EXISTS app_public CASCADE;

-- Create a container for our public data

CREATE SCHEMA app_public;

-- Now we can boot up PostGraphQL:
-- `postgraphql -c postgres://parrot_authenticator:ANOTHER_PASSWORD@localhost/parrot --schema app_public`

-- But we want watch mode, so we need to be a superadmin
-- `postgraphql -c postgres://ROOT_USER:ROOT_PASSWORD@localhost/parrot --schema app_public --watch`

-- Now back to the previous command (ignore the warning)
-- `postgraphql -c postgres://parrot_authenticator:ANOTHER_PASSWORD@localhost/parrot --schema app_public`

-- Open GraphiQL, pretty empty so far! Let's do something about that!

CREATE TABLE app_public.users (
  id serial PRIMARY KEY,
  username varchar NOT NULL UNIQUE CHECK(username ~ '^[a-z][a-z0-9_]+$'),
  full_name text
);
