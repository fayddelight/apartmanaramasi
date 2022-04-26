--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admins (
    id uuid NOT NULL,
    name character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: offers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offers (
    id uuid NOT NULL,
    title character varying(50) NOT NULL,
    company character varying(30) NOT NULL,
    description character varying(1000),
    location character varying(50) NOT NULL,
    url character varying(255) NOT NULL,
    published_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    district character varying(255) NOT NULL,
    flat_type character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    summary text NOT NULL,
    contact_email character varying(255) NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: admins_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX admins_email_index ON public.admins USING btree (email);


--
-- Name: offers_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX offers_slug_index ON public.offers USING btree (slug);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20170911140505);
INSERT INTO public."schema_migrations" (version) VALUES (20170911144639);
INSERT INTO public."schema_migrations" (version) VALUES (20170913192410);
INSERT INTO public."schema_migrations" (version) VALUES (20170914194826);
INSERT INTO public."schema_migrations" (version) VALUES (20171001195406);
INSERT INTO public."schema_migrations" (version) VALUES (20171002122508);
INSERT INTO public."schema_migrations" (version) VALUES (20180504222508);
INSERT INTO public."schema_migrations" (version) VALUES (20190824082508);
INSERT INTO public."schema_migrations" (version) VALUES (20190824101839);
INSERT INTO public."schema_migrations" (version) VALUES (20200208134001);
INSERT INTO public."schema_migrations" (version) VALUES (20200208134019);
