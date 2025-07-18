--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: Author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Author" (
    id text NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    bio text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    role text DEFAULT 'user'::text NOT NULL,
    "profilePic" text[]
);


ALTER TABLE public."Author" OWNER TO postgres;

--
-- Name: Comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comment" (
    id text NOT NULL,
    "videoId" text NOT NULL,
    "authorId" text NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Comment" OWNER TO postgres;

--
-- Name: CommentLike; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CommentLike" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "commentId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."CommentLike" OWNER TO postgres;

--
-- Name: FavoriteVideo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FavoriteVideo" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "videoId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."FavoriteVideo" OWNER TO postgres;

--
-- Name: Follow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Follow" (
    id text NOT NULL,
    "followerId" text NOT NULL,
    "followingId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Follow" OWNER TO postgres;

--
-- Name: Hashtag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Hashtag" (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Hashtag" OWNER TO postgres;

--
-- Name: Music; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Music" (
    id text NOT NULL,
    title text NOT NULL,
    artist text,
    url text NOT NULL,
    duration integer NOT NULL,
    thumbnail text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Music" OWNER TO postgres;

--
-- Name: Reply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Reply" (
    id text NOT NULL,
    "commentId" text NOT NULL,
    "authorId" text NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Reply" OWNER TO postgres;

--
-- Name: Video; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Video" (
    id text NOT NULL,
    "authorId" text NOT NULL,
    title text NOT NULL,
    description text,
    "thumbnailUrl" text,
    duration integer NOT NULL,
    "viewCount" integer DEFAULT 0 NOT NULL,
    "likeCount" integer DEFAULT 0 NOT NULL,
    "commentCount" integer DEFAULT 0 NOT NULL,
    "shareCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "musicId" text,
    "videoUrl" text
);


ALTER TABLE public."Video" OWNER TO postgres;

--
-- Name: VideoHashtag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VideoHashtag" (
    id text NOT NULL,
    "videoId" text NOT NULL,
    "hashtagId" text NOT NULL
);


ALTER TABLE public."VideoHashtag" OWNER TO postgres;

--
-- Name: VideoLike; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VideoLike" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "videoId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."VideoLike" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: Author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Author" (id, username, email, password, bio, "createdAt", "updatedAt", role, "profilePic") FROM stdin;
559acfcb-c403-4d9b-ae36-0223bfe2ff20	user_59784176751	user_59784176751@gmail.com	placeholder_password	╦â╠╢═ê≡ƒÉ╜╦é╠╢═ê\nσÉê OSTSW006\nΦ░óΦ░óσû£µ¼óΓ╕¥Γ╕¥Γ╕¥Γ╕¥Γùƒ╠åΓù₧╠åΓÖí	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_ab3022fd4639d85a2e14c9efe2ae1418.jpeg?from=327834062}
1dffeb33-b54d-4d8e-9ce2-399baa709895	X1677XX	X1677XX@gmail.com	placeholder_password	Everything in the world is not as good as you.\n\nσÉêΣ╜£∩╝ÜP325217\nτƒ¡ΦºåΘóæµòÖσ¡╕∩╝Üxingyundog897	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_171c090593bd43d1ea00bd31330b6cb1.jpeg?from=327834062}
34ac3a6d-ce91-4d51-9a5c-ab4f1e516f02	MGEAR729	MGEAR729@gmail.com	placeholder_password	σö»Σ╕Çσ░ÅσÅ╖∩╝Ü@Σ╜áτÜäσ░Åτö│\nΣ╕╗µëôΣ╕ÇΣ╕¬σÅìσ╖«\nµùáσà¼σÅ╕ Σ╕ìτ¡╛τ║ª \nσòåσèíΓ¥ú∩╕ÅSSSXXXQQQ729∩╝êΦ»╖σñçµ│¿σôüτëî∩╝ë	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_5992de56a2fc3f6008690bb760a3f969.jpeg?from=327834062}
18ad4d2c-e737-4087-a4b8-d86e58ba02d9	user_86127301755	user_86127301755@gmail.com	placeholder_password	µùáΦ«║σñÜσñº∩╝îΣ╜áΘâ╜Φªüτâ¡τê▒τ½ÑΦ»¥∩╝îΦï▒Θ¢äσÆîΘ¡öµ│òπÇé\nµèûΘƒ│µÉ£τ┤ó≡ƒöìΓÇ£τÑ₧σ¢╛σÉ¢ΓÇ¥Φ┐¢σ░Åτ¿ïσ║ÅΦ╛ôz633∩╝îσì│σÅ»Σ╕ïΦ╜╜Θ½ÿµ╕àΦºåΘóæπÇé\nµë┐ΦÆÖσÄÜτê▒∩╝îµäƒΦ░óσñºσ«╢τÜäσû£µ¼óΓ¥ñ∩╕Å	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_8ea2a8f349aec21b2592e123b693dcce.jpeg?from=327834062}
e30fb9c8-af03-4c25-9881-50e4da94092b	cj188cj	cj188cj@gmail.com	placeholder_password	Σ╕Çτ¢┤σ£¿σ»╗µë╛σ«½σ┤ÄΘ¬Åσè¿µ╝½Φê¼τÜäτö╗Θ¥ó.	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_98f2ba3e9933240335ddf54738a5da85.jpeg?from=327834062}
df1d0326-b259-40de-b6d0-4309140ad622	56994961710	56994961710@gmail.com	placeholder_password	≡ƒî┐Σ╕ôµ│¿∩╝Ü|σæ╝Σ╝ªΦ┤¥σ░ö|Σ║▓σ¡ÉµùàΦíî|τáöσ¡ªµùàΦíî|Φ╜╗σÑóΦç¬τö▒Φíî\n≡ƒî╕σîàΦ╜ª|τ▓╛σôüτ║»τÄ⌐σ░Åσîàσ¢óσÅèΦç¬Θ⌐╛µ╕╕\n≡ƒÜùµù⌐Θ╕ƒ∩╝Üσà¡µ£êΣ║║σ¥ç2000µ¼óΦ┐ÄσÆ¿Φ»ó\n≡ƒô╖Σ╕ôΣ╕ÜΦ╢èΘçÄΦ╜ªΦ╜ªΘÿƒ τ║┐Φ╖»τ¡ûσêÆ Φíîτ¿ïΦ«óσê╢\nΓ£ê∩╕ÅΣ╕ôΣ╕Üµæäσ╜▒σ¢óΘÿƒ µùáΣ║║µ£║Φê¬µïì µùàµïì Φ╢èΘçÄΣ╜ôΘ¬î	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_75b10f2c8cc1845d7d9dfa7a952c1e06.jpeg?from=327834062}
8ef91e95-d6e5-4c5e-b1fd-a565675b8fb4	user_62283696383	user_62283696383@gmail.com	placeholder_password	Θ¬æτ¥Çµæ⌐µëÿσ╕ªΣ╜áτ£ïΣ╕ìΣ╕Çµá╖τÜäΘúÄµÖ»∩╝ü	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_3b95e910edbad708c4457c44461d4601.jpeg?from=327834062}
67c98168-2880-4bc9-9e50-93cc382e3468	dianbo_cat	dianbo_cat@gmail.com	placeholder_password	τªüµ¡óΦ╜¼Φ╜╜∩╝îτªüµ¡óσòåτö¿\nσÉìσ¡ùσÅ½τö╡µ│ó\nΦï▒τƒ¡Φô¥Θçæµ╕Éσ▒éσª╣σª╣\n2021.02.20≡ƒÄé\nµ£ë≡ƒìáπÇü≡ƒºúπÇü≡ƒà▒∩╕Åτ½Ö\nins∩╝Üdianbo_cat\nσà╢Σ╗ûσ╣│σÅ░µ▓íµ£ëΦ┤ªσÅ╖Θâ╜µÿ»σåÆσàà	2025-04-27 07:30:58.973	2025-04-27 07:30:58.973	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_654afa4d3cfa8c39057bbcc9be6de3de.jpeg?from=327834062}
68b0b58f-a9cb-4c60-98e7-bba78537755c	95503397531	95503397531@gmail.com	placeholder_password	May your world be sunny and bright ∩╝ü	2025-04-27 07:38:32.745	2025-04-27 07:38:32.745	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813c001_6b69f95346894707b97cbe0e50b27054.jpeg?from=327834062}
740e2e0d-8fef-48e3-8059-b2149dc6fd67	juanyong518	juanyong518@gmail.com	placeholder_password	≡ƒìÇ Σ╕ÇΣ╕¬µâàσòåΘ½ÿτÜäΣ║║∩╝îΣ╕ìΣ╗àµëïΘçîµ£ëτÄ½τæ░∩╝îτü╡Θ¡éµ£ëΦè▒ΘªÖ∩╝îΦÇîΣ╕öσ┐âΘçîµ£ëΣ╕Çσ║ºσ┐âµâàΦè▒σ¢¡∩╝îΦè¼Φè│Φç¬σ╖▒∩╝îΦè¼Φè│σê½Σ║║∩╝îµäëµéªΣ║ïΣ╕Ü∩╝îµäëµéªµâàµäƒΓÇªΓÇª\n≡ƒìÇ µùáΦ╢úτÜäτÜ«σ¢èΣ╝Üµ╕ÉΦíîµ╕ÉΦ┐£∩╝îµ£ëΦ╢úτÜäτü╡Θ¡éτ╗êσ░åτ¢╕Φ»åτ¢╕ΘüçπÇéσö»τ╛ÄτÜäτ₧¼Θù┤∩╝îΘâ╜µ║ÉΦç¬Σ║Äτü╡Θ¡éτÜäΘ╗ÿσÑæΣ╕ÄµäƒτƒÑπÇé\n≡ƒìÇµûçµíêΘƒ│Σ╣Éσ¥çΣ╕║Σ╜£σôüµ╖╗Φë▓∩╝îµùáσà│Σ╣Äσ┐âσóâπÇé	2025-04-27 07:38:32.745	2025-04-27 07:38:32.745	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_250bc8eccd7fb915a76fbdf506cd1ba8.jpeg?from=327834062}
b1b9e562-3a32-4069-a071-8b258fde8a1a	GGK11	GGK11@gmail.com	placeholder_password	≡ƒê┤∩╝ÜTKbby2(σñçµ│¿∩╝î\n≡ƒìá: µ₧£µ₧£K\n≡ƒºú: µ₧£K2	2025-04-27 07:38:32.745	2025-04-27 07:38:32.745	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_92ac6248c2fc48741e5f01a2f4aa3b44.jpeg?from=327834062}
8139ad44-1aaa-44ce-8657-879c94c36f50	maureen88	maureen88@gmail.com	placeholder_password	σ¢╜µ¿í≡ƒç¿≡ƒç│ ΦÆÖσÅñµùÅ\nσà¿σ╣│σÅ░∩╝ÜτÉ│µàò\n≡¥ÿ╖≡¥ÿ¡≡¥ÿ░≡¥ÿ¿&≡¥ÿ«≡¥ÿó≡¥ÿ¼≡¥ÿª≡¥ÿ╢≡¥ÿ▒ @σ░Åσ╝áτöƒµ░öσòª\n≡¥ÿÉ≡¥ÿÄ∩╝Ü≡¥ÿô≡¥ÿ¬≡¥ÿ»≡¥ÿö≡¥ÿ╢111\nΓ£ë∩╕Å ≡¥ÿ¡≡¥ÿ¬≡¥ÿ»≡¥ÿ«≡¥ÿ╢≡¥ÿ╕≡¥ÿ░≡¥ÿ│≡¥ÿ¼\n≡ƒô« ≡¥ÿú≡¥ÿ¡≡¥ÿ╢≡¥ÿª≡¥ÿ▒≡¥ÿ¬≡¥ÿ¡≡¥ÿ¡≡¥ÿ┤@≡¥ÿ▓≡¥ÿ▓.≡¥ÿñ≡¥ÿ░≡¥ÿ«	2025-04-27 07:38:32.745	2025-04-27 07:38:32.745	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_00d640443e441aa1e1d77a588cfbe552.jpeg?from=327834062}
50203c28-1cda-46bc-a975-229266e69248	SuZhouJuvenile	SuZhouJuvenile@gmail.com	placeholder_password	Σ╕¡σ╝Åτ╛Äσ¡ªΘ¥₧τë╣ΘéÇµæäσ╜▒σ╕ê\nµ▒ƒσìùσ¢¡µ₧ùΘ¥₧Θªûσ╕¡µÄ¿σ╣┐σæÿ\nΦêîσ░ûΣ╕¡σ¢╜Θ¥₧Σ╕ôΣ╕ÜσôüΘë┤σ«╢	2025-04-27 07:38:32.745	2025-04-27 07:38:32.745	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/mosaic-legacy_2f9df00028df64025bc30.jpeg?from=327834062}
ca67350c-0c80-438e-bae0-e249cc89ca07	luy9472	luy9472@gmail.com	placeholder_password	µäƒΦ░óσà│µ│¿\nworld peace\n\n≡ƒÄ╢luy9472∩╝êσñçµ│¿µ¥ÑµäÅ∩╝ë	2025-04-27 07:38:32.745	2025-04-27 07:38:32.745	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813_ea833007a97042b491a24c4c5215630f.jpeg?from=327834062}
b6c68fb8-4488-4054-9d49-324d3b9c6b87	fuguifuguifugui	fuguifuguifugui@gmail.com	placeholder_password	µ▓íµ£ëΣ╗╗Σ╜òτºüΣ║║Φüöτ│╗µû╣σ╝Å\n≡ƒºú≡ƒìáµìëσê░Σ║åΣ╕ÇΣ╕¬σ»îΦ┤╡\nσÉêΣ╜£∩╝Übigfugui77	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/mosaic-legacy_314dc0006e48097489722.jpeg?from=327834062}
5b54f980-aae8-4a27-8b31-9fc4ca8d02d9	20030606_	20030606_@gmail.com	placeholder_password	Φ░óΦ░óΣ╜áΘÖ¬µêæΦ┐╖ΘÇöΣ╣Éσ¢¡\nσòåσèí:Tong-shangwu(Θ¥₧µ£¼Σ║║)\n≡ƒºú:X1999-  ≡ƒôò:τ₧│τ₧│\n≡ƒÄº@τ₧│τ₧│┬▓  ≡ƒÉº≡ƒÄ╡∩╝Üτ₧│τ₧│ µû░µ¡îσ╖▓Σ╕èτ║┐	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_ab0d84fed60856407348a4597b29ffce.jpeg?from=327834062}
c5e62e44-3749-4c59-a354-e2fbcb85ecf5	PoisonStudio	PoisonStudio@gmail.com	placeholder_password	σòåσèí| σÉêΣ╜£ | µòÖσ¡ª \n≡ƒ¢░∩╕Å :  P3ison	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_afc7793d61e14dbf2568b94ab9a6a37b.jpeg?from=327834062}
172c7632-865e-4eda-a716-df39fc7802a3	ccjy85	ccjy85@gmail.com	placeholder_password	τÑ¥Σ╜áσñ⌐σñ⌐σ╝Çσ┐â∩╜₧\n@σèáσçÅµ╛ä \nσÉêΣ╜£∩╝ÜCooo-ccc∩╝êσñçµ│¿σôüτëî∩╝ë\n≡ƒôò/≡ƒºú∩╝ÜσèáσçÅµ╛ä	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_2c62fdef1cfb6ef1710cb1987c80f162.jpeg?from=327834062}
f251d46f-e915-4565-a1e0-0a1a095168bc	butterfly_W	butterfly_W@gmail.com	placeholder_password	≡ƒôòσÉîσÉì\n≡ƒºúWwσÅêσ£¿τ¥íΦºë_\n≡ƒê┤∩╕Å∩╝ÜBESW77	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_03a2327ddab896c228a95e3d22d8f9fd.jpeg?from=327834062}
8d3bfb15-0612-48fe-82f3-b3bb3e769446	user_70414674542	user_70414674542@gmail.com	placeholder_password	σîûσªåµòÖτ¿ïΘâ╜Σ╝ÜσÅæσ£¿σ£¿≡ƒìá∩╝ü∩╝ü∩╝ü∩╝ü∩╝ü∩╝êΣ╣ƒσÅ½τàÄΘÑ╝≡ƒÑ₧∩╜₧\nΦç¬τö¿σÑ╜τë⌐Θâ╜σ£¿µ⌐▒τ¬ù≡ƒ¬ƒ∩╝ü∩╝ü∩╝ü\n≡ƒºú∩╝ÜτàÄΘÑ╝τàÄΘÑ╝ΘÑ╝-\n σÉêΣ╜£∩╝Üzjbcon∩╝êµ£¼Σ║║∩╝ë	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_8106a0f8a308be90063497c192eb515d.jpeg?from=327834062}
246dbb47-024e-4963-9bc3-6fb2a6441d0f	user_58758728628	user_58758728628@gmail.com	placeholder_password		2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/mosaic-legacy_85f70009406914248494.jpeg?from=327834062}
9d04f158-c07f-4fd6-b2ba-66dfb1a38abf	45492534522	45492534522@gmail.com	placeholder_password	µæäσ╜▒σ╕ê\nτ║ªµïìσÉêΣ╜£Φ»╖τºüΣ┐í	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_0836c9912037f3f2858b9129d9997496.jpeg?from=327834062}
b347499f-58a1-432d-9b3b-fa2334addb30	ll6116482	ll6116482@gmail.com	placeholder_password	µòÖ∩╝Ü18005554961∩╝ê1σ»╣1∩╝ë\nτ«ÇσìòτÜäσû£µ¼óµ£ÇΘò┐Σ╣à σ╣│σçíτÜäΘÖ¬Σ╝┤µ¢┤σ«ëσ┐â\nµèûΘƒ│µÉ£∩╝êτÑ₧σ¢╛σÉ¢∩╝ëΦ┐¢σ░Åτ¿ïσ║ÅΦ╛ô8839≡ƒëÉσ¢╛	2025-04-28 01:27:06.259	2025-04-28 01:27:06.259	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_9e997ad52d04daf45b5e69159cbbea99.jpeg?from=327834062}
6d70c500-1f52-4477-b59a-b711ba4de7d7	LeerHo	LeerHo@gmail.com	placeholder_password	τÑ¥Σ╜áτöƒµ┤╗µäëσ┐½.\nτöƒµ┤╗σÅ╖∩╝Ü@-LeerHo  \nΦ«╛σñç∩╝ÜDJI Pocket3\nσÉêΣ╜£/µÖ»σî║/Θƒ│Σ╣É/τƒ¡ΦºåΘóæµòÖσ¡ª≡ƒ¢░∩╕Å∩╝ÜXingyun88488\n∩╝êσñçµ│¿µ¥ÑµäÅ∩╝ë∩╝êµùáσñçµ│¿Σ╕ìΘÇÜΦ┐ç∩╝ë	2025-04-28 01:30:45.031	2025-04-28 01:30:45.031	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_68f7f0ef56f45b729db52433f9372b23.jpeg?from=327834062}
759f94df-4b80-4430-ab9a-62f781ea7995	46413018417	46413018417@gmail.com	placeholder_password	τöƒµÇºΦç¬τö▒µòúµ╝½πÇüΣ╕ìσû£µïÿµ¥ƒπÇüτê▒Φç¬τö▒.	2025-04-28 01:30:45.031	2025-04-28 01:30:45.031	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_d78f308a2e1c4ac4dc936591662762f5.jpeg?from=327834062}
a8e501a7-bf16-48b6-9282-56ec64f6ef39	24123865479	24123865479@gmail.com	placeholder_password	Σ╕ÇΦ╡╖τ£ïµ╡╖σ░▒µÿ»σà▒Σ║½σ┐âΦ╖│σôª	2025-04-28 01:30:45.031	2025-04-28 01:30:45.031	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813_d6ab42d621f441b597a1be2ed2b305bf.jpeg?from=327834062}
e296308a-3785-40a3-a69c-0306ef90be42	49844476172	49844476172@gmail.com	placeholder_password	σû£µ¼óµ╡╖ σû£µ¼óΣ╜á\nσû£µ¼óτ╛ÄσÑ╜τÜäΣ╕Çσêç	2025-04-28 01:30:45.031	2025-04-28 01:30:45.031	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813c001_oQAnPPhveziFDDAcC9Bjo9iMATQegA8EE4PAIA.jpeg?from=327834062}
2a08a03a-0122-412b-aac5-cfc160776892	user_111075419438	user_111075419438@gmail.com	placeholder_password	σêåΣ║½µêæτÜäσ░ÅΘÖóτöƒµ┤╗∩╝îσÆîµêæσû£µ¼óτÜäΣ╕Çσêç≡ƒ¬┤≡ƒìâ≡ƒìéΓ¥ä∩╕Å\n | ≡ƒ¬┤\nΦüöτ│╗≡ƒÆîMisscok	2025-04-28 01:30:45.031	2025-04-28 01:30:45.031	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_23e5703c79871ec1d8eb1bba5070d87f.jpeg?from=327834062}
23fb6f5c-315e-432e-b28b-f7de18aa2983	imfing	imfing@gmail.com	placeholder_password	Σ╗Ñµ₧üΦç┤τÜäσ«íτ╛ÄΦ«ñΦ»åµ▒ƒσìù∩╝îΣ╗úΦí¿Σ╜£σôüπÇèσ«üσóâπÇïπÇèΦªåΘ¢¬ΘçæΘÖ╡πÇï\nΘúÄµÖ»Σ║║µûçµæäσ╜▒σ╕ê∩╝îσìùΣ║¼σñºσ¡ªΦë║µ£»σ¡ªτáöτ⌐╢τöƒ\nΣ╕¡σ¢╜σ¢╜σ«╢σ£░τÉåπÇü8KRAW PremierπÇüΦìöµ₧¥ΘúÄµÖ»τ║┐µæäσ╜▒σ╕ê\nµûçµùàµÄ¿σ╣┐πÇüσ╜▒ΦºåµïìµæäπÇüτ┤áµ¥ÉµÄêµ¥âπÇüσà▒σê¢σÉêΣ╜£τºüΣ┐í	2025-04-28 01:30:45.031	2025-04-28 01:30:45.031	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_5664ad7a9c8ffdab04d4592629a853a8.jpeg?from=327834062}
0a2beafb-ccbb-4a4d-bb83-c1d2adbec4f6	user_105022761064	user_105022761064@gmail.com	placeholder_password	ΘÇëµï⌐Θóÿσ«üµä┐ΘÇëΘöÖ∩╝îΣ╣ƒΣ╕ìΦªüτ⌐║τ¥ÇΓÇªΓÇª	2025-04-28 01:32:20.457	2025-04-28 01:32:20.457	user	{https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813c001_oMAAAcPkMPnQfCVA7HDnxIDcC8f9E3FgAshAa1.jpeg?from=327834062}
\.


--
-- Data for Name: Comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Comment" (id, "videoId", "authorId", content, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: CommentLike; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CommentLike" (id, "userId", "commentId", "createdAt") FROM stdin;
\.


--
-- Data for Name: FavoriteVideo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FavoriteVideo" (id, "userId", "videoId", "createdAt") FROM stdin;
\.


--
-- Data for Name: Follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Follow" (id, "followerId", "followingId", "createdAt") FROM stdin;
\.


--
-- Data for Name: Hashtag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Hashtag" (id, name) FROM stdin;
3c4875ac-3a6a-4650-b645-8faa2cb376db	σñäσÑ│σ║º
b9c4614a-bb0e-41ae-98b3-d798089339e7	µâàτ¬ªσê¥σ╝ÇΘüçσê░Σ╜á
4417a9b1-fa86-44cf-8455-f1eae45b5115	σè¿µ╝½
54d87882-c835-4929-83e1-1fe1f857c6d8	µ▓╗µäêσè¿µ╝½
b1db2b90-d9b7-45ac-b2bb-91afc823b92c	ΘªÖµá╝Θçîµïëτï¼σàïσ«ùσÅñσƒÄΦ╜¼τ╗Åτ¡Æ
02fb98bb-5a7c-41bd-a2f4-b3ae6cca5a20	ΘªÖµá╝Θçîµïëµ¥╛Φ╡₧µ₧ùσ»║σ░Åσ╕âΦ╛╛µïëσ«½
1317a8b5-a92b-44e3-aa93-f61874490908	Σ╜¢µòÖσ£úσ£░
4b45d38a-8ca7-4cf6-b296-46fea7402044	µä┐µëÇµ▒éτÜåµëÇµä┐≡ƒÖÅ
e0d8ac0b-6b05-4361-ac88-2384cfbf757a	µëÄΦÑ┐σ╛╖σïÆ
49aea7f7-902f-45de-8544-fabecd418502	µ▓╗µäêτ│╗ΘúÄµÖ»
61286e47-4edb-40a4-917e-11268dd0dc67	µäƒΦºëΦç│Σ╕è
92d2d1ed-b0ce-4fcd-9c91-4c260e786cd6	capperµû░Σ╕ô
5fb71c9b-fe28-450c-95f4-25218ff08b5e	capperµû░µ¡îΘ¢¬σñ¬τù¢Σ║å
8dd5dd01-204d-4374-b13f-8c5a2660fbd2	Θ╗æµÜùΦìúΦÇÇ
6a5ef6e0-bace-46bb-ab0f-6f27d42f61f1	µ£┤σªìτÅì
27d415d9-6c61-4cec-a7b6-dbfba7274520	ΦïÅσ╖₧
7512ed6f-be0a-4ad6-8bea-6785a9902f1c	µÇ╗ΦªüΣ╕ïΦ╢ƒµ▒ƒσìùσÉº
a0f19407-e5ee-4ed0-a0b8-51a59102c32c	σÅñΘòç
aefe29af-7861-4276-a8e5-8a312dcf07de	σÉîΘçîσÅñΘòç
dbdf4ba3-31f5-4ab9-adda-7b7d96870824	τï«σ¡Éσ║º
d00e5b26-6ca3-44e6-b976-731f78b8ab23	σ£úΦ»₧Φèé
3a1c3500-901e-47a7-a2d6-ef17710f0954	σÄƒτ¢╕µ£║
5c389e28-aea9-4f1d-ac56-c4ea85baed20	µ░¢σ¢┤µäƒ
0db760d5-ab4a-41f7-a42b-55f8cd102c98	04
bc6bf85b-5797-43ae-a987-1dd7b612033d	Θçæτë¢σ║º
f4fe86e5-3a32-497b-a109-0873dead4da8	τö£σª╣
7ae1f692-71b4-4852-a228-a0d6d5223741	τÄïΘ╣ñµúúµ╡«σ¢╛τ╝ÿΣ╕çτë⌐τÜåσÅ»Φ╜¼µîæµêÿ
7a44397a-9b54-4f9f-b817-211718ee9791	µ╡«σ¢╛τ╝ÿ
ce1efa6a-088b-4529-8a3d-c9fbbb0d1d8c	σ░æσ╣┤µäƒ
0ee7637f-cbe6-4adc-a6db-e0d4a1959ab2	ΦÇ╜Φ»»Σ╜áσçáτºÆσ┐âσè¿Σ╕ÇΣ╕ï
86e06b7b-cd48-46d4-b31a-82b612e9f9ac	Φ╛₧µÜ«σ░öσ░öτâƒτü½σ╣┤σ╣┤
761ce81e-3a3a-41be-bf96-8ddf6f25c256	σìùµÿîµïìτàº
83456008-00a4-44c5-82e9-26b02cc4027e	2023σ╣┤τ¼¼Σ╕Çσ£║Θ¢¬
26d39e66-f2a7-4e88-a1d7-371eee3c4a44	σìùΣ║¼
f1c91166-38eb-4a49-94c0-ddf131b8531e	σìùΣ║¼Σ╕ïΘ¢¬
3a10f083-261d-4208-8e21-bb9af0b12c2f	σÄƒτÑ₧
9cdf84cd-f9b4-44dc-9007-b808b5adf51a	σè¿µÇüσúüτ║╕
6b681c20-2d3f-459a-9cc4-bbaddaac48d3	σê╗µÖ┤
f25b51cf-0199-4263-825c-c1bf5e900199	Σ║îµ¼íσàâ
b8e915e1-97c7-4418-87c4-c5d5ee15d1a3	σúüτ║╕
\.


--
-- Data for Name: Music; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Music" (id, title, artist, url, duration, thumbnail, "createdAt") FROM stdin;
7232983132608203557	σÅ»Σ╕ìσÅ»Σ╗Ñ	σ░ÅσåÆ	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7232983127814146853.mp3	66	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_f27c051f095fb25d263e2ca5a1dc1658.jpeg?from=327834062	2025-04-27 07:30:58.973
6876277291060561927	AllTimeLowµèûΘƒ│(σ«îµò┤τëê)	69&DJσñÜσñÜ&Djµ│óΣ╗ö&τ¿ïσ░ÅτÜô		214	https://p3-sign.douyinpic.com/tos-cn-v-2774c002/b7030199ecef4e568ef2f576ab76bbe0~100x100.jpeg?lk3s=08d74b56&x-expires=1745825457&x-signature=rPLoihtIx1SDx2mofcFV6Kh3nwY%3D	2025-04-27 07:30:58.973
6983248432840444708	@Σ╣àµ╝½µ╝½σê¢Σ╜£τÜäσÄƒσú░	Σ╣àµ╝½µ╝½	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/6983248423340313380.mp3	13	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813_cfd77d734e1c4b06b4d1cabd3382555e.jpeg?from=327834062	2025-04-27 07:30:58.973
6766203759715420935	µëÇσ┐╡τÜåµÿƒµ▓│	CMJ		119	https://p3-sign.douyinpic.com/tos-cn-v-2774c002/26cde25e361348649c2e7bf3351c1598~100x100.jpeg?lk3s=08d74b56&x-expires=1745825457&x-signature=yCQkda%2FTey4XLBo5xEfy2p%2Bfwmc%3D	2025-04-27 07:30:58.973
6852323391534304008	@σÉ¢ σ┐âσê¢Σ╜£τÜäσÄƒσú░	σÉ¢ σ┐â	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/6852323395602909960.mp3	11	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_951f408ad3a9d568a3c85da910071e72.jpeg?from=327834062	2025-04-27 07:30:58.973
7204450451815746361	One More Light	Linkin Park		17	https://p3-sign.douyinpic.com/tos-cn-v-2774c002/3e4a28d0da714f67b4d4ccaa9eba6827~100x100.jpeg?lk3s=08d74b56&x-expires=1745825457&x-signature=ww78d%2FQl91BVDd%2Bm3WaUBCkQTZM%3D	2025-04-27 07:30:58.973
7126770049733543943	µ╕àµÖ¿τÜäΘúÄµÖ»(τ║»Θƒ│Σ╣É)	Cecil	https://sf5-hl-cdn-tos.douyinstatic.com/obj/tos-cn-ve-2774/1ad0cf9797544ad5a9126e79d749f7e0	134	https://p3.douyinpic.com/aweme/100x100/tos-cn-v-2774c002/811553dc355f4fd4a8dc2935ced5c862.jpeg	2025-04-27 07:30:58.973
7212770796291246908	@σñ⌐Φô¥σôÑΓ£¿σê¢Σ╜£τÜäσÄƒσú░	σñ⌐Φô¥σôÑΓ£¿	https://sf6-cdn-tos.douyinstatic.com/obj/ies-music/7212770793976073020.mp3	190	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_3b95e910edbad708c4457c44461d4601.jpeg?from=327834062	2025-04-27 07:30:58.973
7186879781873453881	@τö╡µ│óµ│óµ│óσê¢Σ╜£τÜäσÄƒσú░	τö╡µ│óµ│óµ│ó	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7186879750680398629.mp3	7	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_654afa4d3cfa8c39057bbcc9be6de3de.jpeg?from=327834062	2025-04-27 07:30:58.973
6911599880193723143	@Θ¥Æµ╖«τÜäΦ»ùσê¢Σ╜£τÜäσÄƒσú░	Θ¥Æµ╖«τÜäΦ»ù	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/6911599878091082503.mp3	6	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813_9ac722fc826a46a1a429177e33a187fa.jpeg?from=327834062	2025-04-27 07:38:32.745
7195373550470023995	@α╝╜α╜╝ Γ¥ÇΘÜ╜µ░╕Γ¥Çα╜╝α╜╝σê¢Σ╜£τÜäσÄƒσú░	α╝╜α╜╝ Γ¥ÇΘÜ╜µ░╕Γ¥Çα╜╝α╜╝	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7195373555045976887.mp3	13	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_250bc8eccd7fb915a76fbdf506cd1ba8.jpeg?from=327834062	2025-04-27 07:38:32.745
7205185045350943544	Θ¢¬ Distance	CAPPER & Capper		20	https://p3-sign.douyinpic.com/tos-cn-v-2774c002/oYOkuAAImABrWkeEB6FEgLDttBCZr0AEE5f7QJ~100x100.jpeg?lk3s=08d74b56&x-expires=1745825911&x-signature=u1%2F9gVoC0AveeOyA0F14Jvs33z0%3D	2025-04-27 07:38:32.745
7216561419557456700	@τÉ│µàòσê¢Σ╜£τÜäσÄƒσú░	τÉ│µàò	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7216561415992183589.mp3	10	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_00d640443e441aa1e1d77a588cfbe552.jpeg?from=327834062	2025-04-27 07:38:32.745
7220559564276615973	@Φ┐╜Σ║æσ░æσ╣┤σê¢Σ╜£τÜäσÄƒσú░	Φ┐╜Σ║æσ░æσ╣┤	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7220559547340311355.mp3	8	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/mosaic-legacy_2f9df00028df64025bc30.jpeg?from=327834062	2025-04-27 07:38:32.745
7140978724920445710	@Φ┐Öµÿ»Σ╕Çµ¥íµ╖íµ░┤Θ▒╝σê¢Σ╜£τÜäσÄƒσú░	Φ┐Öµÿ»Σ╕Çµ¥íµ╖íµ░┤Θ▒╝	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7140978729999682312.mp3	17	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_df86ae7d5fdc4258f84848ae8a4efe0a.jpeg?from=327834062	2025-04-27 07:38:32.745
6865544093021309709	@σæ¿σà¼σê¢Σ╜£τÜäσÄƒσú░	σæ¿σà¼	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/6865544031641520909.mp3	48	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_542aa9e076f1f4feb4b093b446a36995.jpeg?from=327834062	2025-04-28 01:27:06.259
7119459095387605773	@Shi.σê¢Σ╜£τÜäσÄƒσú░	Shi.	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7119459091482807071.mp3	25	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_a1c0ce14ae37e7bbb2b8f8ebc81636c7.jpeg?from=327834062	2025-04-28 01:27:06.259
7175829928208878395	@σ╗ûµ│╜Φô¥σê¢Σ╜£τÜäσÄƒσú░	σ╗ûµ│╜Φô¥	https://sf6-cdn-tos.douyinstatic.com/obj/ies-music/7175829930054355770.mp3	30	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_5ab1d536a07950bdd2332ee905dbacb7.jpeg?from=327834062	2025-04-28 01:27:06.259
6835450992658483201	Such a Fool	George Nozuka		60	https://p3-sign.douyinpic.com/tos-cn-v-2774c002/40cd2eddcbce4f12ae46e74cb698b555~100x100.jpeg?lk3s=08d74b56&x-expires=1745890025&x-signature=jLQuuEfbv%2FyUzVQtiQJXuX3rxrk%3D	2025-04-28 01:27:06.259
6936440843142318862	@Σ║åΣ║åµÖ┤σ▒▒Φºüσê¢Σ╜£τÜäσÄƒσú░	Σ║åΣ║åµÖ┤σ▒▒Φºü	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/6936440828500871966.mp3	25	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813c001_a45ace69f5284befa49f8a13a10eed45.jpeg?from=327834062	2025-04-28 01:27:06.259
6702218146272512001	Σ╕ìΦâ╜Φ»┤τÜäτºÿσ»å	σæ¿µ¥░Σ╝ª		60	https://p3-sign.douyinpic.com/tos-cn-v-2774c002/efac32196bcd4fdf95445dd07ee43390~100x100.jpeg?lk3s=08d74b56&x-expires=1745890025&x-signature=K512mL4jDbpYTfFbE657okiBJb4%3D	2025-04-28 01:27:06.259
7167668747266820878	@Sasablueσê¢Σ╜£τÜäσÄƒσú░	Sasablue	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7167668746650127135.mp3	17	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_d2311cd460344c31c1db6678a0944015.jpeg?from=327834062	2025-04-28 01:27:06.259
7183130447738964791	@τÄïΘ╣ñµúú_Dylanσê¢Σ╜£τÜäσÄƒσú░	τÄïΘ╣ñµúú_Dylan	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7183130409579285303.mp3	16	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/mosaic-legacy_85f70009406914248494.jpeg?from=327834062	2025-04-28 01:27:06.259
6737659425395542798	@Σ╕ìµƒôσÉ¢σê¢Σ╜£τÜäσÄƒσú░	Σ╕ìµƒôσÉ¢	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/1644937460874302.mp3	13	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/mosaic-legacy_1ca200000ed6cd59a3de6.jpeg?from=327834062	2025-04-28 01:27:06.259
6666686445337447180	µÖ┤σñ⌐	Φ╖»Φ┐çµêæτÜäτöƒµ┤╗	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/1627784247281672.mp3	10	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_cccf4212ccc56e0978ce9f69aaaf89b0.jpeg?from=327834062	2025-04-28 01:27:06.259
7173224993801718536	@σæ¿µ¥░Σ╝ªΘƒ│Σ╣Éµ▒çσê¢Σ╜£τÜäσÄƒσú░	σæ¿µ¥░Σ╝ªΘƒ│Σ╣Éµ▒ç	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7173224994816690974.mp3	20	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_19e72fbe1256e9aaa37398b1b7ad93b3.jpeg?from=327834062	2025-04-28 01:30:45.031
7113912582716607240	@Monica≡ƒÄ╣σê¢Σ╜£τÜäσÄƒσú░	Monica≡ƒÄ╣	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7113912572059257613.mp3	21	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_56b57197809ecba6f2b5a10834660786.jpeg?from=327834062	2025-04-28 01:30:45.031
7175822742649244476	@µ▒ƒσ┐ºσê¢Σ╜£τÜäσÄƒσú░	µ▒ƒσ┐º	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7175822740681870137.mp3	12	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813c001_oAoAABZtgIAX1idAZijODsQExPQAvAC95wR7I.jpeg?from=327834062	2025-04-28 01:30:45.031
7169578628274998030	@µû╜σ░Åµ¢╝σæÇσê¢Σ╜£τÜäσÄƒσú░	µû╜σ░Åµ¢╝σæÇ	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7169578624423643917.mp3	16	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_e29a9ea0daf3918df633b4ec32b46278.jpeg?from=327834062	2025-04-28 01:30:45.031
7113118272442141476	@JiSaaσê¢Σ╜£τÜäσÄƒσú░	JiSaa	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7113118269942336287.mp3	13	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_7cf08804cd97fc68932a3184b889abb2.jpeg?from=327834062	2025-04-28 01:30:45.031
7174968530301946682	@Hushiσê¢Σ╜£τÜäσÄƒσú░	Hushi	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7174968531656641337.mp3	18	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813_24e623db05084ba6bb6571b52a704ce3.jpeg?from=327834062	2025-04-28 01:30:45.031
7169703640192535310	µÑ╝Θí╢Σ╕èτÜäσ░ÅµûæΘ╕á_σñûσÑùτëê	ΦâÑτ¥┐Θÿ┐#.∩╝êσô¡σô¡σåÖµ¡îτëê∩╝ë	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7169703638020213512.mp3	17	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_d9c353bb7bb6cbf052c9781c67c51c45.jpeg?from=327834062	2025-04-28 01:30:45.031
7188452834415774519	@Θ¥ÆΘöïFingσê¢Σ╜£τÜäσÄƒσú░	Θ¥ÆΘöïFing	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7188452808662829881.mp3	10	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_5664ad7a9c8ffdab04d4592629a853a8.jpeg?from=327834062	2025-04-28 01:30:45.031
6958126360753720078	@≡ƒîêΘÇåµù╢ΘÆêσê¢Σ╜£τÜäσÄƒσú░	≡ƒîêΘÇåµù╢ΘÆê	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/6958126301194849031.mp3	96	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813c001_oMAAAcPkMPnQfCVA7HDnxIDcC8f9E3FgAshAa1.jpeg?from=327834062	2025-04-28 01:32:20.457
6885423590821332993	Exile	Alyssa Caroline		60	https://p3-sign.douyinpic.com/tos-cn-v-2774c002/8fa58c51ae584fdc9ce2734e356056d2~100x100.jpeg?lk3s=08d74b56&x-expires=1745890339&x-signature=4OmHskKiMGxSf3s19NQtVkXUb8A%3D	2025-04-28 01:32:20.457
6844110833204202253	@τ┤¢Φè╕σê¢Σ╜£τÜäσÄƒσú░	τ┤¢Φè╕	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/6844110798378257166.mp3	6	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-i-0813_464efb8aa7bb4316baffe3763d767368.jpeg?from=327834062	2025-04-28 01:32:20.457
7151331474581539591	@Θƒ│y0σê¢Σ╜£τÜäσÄƒσú░	Θƒ│y0	https://sf5-hl-cdn-tos.douyinstatic.com/obj/ies-music/7151331476864830215.mp3	23	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_ec259b52a02c605acd2a5778f6b6710b.jpeg?from=327834062	2025-04-28 01:32:20.457
7154740991518559006	@Σ╝ÜΣ╕ìΣ╝ÜΣ╕ïΘ¢¿σê¢Σ╜£τÜäσÄƒσú░	Σ╝ÜΣ╕ìΣ╝ÜΣ╕ïΘ¢¿	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7154740991383751437.mp3	10	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_75f24c62ede52d0a27fe47d0acce67f6.jpeg?from=327834062	2025-04-28 01:32:20.457
7041140250655492895	µñÄσÉìτ£ƒµÿ╝	Φùñσ«½σæ¿	https://sf3-cdn-tos.douyinstatic.com/obj/ies-music/7041140251016137503.mp3	10	https://p3-pc.douyinpic.com/aweme/100x100/aweme-avatar/tos-cn-avt-0015_ff658f0bba69b5cd27fc4dfc678bfb0b.jpeg?from=327834062	2025-04-28 01:32:20.457
\.


--
-- Data for Name: Reply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Reply" (id, "commentId", "authorId", content, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Video; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Video" (id, "authorId", title, description, "thumbnailUrl", duration, "viewCount", "likeCount", "commentCount", "shareCount", "createdAt", "updatedAt", "musicId", "videoUrl") FROM stdin;
afbcf66f-e047-4285-9010-2f2143bceac8	559acfcb-c403-4d9b-ae36-0223bfe2ff20	µêæΘÖ¬Σ╜áΦ╡░Σ║åΣ╕Çµ«╡Φ╖» Σ╜áµ£ÇΣ║åΦºúµêæΣ╕ìµÿ»σÉù#σñäσÑ│	µêæΘÖ¬Σ╜áΦ╡░Σ║åΣ╕Çµ«╡Φ╖» Σ╜áµ£ÇΣ║åΦºúµêæΣ╕ìµÿ»σÉù#σñäσÑ│σ║º #µâàτ¬ªσê¥σ╝ÇΘüçσê░Σ╜á	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/b37be60c2064e9327a3baf8446e912b0~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=Ql3hRiD4u6V376%2BsU0JKhdkcYhQ%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271534020E4ED49F02448C04D043	9	0	0	0	0	2023-05-22 09:36:24	2025-04-27 07:34:04.234	7232983132608203557	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/c034dd45-634d-4860-9962-036646c63c7f.mp4?
7df3b740-c457-47ff-8446-7f3712e84001	1dffeb33-b54d-4d8e-9ce2-399baa709895	σ£¿520Φ┐Öσñ⌐ Φó½Σ║║Φë╛τë╣τ£ïΦ┐ÖΣ╕Çσ╣ò τ£ƒµÿ»Σ╕ÇΣ╗╢	σ£¿520Φ┐Öσñ⌐ Φó½Σ║║Φë╛τë╣τ£ïΦ┐ÖΣ╕Çσ╣ò τ£ƒµÿ»Σ╕ÇΣ╗╢Φ╢àτ║ºσ╣╕τªÅτÜäΣ║ïσòè.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/6984a6378885b72d656f5fac13d36771~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=RiRSTdjZJUuzyTcSjF1EIGWU06s%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271534020E4ED49F02448C04D043	7	0	0	0	0	2023-05-20 02:27:33	2025-04-27 07:34:04.234	6876277291060561927	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/82b3afc9-1555-419c-91ae-e0ed0fc53853.mp4?
88a44e97-67ae-465b-b6d5-58123bf5d0b6	34ac3a6d-ce91-4d51-9a5c-ab4f1e516f02	σ┐âµ£ëσìâµûñΘçì σì┤µùáΣ╕Çσ¡ùΦ¿Ç	σ┐âµ£ëσìâµûñΘçì σì┤µùáΣ╕Çσ¡ùΦ¿Ç	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/a112f328f68641935b3056338372612e~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=zUw0KauZhYDJbBsFyVexbVHTsq0%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271534020E4ED49F02448C04D043	9	0	0	0	0	2023-05-19 10:00:17	2025-04-27 07:34:04.234	7232983132608203557	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/87cce5f0-826e-4487-8a29-c5632e68ddc6.mp4?
32984cd1-b226-4b06-9f1d-27139ddbb9d5	18ad4d2c-e737-4087-a4b8-d86e58ba02d9	ΓÇ£σê½µâ│σñ¬σñÜ∩╝îσÑ╜σÑ╜τöƒµ┤╗∩╝îΣ╣ƒΦ«╕µùÑσ¡ÉΦ┐çτ¥ÇΦ┐çτ¥Çσ░▒	ΓÇ£σê½µâ│σñ¬σñÜ∩╝îσÑ╜σÑ╜τöƒµ┤╗∩╝îΣ╣ƒΦ«╕µùÑσ¡ÉΦ┐çτ¥ÇΦ┐çτ¥Çσ░▒Σ╝Üµ£ëτ¡öµíê∩╝îσè¬σè¢Φ╡░τ¥ÇΦ╡░τ¥Çσ░▒Σ╝Üµ£ëτ¥ÇΦÉ╜ΓÇªΓÇªΓÇ¥@µèûΘƒ│σ░Åσè⌐µëï #σè¿µ╝½ #µ▓╗µäêσè¿µ╝½	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/b7c862b60836d6af50bd45f83510cbb3~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=QgP3nrQmwJr5nQgj%2B8a%2B%2BI8daGo%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271534020E4ED49F02448C04D043	13	0	0	0	0	2023-01-26 10:24:47	2025-04-27 07:34:04.234	6983248432840444708	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/19265076-c117-4495-b0d1-8bda9da30f43.mp4?
f1f8e562-609b-4750-844f-3c498ff8c367	e30fb9c8-af03-4c25-9881-50e4da94092b	Φ┐ÖΣ╕¬σñÅσñ⌐Σ╕ÇΦ╡╖σÄ╗σÉ╣σÉ╣ΘúÄσÉºΓÇª	Φ┐ÖΣ╕¬σñÅσñ⌐Σ╕ÇΦ╡╖σÄ╗σÉ╣σÉ╣ΘúÄσÉºΓÇª	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/2422a7cf5f85960b8de7e2c5b10dd588~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=Yh1mWlsUnU37LkxRXMbxfTUYSeg%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271534020E4ED49F02448C04D043	8	0	0	0	0	2023-01-14 03:35:54	2025-04-27 07:34:04.234	6766203759715420935	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/80ba5f37-85df-4924-8de1-5f74c55897bf.mp4?
ddcf90bc-491d-491a-9c34-7c456a4d5855	df1d0326-b259-40de-b6d0-4309140ad622	σªéµ₧£ µêæΦ»┤σªéµ₧£ Φ«⌐Σ╜áσ¢₧σê░Σ╗ÄσëìΣ╜áµâ│σ¢₧σê░ΘéúΣ╕Ç	σªéµ₧£ µêæΦ»┤σªéµ₧£ Φ«⌐Σ╜áσ¢₧σê░Σ╗ÄσëìΣ╜áµâ│σ¢₧σê░ΘéúΣ╕Çσ╣┤	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/ad12671fd1cae6773691c56d32c1073f~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=mS%2F0exFlridnKQE5BCwJR5wbNZY%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271534020E4ED49F02448C04D043	7	0	0	0	0	2023-04-27 02:37:00	2025-04-27 07:34:04.234	6852323391534304008	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/a99c17d3-ba95-457f-af0f-bb60b849e66a.mp4?
b9d9ad52-85eb-476b-95a6-7a08cfd50ee1	67c98168-2880-4bc9-9e50-93cc382e3468	σ░Åτî½σÆ¬σÅæτÄ░Σ║åΣ╜á∩╝îσ╣╢µèèΣ╜áµëæσÇÆ	σ░Åτî½σÆ¬σÅæτÄ░Σ║åΣ╜á∩╝îσ╣╢µèèΣ╜áµëæσÇÆ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/947aac035a4dda6bd4a723eb62c75c3b~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=8ySB21QXeZ4w48NWxzPLhJU%2F60s%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271534020E4ED49F02448C04D043	7	0	0	0	0	2023-01-10 04:44:08	2025-04-27 07:34:04.234	7186879781873453881	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/104bd328-1928-487b-ae79-7083ce498f5f.mp4?
829119ec-3a0a-4a1b-a535-c4bfda0fe8ab	df1d0326-b259-40de-b6d0-4309140ad622	ΓÇ£σÅ¬ΦªüΣ╜áΘ£ÇΦªü Σ╗╗Σ╜òµù╢σÇÖΘâ╜σÅ»Σ╗Ñµëôµë░µêæ σÉ¼Φºü	ΓÇ£σÅ¬ΦªüΣ╜áΘ£ÇΦªü Σ╗╗Σ╜òµù╢σÇÖΘâ╜σÅ»Σ╗Ñµëôµë░µêæ σÉ¼Φºüµ▓íΓÇ¥	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/cb8e1cacf5d20b7d6c91c4ccc4b76ffb~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=Fx6pZJZEkTK5EOj934s8SW4vdAM%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	8	0	0	0	0	2023-04-22 01:14:36	2025-04-27 07:38:32.745	7204450451815746361	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/669b4084-0ab4-4c16-ad11-b95652bd4b24.mp4?
74fe905d-1fbe-4a76-97f3-cf072364da4f	df1d0326-b259-40de-b6d0-4309140ad622	ΓÇ£µêæσ╕îµ£¢µëÇµ£ëτÜäτâªµü╝ Θâ╜τª╗σ▒Åσ╣òσëìΦ┐ÖΣ╕¬σ░Åτ¼¿Φ¢ï	ΓÇ£µêæσ╕îµ£¢µëÇµ£ëτÜäτâªµü╝ Θâ╜τª╗σ▒Åσ╣òσëìΦ┐ÖΣ╕¬σ░Åτ¼¿Φ¢ïΦ┐£Φ┐£τÜäΓÇ¥	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/44449ebaf3acb516823f292004c1406c~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=%2Bkws4KxA0l7MTmcVyL38poItT74%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	9	0	0	0	0	2023-05-09 00:33:40	2025-04-27 07:38:32.745	7126770049733543943	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/e0854ef5-a173-4697-882b-6d4705784afa.mp4?
04419dfb-266f-4f96-9be2-e928e0a08c02	67c98168-2880-4bc9-9e50-93cc382e3468	σ░Åτî½σÆ¬σÅæτÄ░Σ║åΣ╜á∩╝îσ╣╢µèèΣ╜áµëæσÇÆ	σ░Åτî½σÆ¬σÅæτÄ░Σ║åΣ╜á∩╝îσ╣╢µèèΣ╜áµëæσÇÆ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/947aac035a4dda6bd4a723eb62c75c3b~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=8ySB21QXeZ4w48NWxzPLhJU%2F60s%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	7	0	0	0	0	2023-01-10 04:44:08	2025-04-27 07:38:32.745	7186879781873453881	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/98d98cc4-e181-4501-9cc0-8c1adca36ec8.mp4?
02ecc2df-fbb3-449e-b499-c9c8eacde394	68b0b58f-a9cb-4c60-98e7-bba78537755c	σ╜ôσàëΦèÆΘüçΣ╕èΘúÄσÉ╣Θ¢¬∩╝îσ░▒σ╜óµêÉΣ║åµ╡¬µ╝½τÜä"ΘÆ╗τƒ│τ▓ë	σ╜ôσàëΦèÆΘüçΣ╕èΘúÄσÉ╣Θ¢¬∩╝îσ░▒σ╜óµêÉΣ║åµ╡¬µ╝½τÜä"ΘÆ╗τƒ│τ▓ëσ░ÿ"∩╝îσªéµ¡ñτ╛ÄσÑ╜τÜäτ₧¼Θù┤σÅ¬µâ│σêåΣ║½τ╗ÖΣ╜áτ£ï∩╝ü\n#µ▓╗µäêτ│╗ΘúÄµÖ»	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/80cfea0c6b66e124b31b377c9bc9650c~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=A7vLtfUjsVd3ePrypTPPQJxbNrQ%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	6	0	0	0	0	2023-03-22 14:59:57	2025-04-27 07:38:32.745	6911599880193723143	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/5648bd7a-973f-4780-891c-99e860013f68.mp4?
611205e8-6f68-4726-8b3e-4bf48294d3b5	740e2e0d-8fef-48e3-8059-b2149dc6fd67	ΓÇ£ΘüçΣ║ïΣ╕ìσå│σÅ»Θù«µÿÑΘúÄ∩╝îµÿÑΘúÄΣ╕ìΦ»¡σì│ΘÜÅµ£¼σ┐âΓÇ¥	ΓÇ£ΘüçΣ║ïΣ╕ìσå│σÅ»Θù«µÿÑΘúÄ∩╝îµÿÑΘúÄΣ╕ìΦ»¡σì│ΘÜÅµ£¼σ┐âΓÇ¥	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/1606cdedd281da9d99795ce7855c0e12~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=nrHwHKTjggkjViVoQjZimrCE%2FeM%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	13	0	0	0	0	2023-02-02 02:04:16	2025-04-27 07:38:32.745	7195373550470023995	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/aa91c062-8e14-455e-8351-73a2671325ff.mp4?
b3bf9c82-4f17-45bf-8d3a-a62e69073287	b1b9e562-3a32-4069-a071-8b258fde8a1a	σÅ»µÿ»ΓÇª#µäƒΦºëΦç│Σ╕è#Capperµû░Σ╕ô #C	σÅ»µÿ»ΓÇª#µäƒΦºëΦç│Σ╕è#Capperµû░Σ╕ô #Capperµû░µ¡îΘ¢¬σñ¬τù¢Σ║å	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/beb9b97b8624c58cdd24cc7b2a7b2e53~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=7YC6ANIz2I2%2FJKM6c%2F817bUbVXU%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	11	0	0	0	0	2023-03-11 08:14:09	2025-04-27 07:38:32.745	7205185045350943544	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/64877a35-378b-4173-8303-f5c3b69c8fb0.mp4?
5f5ff480-d032-40c7-9594-25a0e7fa3308	8139ad44-1aaa-44ce-8657-879c94c36f50	ΦÇüσ╕ê µÿ»µêæσüÜτÜä Σ╕èµ¼íΣ╣ƒµÿ»µêæ#Θ╗æµÜùΦìúΦÇÇ #	ΦÇüσ╕ê µÿ»µêæσüÜτÜä Σ╕èµ¼íΣ╣ƒµÿ»µêæ#Θ╗æµÜùΦìúΦÇÇ #µ£┤σªìτÅì	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/d5dcf3e20d7331669f5020af06968e04~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=p9OmTC%2BvKy5o9j6orw7L%2FgjaDGg%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	10	0	0	0	0	2023-03-31 04:23:59	2025-04-27 07:38:32.745	7216561419557456700	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/d55b645b-a4a3-4c48-8c24-67e72de12d2b.mp4?
116718f5-0782-408a-968e-92703a7b92d3	50203c28-1cda-46bc-a975-229266e69248	σÉîΘçîσÅñΘòçτÜäµ╕⌐σ⌐ëσÆîµƒöµâà∩╝îσ░▒µÿ»Σ║║Σ║║Φë│τ╛íτÜä∩╝Üσ░Å	σÉîΘçîσÅñΘòçτÜäµ╕⌐σ⌐ëσÆîµƒöµâà∩╝îσ░▒µÿ»Σ║║Σ║║Φë│τ╛íτÜä∩╝Üσ░ÅµíÑ∩╝îµ╡üµ░┤∩╝îΣ║║σ«╢πÇé#ΦïÅσ╖₧  #µÇ╗ΦªüΣ╕ïΦ╢ƒµ▒ƒσìùσÉº  #σÅñΘòç #σÉîΘçîσÅñΘòç	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/648b90aa48d3c500602c8e58c0ba44a5~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=7D4YvwQHxZEd4mmAv2ZLrBbqZSk%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	8	0	0	0	0	2023-04-12 11:58:00	2025-04-27 07:38:32.745	7220559564276615973	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/6fb65d82-29c4-4d7d-8676-2cea9cc306bb.mp4?
4733e313-6b42-423e-9915-fe10a8721600	ca67350c-0c80-438e-bae0-e249cc89ca07	ΦÉ╜σ£░τ¬ù σñºµê┐σ¡É σ░Åτïù  σÆîΣ╜á.	ΦÉ╜σ£░τ¬ù σñºµê┐σ¡É σ░Åτïù  σÆîΣ╜á.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/0d1bd710119af5c248170058a672904a~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061097200&x-signature=9NHfyhajEUrkAtASU59LzDTrVRQ%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504271538318152C569C0C0F0002848	6	0	0	0	0	2023-04-17 12:03:29	2025-04-27 07:38:32.745	7140978724920445710	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/ee873d3f-af69-47b4-a54f-6d53ee80770f.mp4?
a13e3f96-9d11-4226-9d61-a36966618910	ca67350c-0c80-438e-bae0-e249cc89ca07	Φ»┤Φ»┤µ£ÇΦ┐æΣ╕ìσ╝Çσ┐âτÜäΣ║ïσÉº.	Φ»┤Φ»┤µ£ÇΦ┐æΣ╕ìσ╝Çσ┐âτÜäΣ║ïσÉº.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/be9ec243abb1cc096bf427ff67f1160e~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=2yJITixK2RQVGN03krJHjr9bEgE%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	6	0	0	0	0	2022-11-02 12:01:34	2025-04-28 01:27:06.259	6865544093021309709	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/31f37796-ccb9-416e-af1b-fdad487206ac.mp4?
267d7d21-852d-47f6-b973-1d4c5948aa3d	b6c68fb8-4488-4054-9d49-324d3b9c6b87	τ╝ÿσêåΦÉ╜σ£░τöƒµá╣µÿ»µêæΣ╗¼	τ╝ÿσêåΦÉ╜σ£░τöƒµá╣µÿ»µêæΣ╗¼	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/16b402e4298493044b6343015fe94dd2~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=f%2BYajiKSZHZRGeSrKHq09MEBoSU%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	9	0	0	0	0	2022-10-25 14:05:04	2025-04-28 01:27:06.259	7119459095387605773	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/8b922f59-3d88-481c-8bbf-a12c21bfe674.mp4?
5fbd183f-20b5-49f9-a153-9f202c49d6a5	5b54f980-aae8-4a27-8b31-9fc4ca8d02d9			https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/c3f00aecec1093b7f4f3332fb17fa8cb~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=jBm2hdxCp1oeAQ%2FTN01EfBiGXgY%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	16	0	0	0	0	2022-12-27 10:11:21	2025-04-28 01:27:06.259	7175829928208878395	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/51ab55c3-33c6-480a-b703-aceef7eb4c1c.mp4?
28484909-769a-418f-b719-851ffe976c57	c5e62e44-3749-4c59-a354-e2fbcb85ecf5	τ¼¼548Θ¢å ∩╜£σÑ╜σû£µ¼óΣ╜á	τ¼¼548Θ¢å ∩╜£σÑ╜σû£µ¼óΣ╜á	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/c266d68fa668545a539d351d5a4f36ab~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=3Yw5CcXgLZMhxoBjQ4UkA43bXd8%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	6	0	0	0	0	2023-01-10 14:32:02	2025-04-28 01:27:06.259	6835450992658483201	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/3e442c8c-d14d-4081-8a1e-f122c021160b.mp4?
d466714c-40ae-4d6a-80c2-aef293b34eaa	172c7632-865e-4eda-a716-df39fc7802a3	merrychristmasΣ╕ìσªémarr	merrychristmasΣ╕ìσªémarryme #τï«σ¡Éσ║º #σ£úΦ»₧Φèé	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/4b0d5a3b5cc387afc8cf6407eeeefce0~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=%2F1A4kfwoYsP%2FGhGWfLp1kN1SMW4%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	7	0	0	0	0	2022-12-21 10:37:30	2025-04-28 01:27:06.259	6936440843142318862	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/3050c235-7b48-4aeb-8fba-c49244e8363e.mp4?
56f4bc4b-7dd7-48c2-9867-cdd10dc3f401	f251d46f-e915-4565-a1e0-0a1a095168bc	Σ║║µ£ÇµôàΘò┐Φ«░σ╜òτù¢Φïª┬áσ¢áΣ╕║σ╣╕τªÅτÜäµù╢σÇÖµÿ»Σ╕ìΦç¬τƒÑ	Σ║║µ£ÇµôàΘò┐Φ«░σ╜òτù¢Φïª┬áσ¢áΣ╕║σ╣╕τªÅτÜäµù╢σÇÖµÿ»Σ╕ìΦç¬τƒÑτÜä#σÄƒτ¢╕µ£║ #µ░¢σ¢┤µäƒ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/285d40ef0df17de3e7cc12ee77218308~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=jYnIRpTkBy7WqrMgRMEwdfLkCP4%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	6	0	0	0	0	2022-12-03 12:34:12	2025-04-28 01:27:06.259	6702218146272512001	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/16d49dbe-d666-4569-8b33-97433fd4c143.mp4?
1099cdcc-8654-494f-887e-692af7b9cd94	8d3bfb15-0612-48fe-82f3-b3bb3e769446	ß»àσÉæΣ╜áσÅæΦ╡╖Σ║åµüïτê▒τö│Φ»╖\n#04 #Θçæτë¢σ║º 	ß»àσÉæΣ╜áσÅæΦ╡╖Σ║åµüïτê▒τö│Φ»╖\n#04 #Θçæτë¢σ║º #τö£σª╣	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/7aa41680061e89615348379f2d6b5a66~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=YuWrzIwtft2mRYQtLM01Hojol6w%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	14	0	0	0	0	2022-12-19 10:35:07	2025-04-28 01:27:06.259	7167668747266820878	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/a013a935-7a3b-4b4c-ae59-310a596c6263.mp4?
1dda08eb-9cc8-4f0b-8174-0f3bb3f4fb9c	246dbb47-024e-4963-9bc3-6fb2a6441d0f	#τÄïΘ╣ñµúúµ╡«σ¢╛τ╝ÿΣ╕çτë⌐τÜåσÅ»Φ╜¼µîæµêÿ µ╡àσÅÿΣ╕ÇΣ╕ï#	#τÄïΘ╣ñµúúµ╡«σ¢╛τ╝ÿΣ╕çτë⌐τÜåσÅ»Φ╜¼µîæµêÿ µ╡àσÅÿΣ╕ÇΣ╕ï#µ╡«σ¢╛τ╝ÿ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/7897a28975c2f0fafa387e1722e9c47b~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=V%2FOPzqsQL8tkyMqJJrLJuGch%2Fas%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	16	0	0	0	0	2022-12-31 02:14:44	2025-04-28 01:27:06.259	7183130447738964791	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/959eeec5-b828-415f-ac69-aecb2bb73ce0.mp4?
21a3d529-3b13-4e90-ac31-f928d703345a	9d04f158-c07f-4fd6-b2ba-66dfb1a38abf	ΓÇ£Σ╕║Σ╜áσ«êτ¥ÇΘ¢╛µòúΣ║æσ╝Ç∩╝îµòàΣ║║σ╜Æµ¥ÑΓÇ¥#σ░æσ╣┤µäƒ 	ΓÇ£Σ╕║Σ╜áσ«êτ¥ÇΘ¢╛µòúΣ║æσ╝Ç∩╝îµòàΣ║║σ╜Æµ¥ÑΓÇ¥#σ░æσ╣┤µäƒ #ΦÇ╜Φ»»Σ╜áσçáτºÆσ┐âσè¿Σ╕ÇΣ╕ï #Φ╛₧µÜ«σ░öσ░öτâƒτü½σ╣┤σ╣┤ #σìùµÿîµïìτàº	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/4e66121341f324856e3e8988815baef9~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=gqyMN1fKd7NQ6ZTewPmyT%2FU9jlE%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	7	0	0	0	0	2023-01-03 09:43:27	2025-04-28 01:27:06.259	6737659425395542798	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/9850afc8-46c3-42ab-acc4-d0f3231fd269.mp4?
02f8164e-8ca3-4f70-acd5-ad74e51864e5	b347499f-58a1-432d-9b3b-fa2334addb30	ΓÇ£µ▓íΣ║║Φâ╜µï┐µìÅΣ╜Åµêæ∩╝îΘÖñΣ║åΣ╜á∩╝îµêæσ┐âτöÿµâàµä┐πÇéΓÇ¥	ΓÇ£µ▓íΣ║║Φâ╜µï┐µìÅΣ╜Åµêæ∩╝îΘÖñΣ║åΣ╜á∩╝îµêæσ┐âτöÿµâàµä┐πÇéΓÇ¥"ß┤║ß╡Æß╡çß╡Æß╡ê╩╕ ß╢£ß╡âΓü┐ ╩░ß╡Æ╦íß╡ê ß╡Éß╡ë, ß╡ë╦úß╢£ß╡ëß╡ûß╡ù ╩╕ß╡Æß╡ÿ, ß┤╡ ß╡âß╡É ╩╖Γü▒╦í╦íΓü▒Γü┐ß╡ì."	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/867a1fa7987173f1c10a6703dd9506b9~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=TUNkH2VVxHMGArCN%2Fees2TND%2Fr8%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428092705FFB5FFE640EAF020AB60	7	0	0	0	0	2022-12-30 13:16:38	2025-04-28 01:27:06.259	6666686445337447180	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/fb1102e1-8af2-4aed-b768-e71c08edf3ec.mp4?
f071798c-93c4-4734-86e5-b52c5bce5018	ca67350c-0c80-438e-bae0-e249cc89ca07	Φ»┤Φ»┤µ£ÇΦ┐æΣ╕ìσ╝Çσ┐âτÜäΣ║ïσÉº.	Φ»┤Φ»┤µ£ÇΦ┐æΣ╕ìσ╝Çσ┐âτÜäΣ║ïσÉº.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/be9ec243abb1cc096bf427ff67f1160e~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=2yJITixK2RQVGN03krJHjr9bEgE%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	6	0	0	0	0	2022-11-02 12:01:34	2025-04-28 01:29:08.487	6865544093021309709	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/d2f811e2-0e6a-44e4-9081-d32b37f28e5f.mp4?
dd1ced95-9743-40af-b9be-a90e6d9c147b	b6c68fb8-4488-4054-9d49-324d3b9c6b87	τ╝ÿσêåΦÉ╜σ£░τöƒµá╣µÿ»µêæΣ╗¼	τ╝ÿσêåΦÉ╜σ£░τöƒµá╣µÿ»µêæΣ╗¼	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/16b402e4298493044b6343015fe94dd2~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=f%2BYajiKSZHZRGeSrKHq09MEBoSU%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	9	0	0	0	0	2022-10-25 14:05:04	2025-04-28 01:29:08.487	7119459095387605773	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/f3f157a4-165e-467f-a12b-97f53ebae6c5.mp4?
cfa50a5a-e7e1-4cec-a536-7713eb3238bf	5b54f980-aae8-4a27-8b31-9fc4ca8d02d9			https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/c3f00aecec1093b7f4f3332fb17fa8cb~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=jBm2hdxCp1oeAQ%2FTN01EfBiGXgY%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	16	0	0	0	0	2022-12-27 10:11:21	2025-04-28 01:29:08.487	7175829928208878395	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/ec9c236d-aace-43b5-8933-ecfce5482e6e.mp4?
4403e6ec-a149-4889-965e-5e1020cf872d	c5e62e44-3749-4c59-a354-e2fbcb85ecf5	τ¼¼548Θ¢å ∩╜£σÑ╜σû£µ¼óΣ╜á	τ¼¼548Θ¢å ∩╜£σÑ╜σû£µ¼óΣ╜á	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/c266d68fa668545a539d351d5a4f36ab~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=3Yw5CcXgLZMhxoBjQ4UkA43bXd8%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	6	0	0	0	0	2023-01-10 14:32:02	2025-04-28 01:29:08.487	6835450992658483201	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/88ba8d28-5938-43f8-86df-7ff00d7efd3a.mp4?
88edede8-e1a0-43ab-b862-551db8d69c00	172c7632-865e-4eda-a716-df39fc7802a3	merrychristmasΣ╕ìσªémarr	merrychristmasΣ╕ìσªémarryme #τï«σ¡Éσ║º #σ£úΦ»₧Φèé	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/4b0d5a3b5cc387afc8cf6407eeeefce0~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=%2F1A4kfwoYsP%2FGhGWfLp1kN1SMW4%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	7	0	0	0	0	2022-12-21 10:37:30	2025-04-28 01:29:08.487	6936440843142318862	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/63f73bbc-f34b-4f11-8eb7-5e02f686ba00.mp4?
66dfa906-7fac-47d1-9f2f-9c6e1d5be5ce	f251d46f-e915-4565-a1e0-0a1a095168bc	Σ║║µ£ÇµôàΘò┐Φ«░σ╜òτù¢Φïª┬áσ¢áΣ╕║σ╣╕τªÅτÜäµù╢σÇÖµÿ»Σ╕ìΦç¬τƒÑ	Σ║║µ£ÇµôàΘò┐Φ«░σ╜òτù¢Φïª┬áσ¢áΣ╕║σ╣╕τªÅτÜäµù╢σÇÖµÿ»Σ╕ìΦç¬τƒÑτÜä#σÄƒτ¢╕µ£║ #µ░¢σ¢┤µäƒ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/285d40ef0df17de3e7cc12ee77218308~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=jYnIRpTkBy7WqrMgRMEwdfLkCP4%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	6	0	0	0	0	2022-12-03 12:34:12	2025-04-28 01:29:08.487	6702218146272512001	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/3c6eea29-bb57-46ea-bc6a-4db6c173ff2a.mp4?
7f31560c-abcb-4b17-a8e6-71166776fa8d	8d3bfb15-0612-48fe-82f3-b3bb3e769446	ß»àσÉæΣ╜áσÅæΦ╡╖Σ║åµüïτê▒τö│Φ»╖\n#04 #Θçæτë¢σ║º 	ß»àσÉæΣ╜áσÅæΦ╡╖Σ║åµüïτê▒τö│Φ»╖\n#04 #Θçæτë¢σ║º #τö£σª╣	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/7aa41680061e89615348379f2d6b5a66~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=YuWrzIwtft2mRYQtLM01Hojol6w%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	14	0	0	0	0	2022-12-19 10:35:07	2025-04-28 01:29:08.487	7167668747266820878	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/e0b2d437-ffca-49b2-9534-513ea945f6cd.mp4?
02c03ede-2299-4922-9aa1-9bf52cde3713	246dbb47-024e-4963-9bc3-6fb2a6441d0f	#τÄïΘ╣ñµúúµ╡«σ¢╛τ╝ÿΣ╕çτë⌐τÜåσÅ»Φ╜¼µîæµêÿ µ╡àσÅÿΣ╕ÇΣ╕ï#	#τÄïΘ╣ñµúúµ╡«σ¢╛τ╝ÿΣ╕çτë⌐τÜåσÅ»Φ╜¼µîæµêÿ µ╡àσÅÿΣ╕ÇΣ╕ï#µ╡«σ¢╛τ╝ÿ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/7897a28975c2f0fafa387e1722e9c47b~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=V%2FOPzqsQL8tkyMqJJrLJuGch%2Fas%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	16	0	0	0	0	2022-12-31 02:14:44	2025-04-28 01:29:08.487	7183130447738964791	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/c1cdee4c-2de3-4bd9-8428-3b04d5979a44.mp4?
85a6f610-34a1-4e79-8aac-409c08fd71af	9d04f158-c07f-4fd6-b2ba-66dfb1a38abf	ΓÇ£Σ╕║Σ╜áσ«êτ¥ÇΘ¢╛µòúΣ║æσ╝Ç∩╝îµòàΣ║║σ╜Æµ¥ÑΓÇ¥#σ░æσ╣┤µäƒ 	ΓÇ£Σ╕║Σ╜áσ«êτ¥ÇΘ¢╛µòúΣ║æσ╝Ç∩╝îµòàΣ║║σ╜Æµ¥ÑΓÇ¥#σ░æσ╣┤µäƒ #ΦÇ╜Φ»»Σ╜áσçáτºÆσ┐âσè¿Σ╕ÇΣ╕ï #Φ╛₧µÜ«σ░öσ░öτâƒτü½σ╣┤σ╣┤ #σìùµÿîµïìτàº	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/4e66121341f324856e3e8988815baef9~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=gqyMN1fKd7NQ6ZTewPmyT%2FU9jlE%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	7	0	0	0	0	2023-01-03 09:43:27	2025-04-28 01:29:08.487	6737659425395542798	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/6f9c7ad0-9ee6-4af7-a42a-32ab73994a5a.mp4?
eb34cbac-0e44-4937-849a-37b6e1732ade	b347499f-58a1-432d-9b3b-fa2334addb30	ΓÇ£µ▓íΣ║║Φâ╜µï┐µìÅΣ╜Åµêæ∩╝îΘÖñΣ║åΣ╜á∩╝îµêæσ┐âτöÿµâàµä┐πÇéΓÇ¥	ΓÇ£µ▓íΣ║║Φâ╜µï┐µìÅΣ╜Åµêæ∩╝îΘÖñΣ║åΣ╜á∩╝îµêæσ┐âτöÿµâàµä┐πÇéΓÇ¥"ß┤║ß╡Æß╡çß╡Æß╡ê╩╕ ß╢£ß╡âΓü┐ ╩░ß╡Æ╦íß╡ê ß╡Éß╡ë, ß╡ë╦úß╢£ß╡ëß╡ûß╡ù ╩╕ß╡Æß╡ÿ, ß┤╡ ß╡âß╡É ╩╖Γü▒╦í╦íΓü▒Γü┐ß╡ì."	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/867a1fa7987173f1c10a6703dd9506b9~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=TUNkH2VVxHMGArCN%2Fees2TND%2Fr8%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=202504280929075A742B8FBC39AA202C57	7	0	0	0	0	2022-12-30 13:16:38	2025-04-28 01:29:08.487	6666686445337447180	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/146ebe6d-5dab-47cf-bb43-1071201388e8.mp4?
d48bf4c8-903e-4ffd-873d-7e3f0ed9383d	5b54f980-aae8-4a27-8b31-9fc4ca8d02d9			https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/332ef1edc547e38bddfc75a931a6b37c~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=YgX8xBFdPAs04a4WHTyDeSJuwys%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	16	0	0	0	0	2022-12-25 09:44:06	2025-04-28 01:30:45.031	7173224993801718536	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/8d8b83d8-fe27-4a6a-9877-75242a20dacd.mp4?
9a6baaa6-9494-4b57-99be-e2322cafc189	ca67350c-0c80-438e-bae0-e249cc89ca07	σÆîΣ╜áΣ╕ÇΦ╡╖τÜäσ£úΦ»₧Φèé.	σÆîΣ╜áΣ╕ÇΦ╡╖τÜäσ£úΦ»₧Φèé.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/9a4ccd62edd0502519b4ff6046e0c74e~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=HRd94SIBe8zWmWRfQ1ymf8IIhRQ%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	6	0	0	0	0	2022-12-24 12:04:18	2025-04-28 01:30:45.031	7113912582716607240	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/6fbce72e-8bce-43aa-aa63-f09236c5c775.mp4?
8b7ebed5-3735-4360-82d9-9e0217a6be5b	6d70c500-1f52-4477-b59a-b711ba4de7d7	ΓÇ£µêæσ░ìσ»îσú½σ▒▒Φ¿▒Θíÿ σ╕îµ£¢Σ╜áµ░╕Θüáσ┐½µ¿é . ΓÇ¥	ΓÇ£µêæσ░ìσ»îσú½σ▒▒Φ¿▒Θíÿ σ╕îµ£¢Σ╜áµ░╕Θüáσ┐½µ¿é . ΓÇ¥	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/8c57ddb34e4b57e5f9fa1cf6a09d88b0~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=DxOl5WdT8RZWR%2FK4Vw2HUYfuXas%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	7	0	0	0	0	2022-12-21 15:19:20	2025-04-28 01:30:45.031	7175822742649244476	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/4b9a47b1-c4c7-4fee-bebe-cae467c1ad86.mp4?
eccdb0cf-20f2-4cc2-bae4-3da70f1206f4	5b54f980-aae8-4a27-8b31-9fc4ca8d02d9			https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/cbf7d3bd35acc920414c59ce3bde223f~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=6%2B5X9%2BF5utC1kpd5%2FhPBzrU%2FlFg%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	14	0	0	0	0	2022-12-07 10:03:34	2025-04-28 01:30:45.031	7169578628274998030	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/86de8c0c-396e-4304-876a-72aeb286ccb0.mp4?
a1bd77b7-ea53-40d7-8f17-4667d6f48c6a	759f94df-4b80-4430-ab9a-62f781ea7995	σ╛êσñÜΣ╕£ΦÑ┐τ£ïΣ╣àΣ║åΣ╝ÜΦà╗ σö»τï¼Σ╜á Φ╢èτ£ïΦ╢èσÑ╜τ£ï 	σ╛êσñÜΣ╕£ΦÑ┐τ£ïΣ╣àΣ║åΣ╝ÜΦà╗ σö»τï¼Σ╜á Φ╢èτ£ïΦ╢èσÑ╜τ£ï Φ╢èτ£ïΦ╢èσû£µ¼ó.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/dc0e3523c6257d4ba2311f5b6c8cd110~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=neoLk4Yh78zCDhQtr9XGNnGsviM%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	6	0	0	0	0	2022-12-22 05:33:32	2025-04-28 01:30:45.031	7113118272442141476	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/56df6e4d-64f8-4f2d-9b81-c478bbf95911.mp4?
c5efe716-6c73-47d1-8a13-01dcdbd94a71	ca67350c-0c80-438e-bae0-e249cc89ca07	µ£ëΣ╗ÇΣ╣êµâàτ╗¬σ░▒σÆîµêæΦ»┤σÉº µêæΣ╕ìΣ╝ÜΦ╡░τÜä µ¢┤Σ╕ìΣ╝Ü	µ£ëΣ╗ÇΣ╣êµâàτ╗¬σ░▒σÆîµêæΦ»┤σÉº µêæΣ╕ìΣ╝ÜΦ╡░τÜä µ¢┤Σ╕ìΣ╝Üσ½îΣ╜áτâª.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/b608afeea4eada9ec737f78ecf4a1b21~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=Y2SxkTMR%2Bhem90Ct2I4FkLOPu4g%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	6	0	0	0	0	2022-12-22 12:02:40	2025-04-28 01:30:45.031	7113912582716607240	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/dd3cfad3-6067-4817-b66e-e998cfa197a5.mp4?
18ef57fe-7521-475c-bcfc-40491e68738d	a8e501a7-bf16-48b6-9282-56ec64f6ef39	σÑ╜σû£µ¼óΣ╜á Σ╝ÜΦ╢èµ¥ÑΦ╢èσû£µ¼ó	σÑ╜σû£µ¼óΣ╜á Σ╝ÜΦ╢èµ¥ÑΦ╢èσû£µ¼ó	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/c9a1ae81ea4a9b42c6ca1fbac4c1ea48~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=CN%2FCLD8StC%2Ba5p1na1lgNJkGu94%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	6	0	0	0	0	2022-12-20 14:57:35	2025-04-28 01:30:45.031	7174968530301946682	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/077b41ab-f511-4e34-85b7-020f06ea05e6.mp4?
9295ec58-33a7-4891-a230-bc16c3c17daf	e296308a-3785-40a3-a69c-0306ef90be42	µ£ëΣ╜áσ£¿ µêæΦ╢àτ║ºσ╣╕τªÅ	µ£ëΣ╜áσ£¿ µêæΦ╢àτ║ºσ╣╕τªÅ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/f1e12d28b5000e04de5fa07b11a7d27b~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=P1YgRWquBfJt28KQ4FUCxbXxMvU%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	6	0	0	0	0	2023-01-04 03:42:32	2025-04-28 01:30:45.031	7169703640192535310	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/9f039992-578a-4a5c-9d9e-570137776737.mp4?
c474c32b-533d-435b-913e-a3f181ce7e3b	2a08a03a-0122-412b-aac5-cfc160776892	τâƒτü½Φ╡╖∩╝îτàºΣ║║Θù┤πÇéσû£µéªµùáΦ╛╣∩╝îΣ╕╛µ¥»µò¼µ¡ñσ╣┤πÇé≡ƒÉ░	τâƒτü½Φ╡╖∩╝îτàºΣ║║Θù┤πÇéσû£µéªµùáΦ╛╣∩╝îΣ╕╛µ¥»µò¼µ¡ñσ╣┤πÇé≡ƒÉ░	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/07a9d194cde68b8276f477734abe2469~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=FWt1o4pSae%2FHbAGPSgNyQ6yP9MM%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	11	0	0	0	0	2023-01-21 01:57:23	2025-04-28 01:30:45.031	6852323391534304008	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/9bffac78-3c37-46d4-ac53-71e37605cd5b.mp4?
67c3618d-d429-4419-9162-0e551e1e0594	23fb6f5c-315e-432e-b28b-f7de18aa2983	σìùΣ║¼Σ╕ïΘ¢¬Σ║å∩╝üµÿÄσ¡¥ΘÖ╡τÜäτ║óσóÖΣ╕ÄΘ╗äΦè▒σèáΣ╕èτ║╖µë¼τÜä	σìùΣ║¼Σ╕ïΘ¢¬Σ║å∩╝üµÿÄσ¡¥ΘÖ╡τÜäτ║óσóÖΣ╕ÄΘ╗äΦè▒σèáΣ╕èτ║╖µë¼τÜäτÖ╜Θ¢¬∩╝îσñºµªéµÿ»µ£Çµ£ëσ╣┤σæ│τÜäΘàìΦë▓Σ║å~#2023σ╣┤τ¼¼Σ╕Çσ£║Θ¢¬ #σìùΣ║¼ #σìùΣ║¼Σ╕ïΘ¢¬	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/9a685e282b6bfb5934844dd3d1fee3c7~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=IWEPkP03%2B1aEfO7bHa6P5bJQbWw%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=2025042809304476D45C85B2C319202CBE	10	0	0	0	0	2023-01-14 10:28:21	2025-04-28 01:30:45.031	7188452834415774519	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/929aedc5-19ec-48c3-8414-30a479c7ae5f.mp4?
840bad4d-20f5-48af-997e-bc5bd3c7c810	a8e501a7-bf16-48b6-9282-56ec64f6ef39	σÑ╜σû£µ¼óΣ╜á Σ╝ÜΦ╢èµ¥ÑΦ╢èσû£µ¼ó	σÑ╜σû£µ¼óΣ╜á Σ╝ÜΦ╢èµ¥ÑΦ╢èσû£µ¼ó	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/c9a1ae81ea4a9b42c6ca1fbac4c1ea48~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=CN%2FCLD8StC%2Ba5p1na1lgNJkGu94%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	6	0	0	0	0	2022-12-20 14:57:35	2025-04-28 01:32:20.457	7174968530301946682	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/8cfa26e1-2a25-4722-b449-ec4f9936333a.mp4?
0d131f9c-c774-46a1-a2a0-649e3b627639	e296308a-3785-40a3-a69c-0306ef90be42	µ£ëΣ╜áσ£¿ µêæΦ╢àτ║ºσ╣╕τªÅ	µ£ëΣ╜áσ£¿ µêæΦ╢àτ║ºσ╣╕τªÅ	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/f1e12d28b5000e04de5fa07b11a7d27b~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=P1YgRWquBfJt28KQ4FUCxbXxMvU%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	6	0	0	0	0	2023-01-04 03:42:32	2025-04-28 01:32:20.457	7169703640192535310	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/a57dabee-d57d-4bc7-afae-c98a022de767.mp4?
60f44173-63d1-4993-b863-4d1e48e0922c	2a08a03a-0122-412b-aac5-cfc160776892	τâƒτü½Φ╡╖∩╝îτàºΣ║║Θù┤πÇéσû£µéªµùáΦ╛╣∩╝îΣ╕╛µ¥»µò¼µ¡ñσ╣┤πÇé≡ƒÉ░	τâƒτü½Φ╡╖∩╝îτàºΣ║║Θù┤πÇéσû£µéªµùáΦ╛╣∩╝îΣ╕╛µ¥»µò¼µ¡ñσ╣┤πÇé≡ƒÉ░	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/07a9d194cde68b8276f477734abe2469~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=FWt1o4pSae%2FHbAGPSgNyQ6yP9MM%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	11	0	0	0	0	2023-01-21 01:57:23	2025-04-28 01:32:20.457	6852323391534304008	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/ea76281a-d6df-4a65-b155-da23ecf6e752.mp4?
75449aa9-ad3f-4900-9c46-a5cb3571c603	23fb6f5c-315e-432e-b28b-f7de18aa2983	σìùΣ║¼Σ╕ïΘ¢¬Σ║å∩╝üµÿÄσ¡¥ΘÖ╡τÜäτ║óσóÖΣ╕ÄΘ╗äΦè▒σèáΣ╕èτ║╖µë¼τÜä	σìùΣ║¼Σ╕ïΘ¢¬Σ║å∩╝üµÿÄσ¡¥ΘÖ╡τÜäτ║óσóÖΣ╕ÄΘ╗äΦè▒σèáΣ╕èτ║╖µë¼τÜäτÖ╜Θ¢¬∩╝îσñºµªéµÿ»µ£Çµ£ëσ╣┤σæ│τÜäΘàìΦë▓Σ║å~#2023σ╣┤τ¼¼Σ╕Çσ£║Θ¢¬ #σìùΣ║¼ #σìùΣ║¼Σ╕ïΘ¢¬	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/9a685e282b6bfb5934844dd3d1fee3c7~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=IWEPkP03%2B1aEfO7bHa6P5bJQbWw%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	10	0	0	0	0	2023-01-14 10:28:21	2025-04-28 01:32:20.457	7188452834415774519	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/a4d6ceed-88bd-4acd-b3c7-d99da4f62d59.mp4?
d3e86929-071d-442e-b4bf-6b8d2b57c1db	0a2beafb-ccbb-4a4d-bb83-c1d2adbec4f6	#σÄƒτÑ₧  #σè¿µÇüσúüτ║╕  #σê╗µÖ┤ σúüτ║╕σÉìτº░	#σÄƒτÑ₧  #σè¿µÇüσúüτ║╕  #σê╗µÖ┤ σúüτ║╕σÉìτº░∩╝ÜσÄƒτÑ₧ σê╗µÖ┤∩╝êPC∩╝ë Σ╜£ΦÇà∩╝ÜπÇÉStalkerπÇæ#Σ║îµ¼íσàâ #σúüτ║╕	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/c464dfb2c28623aaf52d94551c708592~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=LvMYeXnmRjFJ8pbO9mH4tOMHf1Y%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	96	0	0	0	0	2021-05-03 18:04:11	2025-04-28 01:32:20.457	6958126360753720078	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/521ba02a-a8a1-4407-98c3-2bab61372a98.mp4?
83f136bd-e15c-4921-a95d-0e12217ccb39	6d70c500-1f52-4477-b59a-b711ba4de7d7	σ╕îµ£¢Φ┐ÖΣ╕¬ΦºåΘóæ Φâ╜τ╝ôΦºúΣ╜áµëÇµ£ëτÜäτâªµü╝.	σ╕îµ£¢Φ┐ÖΣ╕¬ΦºåΘóæ Φâ╜τ╝ôΦºúΣ╜áµëÇµ£ëτÜäτâªµü╝.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/7c279fe66b500858ab96feae578b2c7f~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=NNvOvCMACwVvimAPju2cG3o0zGc%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	8	0	0	0	0	2022-12-06 09:16:23	2025-04-28 01:32:20.457	6885423590821332993	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/4d19c0af-9e3e-4c53-9769-d0cb1dcf6319.mp4?
678e7b5b-34f6-443b-830f-280f8cc2f5b1	ca67350c-0c80-438e-bae0-e249cc89ca07	µ▓ëµ╡╕σ£¿ Φ┐Öτºìµ░¢σ¢┤Θçî.	µ▓ëµ╡╕σ£¿ Φ┐Öτºìµ░¢σ¢┤Θçî.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/b49259f030a086df6d219beac5a70e6e~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=j9ccw3pD1Ks1WU%2Bra588N5kUYHI%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	6	0	0	0	0	2022-12-13 12:00:39	2025-04-28 01:32:20.457	6844110833204202253	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/7e6e63ae-0960-42df-b6c6-6ca832d84db6.mp4?
aac0fafb-ce78-442a-842d-8a3c8da8c1df	ca67350c-0c80-438e-bae0-e249cc89ca07	σåÖΣ╕ÇΣ╕¬Σ╜áΦ┐ÖΦ╛êσ¡ÉΘâ╜Σ╕ìσÅ»Φâ╜σ┐ÿΦ«░τÜäµùÑµ£ƒσÉº.	σåÖΣ╕ÇΣ╕¬Σ╜áΦ┐ÖΦ╛êσ¡ÉΘâ╜Σ╕ìσÅ»Φâ╜σ┐ÿΦ«░τÜäµùÑµ£ƒσÉº.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/32b0e3995d2a54dca595aad05588d473~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=dM1u%2BDrditSrvuMmKPIk5xbN50M%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	6	0	0	0	0	2022-11-12 11:59:41	2025-04-28 01:32:20.457	7151331474581539591	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/6f1146d8-ccdc-46b6-be29-5113f02b65df.mp4?
f1808806-c4f3-426a-a12c-c6d2813196ef	ca67350c-0c80-438e-bae0-e249cc89ca07	σ╕îµ£¢µêæτÜäσ¡ÿσ£¿Φâ╜σñƒµè╡µîíΣ╜áτÜäτâªµü╝Φ╖ƒΣ╕ìσ«ë.	σ╕îµ£¢µêæτÜäσ¡ÿσ£¿Φâ╜σñƒµè╡µîíΣ╜áτÜäτâªµü╝Φ╖ƒΣ╕ìσ«ë.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/277a4bdce3b696594a95b4456cedcdc2~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=wAXexCsiK9vIeX9hfX6axdgjdc0%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	6	0	0	0	0	2022-12-07 11:59:40	2025-04-28 01:32:20.457	7154740991518559006	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/1ccc081b-61f3-4ff8-b605-cae288f43f1a.mp4?
4d98b52d-666a-4c8e-aa82-3d26a61f6c08	ca67350c-0c80-438e-bae0-e249cc89ca07	σÆîµêæΣ╕ÇΦ╡╖µ▓ëµ║║σ£¿Φ┐ÖΣ╕¬µê┐Θù┤σÉº.	σÆîµêæΣ╕ÇΦ╡╖µ▓ëµ║║σ£¿Φ┐ÖΣ╕¬µê┐Θù┤σÉº.	https://p3-pc-sign.douyinpic.com/image-cut-tos-priv/dc7d4aa22e7b8ac471b6a9dc1b460209~tplv-dy-resize-origshort-autoq-75:330.jpeg?lk3s=138a59ce&x-expires=2061162000&x-signature=Rx0BIGbY0I8zHLkjb42cCOxGk8k%3D&from=327834062&s=PackSourceEnum_AWEME_DETAIL&se=false&sc=cover&biz_tag=pcweb_cover&l=20250428093219008BA06833EC0321EB6D	6	0	0	0	0	2022-12-10 12:04:31	2025-04-28 01:32:20.457	7041140250655492895	https://fdkvfutubzrlyyuiolcf.supabase.co/storage/v1/object/public/tiktok/748f3ae5-3cb6-4b11-8491-dc6ce84ad3cb.mp4?
\.


--
-- Data for Name: VideoHashtag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."VideoHashtag" (id, "videoId", "hashtagId") FROM stdin;
794abdcd-29d3-4007-b0e5-8d958105d4e6	afbcf66f-e047-4285-9010-2f2143bceac8	3c4875ac-3a6a-4650-b645-8faa2cb376db
9cb2f7ee-61d9-469e-957c-ecbd3712f3b4	afbcf66f-e047-4285-9010-2f2143bceac8	b9c4614a-bb0e-41ae-98b3-d798089339e7
ef29623d-aab3-4f70-b453-9dff5b25ddaa	32984cd1-b226-4b06-9f1d-27139ddbb9d5	4417a9b1-fa86-44cf-8455-f1eae45b5115
931f0140-ca1d-42aa-994c-5fef02055d64	32984cd1-b226-4b06-9f1d-27139ddbb9d5	54d87882-c835-4929-83e1-1fe1f857c6d8
84b02bf1-3ec5-4e2c-9a2d-5c50c0a30617	02ecc2df-fbb3-449e-b499-c9c8eacde394	49aea7f7-902f-45de-8544-fabecd418502
f75ca6f8-21d1-41c9-8327-82cd9e30b28e	b3bf9c82-4f17-45bf-8d3a-a62e69073287	61286e47-4edb-40a4-917e-11268dd0dc67
a4e9ff3c-cc48-4fa4-bd1e-819ee5942d9d	b3bf9c82-4f17-45bf-8d3a-a62e69073287	92d2d1ed-b0ce-4fcd-9c91-4c260e786cd6
414a3c28-4f3e-4c18-bf27-1ab835dbfa8f	b3bf9c82-4f17-45bf-8d3a-a62e69073287	5fb71c9b-fe28-450c-95f4-25218ff08b5e
06ee93a1-e3bf-4bf7-9a8e-329335f66846	5f5ff480-d032-40c7-9594-25a0e7fa3308	8dd5dd01-204d-4374-b13f-8c5a2660fbd2
206b1109-334c-41f2-8139-53d369fbf4c3	5f5ff480-d032-40c7-9594-25a0e7fa3308	6a5ef6e0-bace-46bb-ab0f-6f27d42f61f1
1d6ce373-1a6b-4d3b-afde-f64d30a99c33	116718f5-0782-408a-968e-92703a7b92d3	27d415d9-6c61-4cec-a7b6-dbfba7274520
c0cf7503-0b4e-43d1-a9cc-de5a5f65c679	116718f5-0782-408a-968e-92703a7b92d3	7512ed6f-be0a-4ad6-8bea-6785a9902f1c
98c3a64a-460c-44eb-a9f9-fc31ab6ece9c	116718f5-0782-408a-968e-92703a7b92d3	a0f19407-e5ee-4ed0-a0b8-51a59102c32c
c01533b2-1db9-4a9f-95e2-e62476eeb15c	116718f5-0782-408a-968e-92703a7b92d3	aefe29af-7861-4276-a8e5-8a312dcf07de
533b83db-abbf-46f1-8c3b-e04551f3c937	d466714c-40ae-4d6a-80c2-aef293b34eaa	dbdf4ba3-31f5-4ab9-adda-7b7d96870824
b64a28d7-15c2-4420-b7a7-25790a55412a	d466714c-40ae-4d6a-80c2-aef293b34eaa	d00e5b26-6ca3-44e6-b976-731f78b8ab23
1796475e-42b5-47cd-8d77-7013e60cccad	56f4bc4b-7dd7-48c2-9867-cdd10dc3f401	3a1c3500-901e-47a7-a2d6-ef17710f0954
4d32817a-5de3-4db8-a7ef-3ca9a6347f56	56f4bc4b-7dd7-48c2-9867-cdd10dc3f401	5c389e28-aea9-4f1d-ac56-c4ea85baed20
eaab2dd1-7c0f-411b-b3de-7f99bf4752be	1099cdcc-8654-494f-887e-692af7b9cd94	0db760d5-ab4a-41f7-a42b-55f8cd102c98
a2a98f2b-6685-4387-a519-9e145c22c50a	1099cdcc-8654-494f-887e-692af7b9cd94	bc6bf85b-5797-43ae-a987-1dd7b612033d
26edcdf4-deb8-4663-a29b-4f0d0937beb1	1099cdcc-8654-494f-887e-692af7b9cd94	f4fe86e5-3a32-497b-a109-0873dead4da8
79a0c480-d216-4295-b317-f9e1bc33a6b2	1dda08eb-9cc8-4f0b-8174-0f3bb3f4fb9c	7ae1f692-71b4-4852-a228-a0d6d5223741
357c71e0-04b9-45e2-bdd3-54940d98974f	1dda08eb-9cc8-4f0b-8174-0f3bb3f4fb9c	7a44397a-9b54-4f9f-b817-211718ee9791
c217c6cb-24ad-43cc-a1da-2e4367a49db4	21a3d529-3b13-4e90-ac31-f928d703345a	ce1efa6a-088b-4529-8a3d-c9fbbb0d1d8c
f57e7c1c-9be8-4308-bc56-4dbf724384f8	21a3d529-3b13-4e90-ac31-f928d703345a	0ee7637f-cbe6-4adc-a6db-e0d4a1959ab2
4cb1f588-17c4-4719-877b-43d15ca7b7c9	21a3d529-3b13-4e90-ac31-f928d703345a	86e06b7b-cd48-46d4-b31a-82b612e9f9ac
20b14598-60fc-4e78-8f2c-60afafea30ad	21a3d529-3b13-4e90-ac31-f928d703345a	761ce81e-3a3a-41be-bf96-8ddf6f25c256
63ff2e73-a811-40a9-81ba-0733f4125a12	88edede8-e1a0-43ab-b862-551db8d69c00	dbdf4ba3-31f5-4ab9-adda-7b7d96870824
495f7b90-4653-4ccd-958e-25c84d03761f	88edede8-e1a0-43ab-b862-551db8d69c00	d00e5b26-6ca3-44e6-b976-731f78b8ab23
36f14f32-cb97-4f2f-b8db-8acbf91d2f24	66dfa906-7fac-47d1-9f2f-9c6e1d5be5ce	3a1c3500-901e-47a7-a2d6-ef17710f0954
0f38b762-f85f-4f16-8943-078edca18180	66dfa906-7fac-47d1-9f2f-9c6e1d5be5ce	5c389e28-aea9-4f1d-ac56-c4ea85baed20
9350a409-1c2e-4b8f-865e-cae58effb17f	7f31560c-abcb-4b17-a8e6-71166776fa8d	0db760d5-ab4a-41f7-a42b-55f8cd102c98
b405c041-b058-4afe-a930-4f0790f627a7	7f31560c-abcb-4b17-a8e6-71166776fa8d	bc6bf85b-5797-43ae-a987-1dd7b612033d
32c957ba-6bb5-4bd7-b4d2-6422613db356	7f31560c-abcb-4b17-a8e6-71166776fa8d	f4fe86e5-3a32-497b-a109-0873dead4da8
976f07dd-32d3-429b-85cc-186bdb9f13d5	02c03ede-2299-4922-9aa1-9bf52cde3713	7ae1f692-71b4-4852-a228-a0d6d5223741
81d8576c-0fd7-409d-b3b6-d4ef93212f48	02c03ede-2299-4922-9aa1-9bf52cde3713	7a44397a-9b54-4f9f-b817-211718ee9791
a6d9dad2-0f3a-4bb7-ac85-690ab2498b06	85a6f610-34a1-4e79-8aac-409c08fd71af	ce1efa6a-088b-4529-8a3d-c9fbbb0d1d8c
3ee86df2-409a-45ab-bb49-53f38f1ec332	85a6f610-34a1-4e79-8aac-409c08fd71af	0ee7637f-cbe6-4adc-a6db-e0d4a1959ab2
df163145-f7c1-4279-a2ae-7fdee1d06bee	85a6f610-34a1-4e79-8aac-409c08fd71af	86e06b7b-cd48-46d4-b31a-82b612e9f9ac
d04241f0-f795-419f-9d6b-57c79d734029	85a6f610-34a1-4e79-8aac-409c08fd71af	761ce81e-3a3a-41be-bf96-8ddf6f25c256
d1d717c8-ef02-43a1-bef5-68f4ad549e21	67c3618d-d429-4419-9162-0e551e1e0594	83456008-00a4-44c5-82e9-26b02cc4027e
6db8c785-a02f-44f1-becc-b0794dfb44b3	67c3618d-d429-4419-9162-0e551e1e0594	26d39e66-f2a7-4e88-a1d7-371eee3c4a44
de1b707b-3155-427f-b345-38ef8bc32370	67c3618d-d429-4419-9162-0e551e1e0594	f1c91166-38eb-4a49-94c0-ddf131b8531e
640e703f-062d-4567-af50-695f55add4a5	75449aa9-ad3f-4900-9c46-a5cb3571c603	83456008-00a4-44c5-82e9-26b02cc4027e
b98eb07f-0e4d-491f-9445-0b32e16edfab	75449aa9-ad3f-4900-9c46-a5cb3571c603	26d39e66-f2a7-4e88-a1d7-371eee3c4a44
93193f2e-6381-4b06-8307-81cba1c87ef9	75449aa9-ad3f-4900-9c46-a5cb3571c603	f1c91166-38eb-4a49-94c0-ddf131b8531e
92b99f30-868c-46d5-a076-d8e79708c211	d3e86929-071d-442e-b4bf-6b8d2b57c1db	3a10f083-261d-4208-8e21-bb9af0b12c2f
047bdf15-d85d-4a9e-b0e4-62f70f2c7d70	d3e86929-071d-442e-b4bf-6b8d2b57c1db	9cdf84cd-f9b4-44dc-9007-b808b5adf51a
92662ee3-98bd-4c19-88c1-f33684dcba41	d3e86929-071d-442e-b4bf-6b8d2b57c1db	6b681c20-2d3f-459a-9cc4-bbaddaac48d3
a9ed9af4-840d-4e61-9671-e3a20dd441bb	d3e86929-071d-442e-b4bf-6b8d2b57c1db	f25b51cf-0199-4263-825c-c1bf5e900199
a9ce0797-cc6b-4c80-87bf-c18da1151841	d3e86929-071d-442e-b4bf-6b8d2b57c1db	b8e915e1-97c7-4418-87c4-c5d5ee15d1a3
\.


--
-- Data for Name: VideoLike; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."VideoLike" (id, "userId", "videoId", "createdAt") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
2bd4c852-39ca-408e-a24f-759c5f5c75b1	61fce82deabd9d3598e04529b4c305a7a72a928f8b26335972902354da098713	2025-04-27 07:25:40.20874+00	20250421041134_init	\N	\N	2025-04-27 07:25:40.016849+00	1
5ad82817-e733-40c5-9524-ea1ccedf0b36	8b4aa31fc6f7ef2b3a5c25884e0158805725405d0ae95a75a515f73d91f0c282	2025-04-27 07:25:40.386294+00	20250421054408_add_role_default	\N	\N	2025-04-27 07:25:40.262026+00	1
38e63151-03b2-40d4-9e3a-f54c45344c79	9821b6068651f9081f8503f1756850e98096208c20469760e93dbffc63447473	2025-04-27 07:25:40.636439+00	20250422012225_update_table	\N	\N	2025-04-27 07:25:40.43669+00	1
ad651031-b6ff-4486-940d-0e4b31467e1a	c1cc6b9b9786884dcff32a951f1a1d648c0f3558117987449617ee5e84996a49	2025-04-27 07:25:40.820162+00	20250423032159_update_schema	\N	\N	2025-04-27 07:25:40.686968+00	1
25e11a44-f30c-4737-90a3-a856e4dbad6c	db941b49d228c044ee1281d279840e8d2ca19f2c7bdb6bed69b14dc11e28851c	2025-04-27 07:25:41.008439+00	20250423100104_add_favorite_video	\N	\N	2025-04-27 07:25:40.868377+00	1
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-04-21 02:44:42
20211116045059	2025-04-21 02:44:42
20211116050929	2025-04-21 02:44:42
20211116051442	2025-04-21 02:44:42
20211116212300	2025-04-21 02:44:42
20211116213355	2025-04-21 02:44:42
20211116213934	2025-04-21 02:44:42
20211116214523	2025-04-21 02:44:42
20211122062447	2025-04-21 02:44:42
20211124070109	2025-04-21 02:44:43
20211202204204	2025-04-21 02:44:43
20211202204605	2025-04-21 02:44:43
20211210212804	2025-04-21 02:44:43
20211228014915	2025-04-21 02:44:43
20220107221237	2025-04-21 02:44:43
20220228202821	2025-04-21 02:44:43
20220312004840	2025-04-21 02:44:43
20220603231003	2025-04-21 02:44:43
20220603232444	2025-04-21 02:44:43
20220615214548	2025-04-21 02:44:43
20220712093339	2025-04-21 02:44:43
20220908172859	2025-04-21 02:44:43
20220916233421	2025-04-21 02:44:43
20230119133233	2025-04-21 02:44:43
20230128025114	2025-04-21 02:44:43
20230128025212	2025-04-21 02:44:43
20230227211149	2025-04-21 02:44:43
20230228184745	2025-04-21 02:44:43
20230308225145	2025-04-21 02:44:43
20230328144023	2025-04-21 02:44:43
20231018144023	2025-04-21 02:44:43
20231204144023	2025-04-21 02:44:43
20231204144024	2025-04-21 02:44:43
20231204144025	2025-04-21 02:44:43
20240108234812	2025-04-21 02:44:43
20240109165339	2025-04-21 02:44:43
20240227174441	2025-04-21 02:44:43
20240311171622	2025-04-21 02:44:43
20240321100241	2025-04-21 02:44:43
20240401105812	2025-04-21 02:44:43
20240418121054	2025-04-21 02:44:43
20240523004032	2025-04-21 02:44:43
20240618124746	2025-04-21 02:44:43
20240801235015	2025-04-21 02:44:43
20240805133720	2025-04-21 02:44:43
20240827160934	2025-04-21 02:44:43
20240919163303	2025-04-21 02:44:43
20240919163305	2025-04-21 02:44:43
20241019105805	2025-04-21 02:44:43
20241030150047	2025-04-21 02:44:43
20241108114728	2025-04-21 02:44:43
20241121104152	2025-04-21 02:44:43
20241130184212	2025-04-21 02:44:43
20241220035512	2025-04-21 02:44:43
20241220123912	2025-04-21 02:44:43
20241224161212	2025-04-21 02:44:43
20250107150512	2025-04-21 02:44:43
20250110162412	2025-04-21 02:44:43
20250123174212	2025-04-21 02:44:43
20250128220012	2025-04-21 02:44:43
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
tiktok	tiktok	\N	2025-04-27 07:26:44.269287+00	2025-04-27 07:26:44.269287+00	t	f	\N	\N	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-04-21 02:44:37.01156
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-04-21 02:44:37.024682
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-04-21 02:44:37.044409
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-04-21 02:44:37.068105
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-04-21 02:44:37.095052
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-04-21 02:44:37.099999
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-04-21 02:44:37.105404
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-04-21 02:44:37.110508
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-04-21 02:44:37.115757
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-04-21 02:44:37.120352
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-04-21 02:44:37.125256
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-04-21 02:44:37.13227
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-04-21 02:44:37.139745
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-04-21 02:44:37.144134
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-04-21 02:44:37.14888
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-04-21 02:44:37.18413
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-04-21 02:44:37.188665
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-04-21 02:44:37.209302
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-04-21 02:44:37.217781
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-04-21 02:44:37.230748
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-04-21 02:44:37.239258
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-04-21 02:44:37.251086
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-04-21 02:44:37.285783
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-04-21 02:44:37.307117
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-04-21 02:44:37.31671
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-04-21 02:44:37.332536
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
f5b45b3a-04d0-4069-be5d-a9b84eda8d18	tiktok	8d8b83d8-fe27-4a6a-9877-75242a20dacd.mp4	\N	2025-04-28 01:30:46.596687+00	2025-04-28 01:30:46.596687+00	2025-04-28 01:30:46.596687+00	{"eTag": "\\"2f52f259114a32090d81bcd38fd98bd5\\"", "size": 4362649, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:47.000Z", "contentLength": 4362649, "httpStatusCode": 200}	39ddaa7d-db4e-4356-ba02-3885e4207ed1	\N	{}
53c6d8f7-6b29-4b7c-a57e-cfc69a35f2b8	tiktok	6fbce72e-8bce-43aa-aa63-f09236c5c775.mp4	\N	2025-04-28 01:30:47.535323+00	2025-04-28 01:30:47.535323+00	2025-04-28 01:30:47.535323+00	{"eTag": "\\"25fe3bc05bb8022eae02530c9d3f16cf\\"", "size": 1143041, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:48.000Z", "contentLength": 1143041, "httpStatusCode": 200}	684eb278-6407-401c-8178-077f9ba4e3f3	\N	{}
2407b328-c582-4d79-937e-8f86f4b654e7	tiktok	4b9a47b1-c4c7-4fee-bebe-cae467c1ad86.mp4	\N	2025-04-28 01:30:48.673565+00	2025-04-28 01:30:48.673565+00	2025-04-28 01:30:48.673565+00	{"eTag": "\\"b4e54278a0c92fbedac6bc6beb877577\\"", "size": 2776978, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:49.000Z", "contentLength": 2776978, "httpStatusCode": 200}	2b468629-26ea-4136-8b22-fc46e56689e5	\N	{}
064be93b-ca5c-47ac-891d-2834d7e9b974	tiktok	.emptyFolderPlaceholder	\N	2025-04-27 07:33:47.066233+00	2025-04-27 07:33:47.066233+00	2025-04-27 07:33:47.066233+00	{"eTag": "\\"d41d8cd98f00b204e9800998ecf8427e\\"", "size": 0, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-27T07:33:48.000Z", "contentLength": 0, "httpStatusCode": 200}	b59723df-3843-4cd2-baba-e70e6400a47f	\N	{}
766316f3-b552-4b38-80c5-ea449b0daed1	tiktok	c034dd45-634d-4860-9962-036646c63c7f.mp4	\N	2025-04-27 07:34:06.300677+00	2025-04-27 07:34:06.300677+00	2025-04-27 07:34:06.300677+00	{"eTag": "\\"d9adfd09bd6e694bc5fb11654ed1a35e\\"", "size": 2457900, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:06.000Z", "contentLength": 2457900, "httpStatusCode": 200}	783c86dc-fe30-46d6-82a2-6619a6c97e42	\N	{}
5e1d6a77-f40d-4750-8845-5b16a69f00e7	tiktok	82b3afc9-1555-419c-91ae-e0ed0fc53853.mp4	\N	2025-04-27 07:34:07.863289+00	2025-04-27 07:34:07.863289+00	2025-04-27 07:34:07.863289+00	{"eTag": "\\"822ffa79f95d61ff47314f9604631097\\"", "size": 1524028, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:08.000Z", "contentLength": 1524028, "httpStatusCode": 200}	a6a269a8-4075-4807-aa64-3ad9e5fce721	\N	{}
e9ac62cd-4543-4f45-9c01-5cad0c8cb1f6	tiktok	87cce5f0-826e-4487-8a29-c5632e68ddc6.mp4	\N	2025-04-27 07:34:08.666653+00	2025-04-27 07:34:08.666653+00	2025-04-27 07:34:08.666653+00	{"eTag": "\\"d30f63c1c8b383d98a84d45ef0e25514\\"", "size": 2249575, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:09.000Z", "contentLength": 2249575, "httpStatusCode": 200}	09110f20-bb8d-4f2e-a604-1e9146f05214	\N	{}
7698d967-4d22-4aa9-b230-6ea1c93d68dc	tiktok	19265076-c117-4495-b0d1-8bda9da30f43.mp4	\N	2025-04-27 07:34:09.725772+00	2025-04-27 07:34:09.725772+00	2025-04-27 07:34:09.725772+00	{"eTag": "\\"fbbca19c09e6849918c2c69880d39c60\\"", "size": 3092708, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:10.000Z", "contentLength": 3092708, "httpStatusCode": 200}	8aed0adc-f35e-4792-8485-8a77239f1fb1	\N	{}
4bba2be2-e48d-4720-b678-30d18ceb1c35	tiktok	80ba5f37-85df-4924-8de1-5f74c55897bf.mp4	\N	2025-04-27 07:34:10.760493+00	2025-04-27 07:34:10.760493+00	2025-04-27 07:34:10.760493+00	{"eTag": "\\"b304c4298475f65bc75a4e8c895525f0\\"", "size": 2518330, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:11.000Z", "contentLength": 2518330, "httpStatusCode": 200}	86cdb773-c895-4fc3-8e35-3880fa959eed	\N	{}
e0bfe141-f902-4c82-8f5b-ff39e5770898	tiktok	a99c17d3-ba95-457f-af0f-bb60b849e66a.mp4	\N	2025-04-27 07:34:11.683046+00	2025-04-27 07:34:11.683046+00	2025-04-27 07:34:11.683046+00	{"eTag": "\\"d8095fecd4e6a2b51855386151711c06\\"", "size": 2005036, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:12.000Z", "contentLength": 2005036, "httpStatusCode": 200}	b3c9b50c-5961-4d38-9890-f1e51a5b32c2	\N	{}
47ce7414-24fe-4f74-95b0-96893c2599e6	tiktok	d32612ac-9c9e-4992-a6cd-d220df9647a1.mp4	\N	2025-04-27 07:34:12.857088+00	2025-04-27 07:34:12.857088+00	2025-04-27 07:34:12.857088+00	{"eTag": "\\"ed789266a8e5a4c543b2b5a7779e0090\\"", "size": 4922815, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:13.000Z", "contentLength": 4922815, "httpStatusCode": 200}	3f14639e-98c3-4d59-9e3e-f9d6855f554e	\N	{}
f3c3935d-813e-4eb5-80eb-bb4000067a20	tiktok	237b8c94-39ae-4500-87e4-619a87b04151.mp4	\N	2025-04-27 07:34:13.505085+00	2025-04-27 07:34:13.505085+00	2025-04-27 07:34:13.505085+00	{"eTag": "\\"f806ac657e00ad88c13c27bebe2ed889\\"", "size": 1915405, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:14.000Z", "contentLength": 1915405, "httpStatusCode": 200}	8cfb17bc-d53e-4f15-8829-b856c4741eb1	\N	{}
4cdbbae8-f6dc-4bd6-94b4-4496611aee94	tiktok	104bd328-1928-487b-ae79-7083ce498f5f.mp4	\N	2025-04-27 07:34:17.697798+00	2025-04-27 07:34:17.697798+00	2025-04-27 07:34:17.697798+00	{"eTag": "\\"962e93a03fb3fb6e8a0d8909b8eb0411\\"", "size": 2159885, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:34:18.000Z", "contentLength": 2159885, "httpStatusCode": 200}	509a94cb-23a1-40ee-a368-495826172b57	\N	{}
eedd06b6-e284-4c7e-a7de-19a9f9d47824	tiktok	669b4084-0ab4-4c16-ad11-b95652bd4b24.mp4	\N	2025-04-27 07:38:34.823113+00	2025-04-27 07:38:34.823113+00	2025-04-27 07:38:34.823113+00	{"eTag": "\\"ed789266a8e5a4c543b2b5a7779e0090\\"", "size": 4922815, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:35.000Z", "contentLength": 4922815, "httpStatusCode": 200}	4c82e227-05d3-4961-a821-a540985a2ef7	\N	{}
37c61068-6267-4bf9-bdb6-cb4d3274c864	tiktok	e0854ef5-a173-4697-882b-6d4705784afa.mp4	\N	2025-04-27 07:38:35.802096+00	2025-04-27 07:38:35.802096+00	2025-04-27 07:38:35.802096+00	{"eTag": "\\"f806ac657e00ad88c13c27bebe2ed889\\"", "size": 1915405, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:36.000Z", "contentLength": 1915405, "httpStatusCode": 200}	71478546-3231-408d-bc3e-91e4eb56113f	\N	{}
1ad8b698-9260-444f-a803-a8703984ac3e	tiktok	98d98cc4-e181-4501-9cc0-8c1adca36ec8.mp4	\N	2025-04-27 07:38:39.568294+00	2025-04-27 07:38:39.568294+00	2025-04-27 07:38:39.568294+00	{"eTag": "\\"962e93a03fb3fb6e8a0d8909b8eb0411\\"", "size": 2159885, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:40.000Z", "contentLength": 2159885, "httpStatusCode": 200}	4c39115a-5de6-420c-b614-54ef7f5f43a9	\N	{}
5ed8eb58-f3f8-425f-bf5e-1544bd414866	tiktok	86de8c0c-396e-4304-876a-72aeb286ccb0.mp4	\N	2025-04-28 01:30:50.225669+00	2025-04-28 01:30:50.225669+00	2025-04-28 01:30:50.225669+00	{"eTag": "\\"4d27f3d8e1c16068799ee5cbbcd535e0\\"", "size": 3159977, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:50.000Z", "contentLength": 3159977, "httpStatusCode": 200}	4db6f2b3-81ee-433a-8316-7f0f8bca27dc	\N	{}
f038c76b-6351-471b-b8c3-93e224c79337	tiktok	5648bd7a-973f-4780-891c-99e860013f68.mp4	\N	2025-04-27 07:38:40.471949+00	2025-04-27 07:38:40.471949+00	2025-04-27 07:38:40.471949+00	{"eTag": "\\"66f0bfba469754368f49885fa02929ce\\"", "size": 3738514, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:41.000Z", "contentLength": 3738514, "httpStatusCode": 200}	aedbf54f-7936-410f-9bc0-e61d689d22b7	\N	{}
45db3131-e0ed-431e-b9a3-88d23498d091	tiktok	aa91c062-8e14-455e-8351-73a2671325ff.mp4	\N	2025-04-27 07:38:41.433398+00	2025-04-27 07:38:41.433398+00	2025-04-27 07:38:41.433398+00	{"eTag": "\\"49d7ed6709c3499630a817a81cb38bef\\"", "size": 1596228, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:42.000Z", "contentLength": 1596228, "httpStatusCode": 200}	a44d2337-14fc-4a30-97c0-37481139b69e	\N	{}
6afb85cd-563a-4c2a-ba09-f73bee1501d5	tiktok	56df6e4d-64f8-4f2d-9b81-c478bbf95911.mp4	\N	2025-04-28 01:30:51.082958+00	2025-04-28 01:30:51.082958+00	2025-04-28 01:30:51.082958+00	{"eTag": "\\"312319bf651ddde8ab7fd9e1265fe971\\"", "size": 415069, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:51.000Z", "contentLength": 415069, "httpStatusCode": 200}	23d78e55-1605-4d05-84bb-eacf916b29b7	\N	{}
409cb7ed-d457-4a5e-aad2-ce76bfc81a58	tiktok	64877a35-378b-4173-8303-f5c3b69c8fb0.mp4	\N	2025-04-27 07:38:42.221929+00	2025-04-27 07:38:42.221929+00	2025-04-27 07:38:42.221929+00	{"eTag": "\\"849f127e892be704848569fca4b4e169\\"", "size": 1952437, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:43.000Z", "contentLength": 1952437, "httpStatusCode": 200}	62109c1e-6965-45a9-a319-3b4a71121eab	\N	{}
da0baaaf-69a7-435a-abb7-824d7cd5f70b	tiktok	d55b645b-a4a3-4c48-8c24-67e72de12d2b.mp4	\N	2025-04-27 07:38:43.386487+00	2025-04-27 07:38:43.386487+00	2025-04-27 07:38:43.386487+00	{"eTag": "\\"c7dee225dd8464de4451fd6f2b0daec2\\"", "size": 1701089, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:44.000Z", "contentLength": 1701089, "httpStatusCode": 200}	9be2ccc3-8276-4258-aaeb-4c9c6af6465e	\N	{}
3a0ae02f-b12f-40d7-a2f8-35f627becc3c	tiktok	dd3cfad3-6067-4817-b66e-e998cfa197a5.mp4	\N	2025-04-28 01:30:52.142734+00	2025-04-28 01:30:52.142734+00	2025-04-28 01:30:52.142734+00	{"eTag": "\\"28be378a1f6ac6131ee2cf7ee98f8612\\"", "size": 811477, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:52.000Z", "contentLength": 811477, "httpStatusCode": 200}	f32c53f9-3bc3-4f86-a06b-1f08449e618b	\N	{}
9b19c1d0-8a85-4a92-bc77-886ca02e7699	tiktok	6fb65d82-29c4-4d7d-8676-2cea9cc306bb.mp4	\N	2025-04-27 07:38:44.545981+00	2025-04-27 07:38:44.545981+00	2025-04-27 07:38:44.545981+00	{"eTag": "\\"698b3a6e3fc6b09ad9e8951d08930b37\\"", "size": 2827962, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:45.000Z", "contentLength": 2827962, "httpStatusCode": 200}	7747c0ce-d475-469b-8c7b-5d6784c30716	\N	{}
83f16929-e270-4b43-b2e8-51ea75641ebe	tiktok	ee873d3f-af69-47b4-a54f-6d53ee80770f.mp4	\N	2025-04-27 07:38:45.876681+00	2025-04-27 07:38:45.876681+00	2025-04-27 07:38:45.876681+00	{"eTag": "\\"402e6d5e99c3c8839e60bacd7e200f8a\\"", "size": 639835, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-27T07:38:46.000Z", "contentLength": 639835, "httpStatusCode": 200}	df495a41-a328-4edb-9d92-1f47e63329e2	\N	{}
12bece4f-8f26-4435-9eda-e3344b523d69	tiktok	31f37796-ccb9-416e-af1b-fdad487206ac.mp4	\N	2025-04-28 01:27:07.469824+00	2025-04-28 01:27:07.469824+00	2025-04-28 01:27:07.469824+00	{"eTag": "\\"bd73b6ead3c4b3b0905d21443776367d\\"", "size": 577435, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:08.000Z", "contentLength": 577435, "httpStatusCode": 200}	6c78d7da-8cd0-47e5-8a15-9d1c065c331b	\N	{}
ae88c183-4bd3-4cb4-aef0-ac311f954c40	tiktok	8b922f59-3d88-481c-8bbf-a12c21bfe674.mp4	\N	2025-04-28 01:27:08.407304+00	2025-04-28 01:27:08.407304+00	2025-04-28 01:27:08.407304+00	{"eTag": "\\"ed510c68b8c62d2cdab0cf933d1f555c\\"", "size": 2360682, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:09.000Z", "contentLength": 2360682, "httpStatusCode": 200}	b8ee65e6-79bc-48e7-8792-7e59d2f8920a	\N	{}
2b692963-f158-474f-ba16-f07c181484d0	tiktok	51ab55c3-33c6-480a-b703-aceef7eb4c1c.mp4	\N	2025-04-28 01:27:10.105562+00	2025-04-28 01:27:10.105562+00	2025-04-28 01:27:10.105562+00	{"eTag": "\\"b6a71fb5fd2ce5c2e1e04567320add41-2\\"", "size": 6112032, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:10.000Z", "contentLength": 6112032, "httpStatusCode": 200}	bccd9171-5494-4702-9456-031d462f016d	\N	{}
701834c0-3898-4cd4-a7d4-8a4a687842e9	tiktok	3e442c8c-d14d-4081-8a1e-f122c021160b.mp4	\N	2025-04-28 01:27:10.855851+00	2025-04-28 01:27:10.855851+00	2025-04-28 01:27:10.855851+00	{"eTag": "\\"c713c8ae71bdaf019c2c9cc531063eef\\"", "size": 1280487, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:11.000Z", "contentLength": 1280487, "httpStatusCode": 200}	53504fe5-7adb-47bd-b0f6-688c06fbce09	\N	{}
9dd80d4b-e277-4297-ad8e-68ff0f54f483	tiktok	3050c235-7b48-4aeb-8fba-c49244e8363e.mp4	\N	2025-04-28 01:27:11.673276+00	2025-04-28 01:27:11.673276+00	2025-04-28 01:27:11.673276+00	{"eTag": "\\"03cb4857130468993695f3882b38947b\\"", "size": 1715813, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:12.000Z", "contentLength": 1715813, "httpStatusCode": 200}	9c0c16c1-db6a-49ea-9c55-562d30ec28d5	\N	{}
bc4485e2-a616-4a93-86e7-8ba28751f9ee	tiktok	16d49dbe-d666-4569-8b33-97433fd4c143.mp4	\N	2025-04-28 01:27:12.755506+00	2025-04-28 01:27:12.755506+00	2025-04-28 01:27:12.755506+00	{"eTag": "\\"53febb6a01b969040ae3f2fff3665be3\\"", "size": 2093583, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:13.000Z", "contentLength": 2093583, "httpStatusCode": 200}	ccfa09ff-57b5-4445-95df-210f9f5871b7	\N	{}
bb2852a5-15ec-4894-bf94-00dcb2045f58	tiktok	077b41ab-f511-4e34-85b7-020f06ea05e6.mp4	\N	2025-04-28 01:30:53.414771+00	2025-04-28 01:30:53.414771+00	2025-04-28 01:30:53.414771+00	{"eTag": "\\"0d8c87a13c117e6a44185da6cac49806\\"", "size": 945812, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:54.000Z", "contentLength": 945812, "httpStatusCode": 200}	28dd82c5-7398-48c3-b275-6c79e0e2830d	\N	{}
63dc0b27-cb73-493c-acd6-d12425f5c3fa	tiktok	a013a935-7a3b-4b4c-ae59-310a596c6263.mp4	\N	2025-04-28 01:27:14.857431+00	2025-04-28 01:27:14.857431+00	2025-04-28 01:27:14.857431+00	{"eTag": "\\"3be8130422ce68978340865e95017b81-2\\"", "size": 7310085, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:15.000Z", "contentLength": 7310085, "httpStatusCode": 200}	9ae3c256-d55f-430d-b697-abc47a654d68	\N	{}
299234b1-2bbb-4983-9631-0f703160a3e9	tiktok	959eeec5-b828-415f-ac69-aecb2bb73ce0.mp4	\N	2025-04-28 01:27:16.847471+00	2025-04-28 01:27:16.847471+00	2025-04-28 01:27:16.847471+00	{"eTag": "\\"c63ca79a2e98e99629097b188e0f08ce-2\\"", "size": 5674603, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:17.000Z", "contentLength": 5674603, "httpStatusCode": 200}	73332331-df91-4100-a13c-bf8d5abd2dd4	\N	{}
01ca27d0-e5d3-4983-887a-c3cef05a7c3a	tiktok	9f039992-578a-4a5c-9d9e-570137776737.mp4	\N	2025-04-28 01:30:55.004079+00	2025-04-28 01:30:55.004079+00	2025-04-28 01:30:55.004079+00	{"eTag": "\\"da74e079241230b635bd69e59518313b\\"", "size": 5223131, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:55.000Z", "contentLength": 5223131, "httpStatusCode": 200}	f5004548-9098-4520-910e-d017df1bb444	\N	{}
b4ccf084-2414-458f-ae7c-93e85e281a0f	tiktok	9850afc8-46c3-42ab-acc4-d0f3231fd269.mp4	\N	2025-04-28 01:27:18.283585+00	2025-04-28 01:27:18.283585+00	2025-04-28 01:27:18.283585+00	{"eTag": "\\"bfd03b01f92c3ac0eae112f0cb9f459d\\"", "size": 3962652, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:19.000Z", "contentLength": 3962652, "httpStatusCode": 200}	cdc940ba-bb55-4dbc-b923-e2c31ab9aaff	\N	{}
f8559f50-9fbd-4009-a0f9-11769aa101c1	tiktok	fb1102e1-8af2-4aed-b768-e71c08edf3ec.mp4	\N	2025-04-28 01:27:19.785249+00	2025-04-28 01:27:19.785249+00	2025-04-28 01:27:19.785249+00	{"eTag": "\\"6ca255235e2b7de8ec5ee48115cfcf12\\"", "size": 1858804, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:27:20.000Z", "contentLength": 1858804, "httpStatusCode": 200}	7e11194f-758d-4c54-b587-9304e987f671	\N	{}
7f2eab7d-0eed-4f0b-9d4e-6d88edfd08da	tiktok	9bffac78-3c37-46d4-ac53-71e37605cd5b.mp4	\N	2025-04-28 01:30:56.175996+00	2025-04-28 01:30:56.175996+00	2025-04-28 01:30:56.175996+00	{"eTag": "\\"bb440d8a8b383223b43dd78aa43684c7\\"", "size": 2554268, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:57.000Z", "contentLength": 2554268, "httpStatusCode": 200}	f9f7d6b0-da72-41c3-a2a7-d5fa378ba3fb	\N	{}
636f42dc-b8dc-4586-b128-960e30cc2574	tiktok	d2f811e2-0e6a-44e4-9081-d32b37f28e5f.mp4	\N	2025-04-28 01:29:09.63788+00	2025-04-28 01:29:09.63788+00	2025-04-28 01:29:09.63788+00	{"eTag": "\\"bd73b6ead3c4b3b0905d21443776367d\\"", "size": 577435, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:10.000Z", "contentLength": 577435, "httpStatusCode": 200}	dea43b53-e1be-46ea-8d5f-5e0b01a1be66	\N	{}
dc5c8af3-70bd-43ee-b721-0cf30a4ab817	tiktok	f3f157a4-165e-467f-a12b-97f53ebae6c5.mp4	\N	2025-04-28 01:29:10.470874+00	2025-04-28 01:29:10.470874+00	2025-04-28 01:29:10.470874+00	{"eTag": "\\"ed510c68b8c62d2cdab0cf933d1f555c\\"", "size": 2360682, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:11.000Z", "contentLength": 2360682, "httpStatusCode": 200}	c6126560-4920-4142-a18c-a7053dfe2ecb	\N	{}
ea1eedb8-6a10-40a5-9b5e-7c11bcc5d9ef	tiktok	ec9c236d-aace-43b5-8933-ecfce5482e6e.mp4	\N	2025-04-28 01:29:12.303863+00	2025-04-28 01:29:12.303863+00	2025-04-28 01:29:12.303863+00	{"eTag": "\\"b6a71fb5fd2ce5c2e1e04567320add41-2\\"", "size": 6112032, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:12.000Z", "contentLength": 6112032, "httpStatusCode": 200}	f49bbc7a-bf7c-4f53-b739-ae7820514978	\N	{}
130ad44b-4809-49f0-adba-c02206e0336d	tiktok	88ba8d28-5938-43f8-86df-7ff00d7efd3a.mp4	\N	2025-04-28 01:29:13.041487+00	2025-04-28 01:29:13.041487+00	2025-04-28 01:29:13.041487+00	{"eTag": "\\"c713c8ae71bdaf019c2c9cc531063eef\\"", "size": 1280487, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:13.000Z", "contentLength": 1280487, "httpStatusCode": 200}	99aa032f-bb6a-4cb6-9dfc-0c8312cff2ee	\N	{}
7f947a95-a1dc-4fa6-9aa5-329ef0178e9a	tiktok	63f73bbc-f34b-4f11-8eb7-5e02f686ba00.mp4	\N	2025-04-28 01:29:13.821362+00	2025-04-28 01:29:13.821362+00	2025-04-28 01:29:13.821362+00	{"eTag": "\\"03cb4857130468993695f3882b38947b\\"", "size": 1715813, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:14.000Z", "contentLength": 1715813, "httpStatusCode": 200}	ce585825-8a43-4a4a-b38a-850906c77f68	\N	{}
872ab715-a5f6-471b-850e-c0430d567c99	tiktok	3c6eea29-bb57-46ea-bc6a-4db6c173ff2a.mp4	\N	2025-04-28 01:29:15.213312+00	2025-04-28 01:29:15.213312+00	2025-04-28 01:29:15.213312+00	{"eTag": "\\"53febb6a01b969040ae3f2fff3665be3\\"", "size": 2093583, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:15.000Z", "contentLength": 2093583, "httpStatusCode": 200}	0223642f-74fd-4c14-a1a6-25bf81dcfb3d	\N	{}
ef92d180-40d5-46ee-9034-23e1a4bfacb1	tiktok	e0b2d437-ffca-49b2-9534-513ea945f6cd.mp4	\N	2025-04-28 01:29:17.268828+00	2025-04-28 01:29:17.268828+00	2025-04-28 01:29:17.268828+00	{"eTag": "\\"3be8130422ce68978340865e95017b81-2\\"", "size": 7310085, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:17.000Z", "contentLength": 7310085, "httpStatusCode": 200}	a33e5af8-fe19-4029-bd8d-e6c1187233c9	\N	{}
57d03459-4949-4caa-83e2-89ae9218bad0	tiktok	c1cdee4c-2de3-4bd9-8428-3b04d5979a44.mp4	\N	2025-04-28 01:29:19.096912+00	2025-04-28 01:29:19.096912+00	2025-04-28 01:29:19.096912+00	{"eTag": "\\"c63ca79a2e98e99629097b188e0f08ce-2\\"", "size": 5674603, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:19.000Z", "contentLength": 5674603, "httpStatusCode": 200}	613acc4c-2399-421e-8de0-5c8be684d7b7	\N	{}
f717e487-8be6-4670-b20f-3822260e9e62	tiktok	929aedc5-19ec-48c3-8414-30a479c7ae5f.mp4	\N	2025-04-28 01:30:57.390391+00	2025-04-28 01:30:57.390391+00	2025-04-28 01:30:57.390391+00	{"eTag": "\\"452dac6c98cf1ceeedfd73b1e30e33ed\\"", "size": 2216187, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:30:58.000Z", "contentLength": 2216187, "httpStatusCode": 200}	b2241ffd-7d9f-442e-999f-5f35cfe32b0b	\N	{}
56fb4bbd-733e-45bf-8279-412f77bded9b	tiktok	6f9c7ad0-9ee6-4af7-a42a-32ab73994a5a.mp4	\N	2025-04-28 01:29:20.49465+00	2025-04-28 01:29:20.49465+00	2025-04-28 01:29:20.49465+00	{"eTag": "\\"bfd03b01f92c3ac0eae112f0cb9f459d\\"", "size": 3962652, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:21.000Z", "contentLength": 3962652, "httpStatusCode": 200}	f61fcdde-b19b-4396-b47d-30cacc38ab72	\N	{}
074ac332-2677-40c5-a023-2b47ae62d109	tiktok	146ebe6d-5dab-47cf-bb43-1071201388e8.mp4	\N	2025-04-28 01:29:21.559097+00	2025-04-28 01:29:21.559097+00	2025-04-28 01:29:21.559097+00	{"eTag": "\\"6ca255235e2b7de8ec5ee48115cfcf12\\"", "size": 1858804, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:29:22.000Z", "contentLength": 1858804, "httpStatusCode": 200}	780ceed8-57aa-4fe1-ada2-56528e5c4f7b	\N	{}
2def6fba-2626-454e-b015-4c7c0adca8c8	tiktok	8cfa26e1-2a25-4722-b449-ec4f9936333a.mp4	\N	2025-04-28 01:32:21.441084+00	2025-04-28 01:32:21.441084+00	2025-04-28 01:32:21.441084+00	{"eTag": "\\"0d8c87a13c117e6a44185da6cac49806\\"", "size": 945812, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:22.000Z", "contentLength": 945812, "httpStatusCode": 200}	7dea98ee-3f42-4870-8883-3b4a4bfd80a6	\N	{}
7fe1cc28-9569-465a-b537-6f39a6127fb5	tiktok	a57dabee-d57d-4bc7-afae-c98a022de767.mp4	\N	2025-04-28 01:32:23.069907+00	2025-04-28 01:32:23.069907+00	2025-04-28 01:32:23.069907+00	{"eTag": "\\"da74e079241230b635bd69e59518313b\\"", "size": 5223131, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:23.000Z", "contentLength": 5223131, "httpStatusCode": 200}	746d1e19-8302-4a94-8529-e6bc9fe9959d	\N	{}
f537ba15-da76-496f-8969-941f1633e6ad	tiktok	ea76281a-d6df-4a65-b155-da23ecf6e752.mp4	\N	2025-04-28 01:32:24.607795+00	2025-04-28 01:32:24.607795+00	2025-04-28 01:32:24.607795+00	{"eTag": "\\"bb440d8a8b383223b43dd78aa43684c7\\"", "size": 2554268, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:25.000Z", "contentLength": 2554268, "httpStatusCode": 200}	5cd05c71-bcba-46c6-8d72-4a7488003afe	\N	{}
74e6a918-4f52-4d65-8c60-cfc3ee4becd3	tiktok	a4d6ceed-88bd-4acd-b3c7-d99da4f62d59.mp4	\N	2025-04-28 01:32:25.579091+00	2025-04-28 01:32:25.579091+00	2025-04-28 01:32:25.579091+00	{"eTag": "\\"452dac6c98cf1ceeedfd73b1e30e33ed\\"", "size": 2216187, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:26.000Z", "contentLength": 2216187, "httpStatusCode": 200}	54acf70a-2478-45c0-be28-9c57762d9bd0	\N	{}
b5a4a922-1004-4f5d-b63b-15aa31aaa293	tiktok	521ba02a-a8a1-4407-98c3-2bab61372a98.mp4	\N	2025-04-28 01:32:29.948898+00	2025-04-28 01:32:29.948898+00	2025-04-28 01:32:29.948898+00	{"eTag": "\\"c968356697a573a041ca2648857cd8d4-4\\"", "size": 18585359, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:30.000Z", "contentLength": 18585359, "httpStatusCode": 200}	79ebb498-3b30-4195-99e0-73e1e9c001b3	\N	{}
96f335b8-64cd-41b2-bee0-2e4d553f733d	tiktok	4d19c0af-9e3e-4c53-9769-d0cb1dcf6319.mp4	\N	2025-04-28 01:32:31.502164+00	2025-04-28 01:32:31.502164+00	2025-04-28 01:32:31.502164+00	{"eTag": "\\"5b478dd9d5a6d2c7fe4548db11c8de03\\"", "size": 1364223, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:32.000Z", "contentLength": 1364223, "httpStatusCode": 200}	1b8f0c98-6aa4-4f96-8863-4f0f2b3db7d2	\N	{}
58485f23-f279-44a1-981e-30624a307330	tiktok	7e6e63ae-0960-42df-b6c6-6ca832d84db6.mp4	\N	2025-04-28 01:32:32.528244+00	2025-04-28 01:32:32.528244+00	2025-04-28 01:32:32.528244+00	{"eTag": "\\"980a8830e30dd466015ffcb4c9478dd4\\"", "size": 1139923, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:33.000Z", "contentLength": 1139923, "httpStatusCode": 200}	6d2ed8f9-418e-4b66-9c9a-cf632d4573d3	\N	{}
4a627395-6d41-4893-8baf-552b78899efb	tiktok	6f1146d8-ccdc-46b6-be29-5113f02b65df.mp4	\N	2025-04-28 01:32:33.412806+00	2025-04-28 01:32:33.412806+00	2025-04-28 01:32:33.412806+00	{"eTag": "\\"abff60cac5c6691a052542fccbecb920\\"", "size": 897759, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:34.000Z", "contentLength": 897759, "httpStatusCode": 200}	11d566bb-4487-4c1b-8565-5752ffc4b64d	\N	{}
f7ce9e03-6e12-4917-b3da-0ea5743dbcaf	tiktok	1ccc081b-61f3-4ff8-b605-cae288f43f1a.mp4	\N	2025-04-28 01:32:34.245893+00	2025-04-28 01:32:34.245893+00	2025-04-28 01:32:34.245893+00	{"eTag": "\\"136eed2e42d29dc77a27d003335d2057\\"", "size": 938902, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:35.000Z", "contentLength": 938902, "httpStatusCode": 200}	bbbc288e-0dad-4e91-a35b-c45f611b33ea	\N	{}
128f502a-c8e1-45b9-8d7f-50e59fd2c9cb	tiktok	748f3ae5-3cb6-4b11-8491-dc6ce84ad3cb.mp4	\N	2025-04-28 01:32:35.099797+00	2025-04-28 01:32:35.099797+00	2025-04-28 01:32:35.099797+00	{"eTag": "\\"7acf95e2e77e75b6061601020d8d2e77\\"", "size": 1110197, "mimetype": "video/mp4", "cacheControl": "no-cache", "lastModified": "2025-04-28T01:32:35.000Z", "contentLength": 1110197, "httpStatusCode": 200}	9a32d65e-887d-48df-acec-aa4223950578	\N	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: Author Author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Author"
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY (id);


--
-- Name: CommentLike CommentLike_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_pkey" PRIMARY KEY (id);


--
-- Name: Comment Comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (id);


--
-- Name: FavoriteVideo FavoriteVideo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriteVideo"
    ADD CONSTRAINT "FavoriteVideo_pkey" PRIMARY KEY (id);


--
-- Name: Follow Follow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Follow"
    ADD CONSTRAINT "Follow_pkey" PRIMARY KEY (id);


--
-- Name: Hashtag Hashtag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hashtag"
    ADD CONSTRAINT "Hashtag_pkey" PRIMARY KEY (id);


--
-- Name: Music Music_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Music"
    ADD CONSTRAINT "Music_pkey" PRIMARY KEY (id);


--
-- Name: Reply Reply_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reply"
    ADD CONSTRAINT "Reply_pkey" PRIMARY KEY (id);


--
-- Name: VideoHashtag VideoHashtag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideoHashtag"
    ADD CONSTRAINT "VideoHashtag_pkey" PRIMARY KEY (id);


--
-- Name: VideoLike VideoLike_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideoLike"
    ADD CONSTRAINT "VideoLike_pkey" PRIMARY KEY (id);


--
-- Name: Video Video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Video"
    ADD CONSTRAINT "Video_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: Author_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Author_email_key" ON public."Author" USING btree (email);


--
-- Name: Author_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Author_username_key" ON public."Author" USING btree (username);


--
-- Name: FavoriteVideo_userId_videoId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "FavoriteVideo_userId_videoId_key" ON public."FavoriteVideo" USING btree ("userId", "videoId");


--
-- Name: Follow_followerId_followingId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Follow_followerId_followingId_key" ON public."Follow" USING btree ("followerId", "followingId");


--
-- Name: Hashtag_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Hashtag_name_key" ON public."Hashtag" USING btree (name);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: CommentLike CommentLike_commentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES public."Comment"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CommentLike CommentLike_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Comment Comment_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Comment Comment_videoId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES public."Video"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: FavoriteVideo FavoriteVideo_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriteVideo"
    ADD CONSTRAINT "FavoriteVideo_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: FavoriteVideo FavoriteVideo_videoId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriteVideo"
    ADD CONSTRAINT "FavoriteVideo_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES public."Video"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Follow Follow_followerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Follow"
    ADD CONSTRAINT "Follow_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Follow Follow_followingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Follow"
    ADD CONSTRAINT "Follow_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Reply Reply_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reply"
    ADD CONSTRAINT "Reply_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Reply Reply_commentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reply"
    ADD CONSTRAINT "Reply_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES public."Comment"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VideoHashtag VideoHashtag_hashtagId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideoHashtag"
    ADD CONSTRAINT "VideoHashtag_hashtagId_fkey" FOREIGN KEY ("hashtagId") REFERENCES public."Hashtag"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VideoHashtag VideoHashtag_videoId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideoHashtag"
    ADD CONSTRAINT "VideoHashtag_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES public."Video"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VideoLike VideoLike_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideoLike"
    ADD CONSTRAINT "VideoLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VideoLike VideoLike_videoId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VideoLike"
    ADD CONSTRAINT "VideoLike_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES public."Video"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Video Video_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Video"
    ADD CONSTRAINT "Video_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."Author"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Video Video_musicId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Video"
    ADD CONSTRAINT "Video_musicId_fkey" FOREIGN KEY ("musicId") REFERENCES public."Music"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- Name: FUNCTION operation(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.operation() TO postgres;


--
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

