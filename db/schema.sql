--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: careers; Type: TABLE; Schema: public; Owner: todd; Tablespace: 
--

CREATE TABLE careers (
    id integer NOT NULL,
    name text NOT NULL,
    sector text NOT NULL,
    description text,
    certification_required boolean DEFAULT false NOT NULL,
    training text,
    general_duties text,
    experienced_range text,
    entry_wage text,
    career_image text,
    alt_title text
);


ALTER TABLE public.careers OWNER TO todd;

--
-- Name: careers_id_seq; Type: SEQUENCE; Schema: public; Owner: todd
--

CREATE SEQUENCE careers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.careers_id_seq OWNER TO todd;

--
-- Name: careers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: todd
--

ALTER SEQUENCE careers_id_seq OWNED BY careers.id;


--
-- Name: careers_traits; Type: TABLE; Schema: public; Owner: todd; Tablespace: 
--

CREATE TABLE careers_traits (
    career_id integer NOT NULL,
    trait_id integer NOT NULL
);


ALTER TABLE public.careers_traits OWNER TO todd;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: todd; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    referral text NOT NULL,
    neighborhood text NOT NULL,
    best_way text NOT NULL,
    email_submission text NOT NULL,
    text_submission text NOT NULL,
    phone_submission text NOT NULL,
    young_adult boolean DEFAULT false NOT NULL,
    veteran boolean DEFAULT false NOT NULL,
    no_transportation boolean DEFAULT false NOT NULL,
    homeless boolean DEFAULT false NOT NULL,
    no_drivers_license boolean DEFAULT false NOT NULL,
    no_state_id boolean DEFAULT false NOT NULL,
    disabled boolean DEFAULT false,
    childcare boolean DEFAULT false,
    criminal boolean DEFAULT false,
    previously_incarcerated boolean DEFAULT false,
    using_drugs boolean DEFAULT false,
    none_of_above boolean DEFAULT false
);


ALTER TABLE public.contacts OWNER TO todd;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: todd
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO todd;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: todd
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: schema_info; Type: TABLE; Schema: public; Owner: todd; Tablespace: 
--

CREATE TABLE schema_info (
    version integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.schema_info OWNER TO todd;

--
-- Name: schema_seeds; Type: TABLE; Schema: public; Owner: todd; Tablespace: 
--

CREATE TABLE schema_seeds (
    filename text NOT NULL
);


ALTER TABLE public.schema_seeds OWNER TO todd;

--
-- Name: traits; Type: TABLE; Schema: public; Owner: todd; Tablespace: 
--

CREATE TABLE traits (
    id integer NOT NULL,
    name text NOT NULL,
    spreadsheet_key integer
);


ALTER TABLE public.traits OWNER TO todd;

--
-- Name: traits_id_seq; Type: SEQUENCE; Schema: public; Owner: todd
--

CREATE SEQUENCE traits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.traits_id_seq OWNER TO todd;

--
-- Name: traits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: todd
--

ALTER SEQUENCE traits_id_seq OWNED BY traits.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: todd
--

ALTER TABLE ONLY careers ALTER COLUMN id SET DEFAULT nextval('careers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: todd
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: todd
--

ALTER TABLE ONLY traits ALTER COLUMN id SET DEFAULT nextval('traits_id_seq'::regclass);


--
-- Name: careers_pkey; Type: CONSTRAINT; Schema: public; Owner: todd; Tablespace: 
--

ALTER TABLE ONLY careers
    ADD CONSTRAINT careers_pkey PRIMARY KEY (id);


--
-- Name: careers_traits_pkey; Type: CONSTRAINT; Schema: public; Owner: todd; Tablespace: 
--

ALTER TABLE ONLY careers_traits
    ADD CONSTRAINT careers_traits_pkey PRIMARY KEY (career_id, trait_id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: todd; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: schema_seeds_pkey; Type: CONSTRAINT; Schema: public; Owner: todd; Tablespace: 
--

ALTER TABLE ONLY schema_seeds
    ADD CONSTRAINT schema_seeds_pkey PRIMARY KEY (filename);


--
-- Name: traits_pkey; Type: CONSTRAINT; Schema: public; Owner: todd; Tablespace: 
--

ALTER TABLE ONLY traits
    ADD CONSTRAINT traits_pkey PRIMARY KEY (id);


--
-- Name: careers_traits_trait_id_career_id_index; Type: INDEX; Schema: public; Owner: todd; Tablespace: 
--

CREATE INDEX careers_traits_trait_id_career_id_index ON careers_traits USING btree (trait_id, career_id);


--
-- Name: careers_traits_career_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: todd
--

ALTER TABLE ONLY careers_traits
    ADD CONSTRAINT careers_traits_career_id_fkey FOREIGN KEY (career_id) REFERENCES careers(id);


--
-- Name: careers_traits_trait_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: todd
--

ALTER TABLE ONLY careers_traits
    ADD CONSTRAINT careers_traits_trait_id_fkey FOREIGN KEY (trait_id) REFERENCES traits(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

