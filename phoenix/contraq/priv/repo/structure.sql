--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: gigs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gigs (
    id integer NOT NULL,
    name character varying NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    venue character varying,
    street character varying,
    city character varying,
    state character varying(2),
    zip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    amount_due numeric(8,2),
    terms smallint
);


--
-- Name: gigs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gigs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gigs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gigs_id_seq OWNED BY gigs.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE payments (
    id bigint NOT NULL,
    gig_id bigint NOT NULL,
    received_at date,
    amount numeric(8,2),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- Name: rememberables; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rememberables (
    id bigint NOT NULL,
    series_hash character varying(255),
    token_hash character varying(255),
    token_created_at timestamp without time zone,
    user_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rememberables_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rememberables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rememberables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rememberables_id_seq OWNED BY rememberables.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: schema_migrations_phoenix; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations_phoenix (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    password_hash character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    inserted_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: gigs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gigs ALTER COLUMN id SET DEFAULT nextval('gigs_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


--
-- Name: rememberables id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rememberables ALTER COLUMN id SET DEFAULT nextval('rememberables_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: gigs gigs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gigs
    ADD CONSTRAINT gigs_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: rememberables rememberables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rememberables
    ADD CONSTRAINT rememberables_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_phoenix schema_migrations_phoenix_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations_phoenix
    ADD CONSTRAINT schema_migrations_phoenix_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_payments_on_gig_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_gig_id ON payments USING btree (gig_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: rememberables_series_hash_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rememberables_series_hash_index ON rememberables USING btree (series_hash);


--
-- Name: rememberables_token_hash_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rememberables_token_hash_index ON rememberables USING btree (token_hash);


--
-- Name: rememberables_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rememberables_user_id_index ON rememberables USING btree (user_id);


--
-- Name: rememberables_user_id_series_hash_token_hash_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX rememberables_user_id_series_hash_token_hash_index ON rememberables USING btree (user_id, series_hash, token_hash);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: gigs fk_rails_d872f8ccad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gigs
    ADD CONSTRAINT fk_rails_d872f8ccad FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: payments fk_rails_fad920bc30; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT fk_rails_fad920bc30 FOREIGN KEY (gig_id) REFERENCES gigs(id);


--
-- Name: rememberables rememberables_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rememberables
    ADD CONSTRAINT rememberables_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations_phoenix" (version) VALUES (20180227052552), (20180227052553);

