--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

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
-- Name: appointments; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.appointments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    doctor_id bigint,
    patient_id bigint NOT NULL,
    slot_start_datetime timestamp(6) without time zone,
    slot_end_datetime timestamp(6) without time zone,
    appointment_type character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.appointments OWNER TO ue;

--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointments_id_seq OWNER TO ue;

--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO ue;

--
-- Name: beds; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.beds (
    id bigint NOT NULL,
    ward_type character varying,
    bed_no character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.beds OWNER TO ue;

--
-- Name: beds_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.beds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beds_id_seq OWNER TO ue;

--
-- Name: beds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.beds_id_seq OWNED BY public.beds.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.departments (
    id bigint NOT NULL,
    name character varying,
    address character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.departments OWNER TO ue;

--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_id_seq OWNER TO ue;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- Name: doctor_details; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.doctor_details (
    id bigint NOT NULL,
    regno character varying,
    department_id bigint NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    required_time_slot integer,
    qualification character varying,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.doctor_details OWNER TO ue;

--
-- Name: doctor_details_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.doctor_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doctor_details_id_seq OWNER TO ue;

--
-- Name: doctor_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.doctor_details_id_seq OWNED BY public.doctor_details.id;


--
-- Name: ipds; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.ipds (
    id bigint NOT NULL,
    patient_id bigint NOT NULL,
    department_id bigint NOT NULL,
    treatment_description character varying,
    admission_datetime timestamp(6) without time zone,
    discharge_datetime timestamp(6) without time zone,
    bed_id bigint NOT NULL,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ipds OWNER TO ue;

--
-- Name: ipds_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.ipds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipds_id_seq OWNER TO ue;

--
-- Name: ipds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.ipds_id_seq OWNED BY public.ipds.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.patients (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    birthdate date,
    gender character varying,
    contact character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.patients OWNER TO ue;

--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patients_id_seq OWNER TO ue;

--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO ue;

--
-- Name: treatments; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.treatments (
    id bigint NOT NULL,
    ipd_id bigint NOT NULL,
    description text,
    datetime timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.treatments OWNER TO ue;

--
-- Name: treatments_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.treatments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.treatments_id_seq OWNER TO ue;

--
-- Name: treatments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.treatments_id_seq OWNED BY public.treatments.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    contact character varying,
    password character varying,
    role character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    password_digest character varying,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone
);


ALTER TABLE public.users OWNER TO ue;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO ue;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: ue
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id bigint NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.versions OWNER TO ue;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: ue
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO ue;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ue
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: beds id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.beds ALTER COLUMN id SET DEFAULT nextval('public.beds_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: doctor_details id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.doctor_details ALTER COLUMN id SET DEFAULT nextval('public.doctor_details_id_seq'::regclass);


--
-- Name: ipds id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.ipds ALTER COLUMN id SET DEFAULT nextval('public.ipds_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Name: treatments id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.treatments ALTER COLUMN id SET DEFAULT nextval('public.treatments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.appointments (id, user_id, doctor_id, patient_id, slot_start_datetime, slot_end_datetime, appointment_type, status, created_at, updated_at) FROM stdin;
9	3	42	13	2024-04-20 13:00:00	2024-04-20 13:30:00	followup	cancelled	2024-04-19 12:05:42.133925	2024-04-19 12:41:44.224384
6	1	42	12	2024-04-19 12:00:00	2024-04-19 12:30:00	checkup	cancelled	2024-04-19 11:13:47.637199	2024-04-19 14:27:53.481282
21	46	45	16	2024-05-06 07:00:00	2024-05-06 07:15:00	followup	cancelled	2024-05-06 06:31:33.851641	2024-05-06 14:04:48.976448
20	46	33	16	2024-05-04 14:15:00	2024-05-04 14:30:00	followup	cancelled	2024-05-04 10:54:18.157214	2024-05-07 06:06:48.834788
4	6	33	1	2024-04-18 17:30:00	2024-04-18 17:45:00	checkup	cancelled	2024-04-18 11:55:25.254221	2024-05-07 06:07:05.908995
19	46	35	16	2024-05-04 14:00:00	2024-05-04 14:15:00	followup	cancelled	2024-05-04 10:53:01.405644	2024-05-07 06:23:53.053144
17	46	33	15	2024-05-04 10:30:00	2024-05-04 16:15:00	followup	checked	2024-05-04 08:08:45.293068	2024-05-07 06:53:07.285895
1	10	39	2	2024-04-16 08:00:00	2024-04-16 08:15:00	checkup	checked	2024-04-16 11:14:10.782436	2024-05-07 08:10:30.351036
2	11	39	3	2024-04-16 09:00:00	2024-04-16 09:15:00	checkup	checked	2024-04-16 11:14:55.030601	2024-05-07 12:33:02.864423
3	11	39	4	2024-04-17 13:30:00	2024-04-16 14:00:00	checkup	checked	2024-04-17 07:11:13.876848	2024-05-07 12:33:02.874221
5	40	33	11	2024-04-19 13:30:00	2024-04-19 13:45:00	checkup	checked	2024-04-19 06:04:24.88589	2024-05-07 12:33:02.877779
7	2	42	6	2024-04-19 13:00:00	2024-04-19 13:30:00	followup	checked	2024-04-19 11:16:34.265316	2024-05-07 12:33:02.880338
8	2	42	8	2024-04-20 13:00:00	2024-04-20 13:30:00	followup	checked	2024-04-19 11:17:40.209453	2024-05-07 12:33:02.882378
10	2	42	8	2024-04-25 14:30:00	2024-04-25 15:00:00	followup	checked	2024-04-25 12:49:19.50753	2024-05-07 12:33:02.884629
12	2	42	6	2024-04-25 14:30:00	2024-04-25 15:00:00	followup	checked	2024-04-25 13:22:13.894965	2024-05-07 12:33:02.88686
25	46	45	15	2024-05-09 06:30:00	2024-05-09 06:40:00	followup	scheduled	2024-05-09 05:31:23.535348	2024-05-09 05:31:23.535348
26	46	45	16	2024-05-09 06:40:00	2024-05-09 06:50:00	followup	scheduled	2024-05-09 05:31:44.486481	2024-05-09 05:31:44.486481
27	46	45	17	2024-05-09 08:10:00	2024-05-09 08:20:00	followup	scheduled	2024-05-09 05:31:59.63336	2024-05-09 05:31:59.63336
22	46	42	15	2024-05-07 10:30:00	2024-05-07 11:00:00	followup	checked	2024-05-07 06:29:05.058329	2024-05-09 05:33:07.415851
23	46	45	15	2024-05-07 08:30:00	2024-05-07 08:45:00	followup	checked	2024-05-07 06:31:42.590026	2024-05-09 05:33:07.419295
24	46	33	15	2024-05-08 14:00:00	2024-05-08 14:15:00	followup	checked	2024-05-08 11:02:18.286823	2024-05-09 05:33:07.421504
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-04-16 08:28:22.715774	2024-04-16 08:28:22.715776
\.


--
-- Data for Name: beds; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.beds (id, ward_type, bed_no, status, created_at, updated_at) FROM stdin;
2	ICU	2	vaccant	2024-04-16 08:38:44.799845	2024-04-16 08:38:44.799845
3	ICU	3	vaccant	2024-04-16 08:38:44.802571	2024-04-16 08:38:44.802571
4	ICU	4	vaccant	2024-04-16 08:38:44.805057	2024-04-16 08:38:44.805057
7	ICU	7	vaccant	2024-04-16 08:38:44.812611	2024-04-16 08:38:44.812611
9	ICU	9	vaccant	2024-04-16 08:38:44.817629	2024-04-16 08:38:44.817629
15	IICU	5	vaccant	2024-04-16 08:38:44.83366	2024-04-16 08:38:44.83366
16	IICU	6	vaccant	2024-04-16 08:38:44.837135	2024-04-16 08:38:44.837135
17	IICU	7	vaccant	2024-04-16 08:38:44.839508	2024-04-16 08:38:44.839508
19	IICU	9	vaccant	2024-04-16 08:38:44.844959	2024-04-16 08:38:44.844959
20	IICU	10	vaccant	2024-04-16 08:38:44.847987	2024-04-16 08:38:44.847987
26	Emergency	6	vaccant	2024-04-16 08:38:44.863902	2024-04-16 08:38:44.863902
28	Emergency	8	vaccant	2024-04-16 08:38:44.869131	2024-04-16 08:38:44.869131
29	Emergency	9	vaccant	2024-04-16 08:38:44.871581	2024-04-16 08:38:44.871581
35	Surgical	5	vaccant	2024-04-16 08:38:44.889126	2024-04-16 08:38:44.889126
36	Surgical	6	vaccant	2024-04-16 08:38:44.891908	2024-04-16 08:38:44.891908
37	Surgical	7	vaccant	2024-04-16 08:38:44.894396	2024-04-16 08:38:44.894396
38	Surgical	8	vaccant	2024-04-16 08:38:44.897014	2024-04-16 08:38:44.897014
39	Surgical	9	vaccant	2024-04-16 08:38:44.899301	2024-04-16 08:38:44.899301
40	Surgical	10	vaccant	2024-04-16 08:38:44.901783	2024-04-16 08:38:44.901783
49	Pediatric	9	vaccant	2024-04-16 08:38:44.926744	2024-04-16 08:38:44.926744
50	Pediatric	10	vaccant	2024-04-16 08:38:44.929062	2024-04-16 08:38:44.929062
59	Maternity	9	vaccant	2024-04-16 08:38:44.952842	2024-04-16 08:38:44.952842
61	Psychiatric	1	vaccant	2024-04-16 08:38:44.958353	2024-04-16 08:38:44.958353
62	Psychiatric	2	vaccant	2024-04-16 08:38:44.960763	2024-04-16 08:38:44.960763
63	Psychiatric	3	vaccant	2024-04-16 08:38:44.963505	2024-04-16 08:38:44.963505
65	Psychiatric	5	vaccant	2024-04-16 08:38:44.968418	2024-04-16 08:38:44.968418
66	Psychiatric	6	vaccant	2024-04-16 08:38:44.970728	2024-04-16 08:38:44.970728
67	Psychiatric	7	vaccant	2024-04-16 08:38:44.973325	2024-04-16 08:38:44.973325
68	Psychiatric	8	vaccant	2024-04-16 08:38:44.975652	2024-04-16 08:38:44.975652
69	Psychiatric	9	vaccant	2024-04-16 08:38:44.978298	2024-04-16 08:38:44.978298
11	IICU	1	acquired	2024-04-16 08:38:44.822794	2024-04-16 08:38:44.822794
30	Emergency	10	vaccant	2024-04-16 08:38:44.874949	2024-05-02 09:45:00.141275
46	Pediatric	6	acquired	2024-04-16 08:38:44.918723	2024-04-16 08:38:44.918723
54	Maternity	4	acquired	2024-04-16 08:38:44.938811	2024-04-16 08:38:44.938811
52	Maternity	2	unavailable	2024-04-16 08:38:44.933977	2024-05-03 08:12:21.630484
53	Maternity	3	unavailable	2024-04-16 08:38:44.93658	2024-05-03 08:13:50.457444
55	Maternity	5	unavailable	2024-04-16 08:38:44.941354	2024-05-03 08:16:07.711875
57	Maternity	7	unavailable	2024-04-16 08:38:44.946698	2024-05-03 08:18:45.4664
5	ICU	5	vaccant	2024-04-16 08:38:44.807289	2024-04-18 14:26:05.516399
56	Maternity	6	unavailable	2024-04-16 08:38:44.94366	2024-05-02 07:43:42.686764
23	Emergency	3	unavailable	2024-04-16 08:38:44.855663	2024-05-03 08:21:57.219166
45	Pediatric	5	vaccant	2024-04-16 08:38:44.916154	2024-05-02 07:59:01.256229
24	Emergency	4	unavailable	2024-04-16 08:38:44.85854	2024-05-03 08:26:42.741739
27	Emergency	7	vaccant	2024-04-16 08:38:44.866309	2024-05-02 09:45:19.303511
58	Maternity	8	unavailable	2024-04-16 08:38:44.94925	2024-05-03 08:44:49.113469
64	Psychiatric	4	unavailable	2024-04-16 08:38:44.965767	2024-05-02 08:11:24.627752
1	ICU	13	vaccant	2024-04-16 08:38:44.796954	2024-04-19 06:28:59.848029
31	Surgical	1	vaccant	2024-04-16 08:38:44.8775	2024-05-02 08:12:48.62778
18	IICU	8	acquired	2024-04-16 08:38:44.842358	2024-05-08 13:49:15.041331
70	Psychiatric	10	vaccant	2024-04-16 08:38:44.98057	2024-04-19 10:50:45.639914
25	Emergency	5	acquired	2024-04-16 08:38:44.860906	2024-05-09 05:05:42.016538
32	Surgical	2	acquired	2024-04-16 08:38:44.880597	2024-05-09 05:06:21.967794
34	Surgical	4	acquired	2024-04-16 08:38:44.886563	2024-05-09 05:08:10.093612
6	ICU	6	vaccant	2024-04-16 08:38:44.810059	2024-04-19 12:36:21.383668
60	Maternity	10	vaccant	2024-04-16 08:38:44.955397	2024-04-25 12:42:36.771018
8	ICU	8	vaccant	2024-04-16 08:38:44.815148	2024-04-25 12:44:09.125358
10	ICU	10	acquired	2024-04-16 08:38:44.820223	2024-04-30 10:09:15.941603
13	IICU	3	acquired	2024-04-16 08:38:44.827838	2024-04-30 11:48:21.95169
47	Pediatric	7	unavailable	2024-04-16 08:38:44.921687	2024-05-03 07:24:57.087953
48	Pediatric	8	unavailable	2024-04-16 08:38:44.924009	2024-05-03 07:25:38.932173
21	Emergency	1	unavailable	2024-04-16 08:38:44.850372	2024-05-02 10:05:25.107311
42	Pediatric	2	unavailable	2024-04-16 08:38:44.907161	2024-05-03 07:47:09.517478
12	IICU	2	unavailable	2024-04-16 08:38:44.825375	2024-05-02 13:55:03.940283
14	IICU	4	unavailable	2024-04-16 08:38:44.831211	2024-05-03 06:38:49.452256
33	Surgical	3	vaccant	2024-04-16 08:38:44.883493	2024-05-03 06:47:40.68519
22	Emergency	2	unavailable	2024-04-16 08:38:44.853174	2024-05-03 06:49:10.502293
51	Maternity	1	unavailable	2024-04-16 08:38:44.931714	2024-05-03 06:57:25.702059
41	Pediatric	1	unavailable	2024-04-16 08:38:44.904508	2024-05-03 08:02:00.865518
43	Pediatric	3	unavailable	2024-04-16 08:38:44.909938	2024-05-03 08:06:52.109945
44	Pediatric	4	unavailable	2024-04-16 08:38:44.912459	2024-05-03 08:08:45.591018
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.departments (id, name, address, created_at, updated_at) FROM stdin;
2	Pediatrics	4320 Walker Valleys, East Vellachester, VT 62800-9394	2024-04-16 08:31:27.970273	2024-04-16 08:31:27.970273
3	Oncology	474 Dennise Plaza, North Lianamouth, MI 23731	2024-04-16 08:31:27.973176	2024-04-16 08:31:27.973176
4	Orthopedics	14879 Turner Courts, Lake Teodora, TX 84234	2024-04-16 08:31:27.97583	2024-04-16 08:31:27.97583
5	Neurology	Suite 425 1172 Celia Point, Lebsackchester, MO 71349	2024-04-16 08:31:27.978339	2024-04-16 08:31:27.978339
6	Gynecology	912 Christen Knoll, North Felix, AZ 38114-2264	2024-04-16 08:31:27.980868	2024-04-16 08:31:27.980868
7	Emergency Medicine	7562 Wyman Greens, Isiahshire, WA 84797-1838	2024-04-16 08:31:27.983248	2024-04-16 08:31:27.983248
8	Psychiatry	1246 Lady Drive, North Lillia, IL 20075	2024-04-16 08:31:27.985642	2024-04-16 08:31:27.985642
9	Radiology	Suite 921 9536 Mauricio Crest, Schadenmouth, PA 58804-3295	2024-04-16 08:31:27.988056	2024-04-16 08:31:27.988056
10	General Surgery	994 Katheryn Square, North Rodrigo, MI 61962-2853	2024-04-16 08:31:27.990653	2024-04-16 08:31:27.990653
22	Neuro Surgery	11021 Ivelisse Streets, Weimannside, WA 77213-3222	2024-04-30 07:35:55.801551	2024-04-30 07:35:55.801551
1	Cardiology	11021 Ivelisse Streets, Weimannside, WA 77213-3444	2024-04-16 08:31:27.960399	2024-05-02 13:46:11.640652
23	Opthalmology	Pune	2024-05-02 13:47:38.013692	2024-05-02 13:47:38.013692
\.


--
-- Data for Name: doctor_details; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.doctor_details (id, regno, department_id, start_time, end_time, required_time_slot, qualification, user_id, created_at, updated_at) FROM stdin;
13	372378	7	04:30:00	09:30:00	10	MS	45	2024-04-29 13:06:29.067168	2024-05-08 06:38:48.856129
2	p1jh9n77	8	08:00:00	18:00:00	15	MS	31	2024-04-16 08:38:43.063536	2024-04-17 11:21:53.946255
4	hesejhvf	4	08:00:00	18:00:00	15	MS	33	2024-04-16 08:38:43.507425	2024-04-17 11:21:53.953808
6	5zv5cy2l	6	08:00:00	18:00:00	15	MS	35	2024-04-16 08:38:43.939331	2024-04-17 11:21:53.964017
7	svxzbsyl	8	08:00:00	18:00:00	15	MS	36	2024-04-16 08:38:44.151794	2024-04-17 11:21:53.96769
8	lq0twesd	8	08:00:00	18:00:00	15	MS	37	2024-04-16 08:38:44.364268	2024-04-17 11:21:53.971438
9	d7o3jzfd	7	08:00:00	18:00:00	15	MS	38	2024-04-16 08:38:44.575892	2024-04-17 11:21:53.975139
1	o5um59ty	5	08:00:00	18:00:00	15	MS	30	2024-04-16 08:38:42.844238	2024-04-17 11:21:53.981674
3	w56qqql3	8	08:00:00	18:00:00	15	MS	32	2024-04-16 08:38:43.288841	2024-04-17 11:21:53.984759
10	r6z03xzn	8	10:00:00	22:00:00	15	MS	39	2024-04-16 08:38:44.787656	2024-04-18 13:00:51.439905
12	123PQR	3	04:30:00	16:30:00	30	MD	42	2024-04-19 08:11:24.470492	2024-04-19 14:22:27.316201
14	987678	23	13:30:00	17:30:00	30	MD MS	47	2024-05-02 13:54:32.511547	2024-05-02 13:54:32.511547
5	nd85boi3	4	07:30:00	10:30:00	15	MS	34	2024-04-16 08:38:43.726709	2024-05-04 07:06:47.725366
\.


--
-- Data for Name: ipds; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.ipds (id, patient_id, department_id, treatment_description, admission_datetime, discharge_datetime, bed_id, status, created_at, updated_at) FROM stdin;
22	4	22	\N	2024-05-08 05:05:00	\N	25	admitted	2024-05-09 05:05:41.995442	2024-05-09 05:05:41.995442
23	3	22	\N	2024-05-07 05:06:00	\N	32	admitted	2024-05-09 05:06:21.95756	2024-05-09 05:06:21.95756
24	13	22	\N	2024-05-08 05:08:00	\N	34	admitted	2024-05-09 05:08:10.083426	2024-05-09 05:08:10.083426
20	8	3	\N	2024-04-30 03:50:00	2024-05-09 09:43:36.960665	13	discharged	2024-04-30 11:48:21.916608	2024-05-09 09:43:36.961116
21	12	5	Discharge Instructions:\r\n- Please continue taking all prescribed medications as directed by your physician\r\n- Follow up with your primary care physician within 1 week of discharge\r\n- Rest and avoid strenuous activities for the next 2 weeks\r\n- If you experience any concerning symptoms, please contact your physician immediately	2024-05-07 13:49:00	2024-05-09 09:52:39.722438	18	discharged	2024-05-08 13:49:15.020557	2024-05-09 09:52:39.723071
1	1	5	test treatment	2024-04-13 07:24:24	2024-04-16 23:31:31	49	discharged	2024-04-16 08:38:45.044497	2024-04-17 08:15:49.8968
4	4	10	test treatment	2024-03-26 20:56:47	2024-04-16 18:31:15	39	discharged	2024-04-16 08:38:45.120116	2024-04-17 08:15:49.908606
5	5	5	test treatment	2024-04-03 06:40:02	\N	54	admitted	2024-04-16 08:38:45.143449	2024-04-17 08:15:49.909624
6	6	9	test treatment	2024-04-04 20:59:34	2024-04-16 21:20:12	17	discharged	2024-04-16 08:38:45.166428	2024-04-17 08:15:49.910514
9	9	2	test treatment	2024-03-29 04:06:42	2024-04-17 17:51:25	44	discharged	2024-04-16 08:38:45.234676	2024-04-17 08:15:49.913031
10	10	8	test treatment	2024-04-07 15:56:47	\N	11	admitted	2024-04-16 08:38:45.258475	2024-04-17 08:15:49.913862
16	1	1	test desc	2024-04-18 14:53:31.060999	2024-04-18 14:54:34.293584	10	discharged	2024-04-18 14:53:31.078703	2024-04-18 14:54:34.293871
17	1	1	test desc	2024-04-19 06:09:16.569676	2024-04-19 06:17:32.904601	10	discharged	2024-04-19 06:09:16.584338	2024-04-19 06:17:32.905032
18	1	1	Test treatment_description1	2024-04-19 08:07:42.882875	\N	10	admitted	2024-04-19 08:08:12.757931	2024-04-19 08:08:12.757931
3	3	4	test desc	2024-04-01 12:34:15	2024-04-19 11:34:23.245643	14	discharged	2024-04-16 08:38:45.096637	2024-04-19 11:34:23.246168
2	2	10	test desc	2024-03-28 22:34:33	2024-04-25 12:42:36.740234	60	discharged	2024-04-16 08:38:45.072464	2024-04-25 12:42:36.740784
8	8	3	test desc	2024-03-25 15:48:46	2024-04-25 12:44:09.110136	8	discharged	2024-04-16 08:38:45.211637	2024-04-25 12:44:09.110498
19	12	1	\N	2024-04-19 11:36:22.6067	2024-04-30 13:54:02.490697	12	discharged	2024-04-19 11:36:22.618776	2024-04-30 13:54:02.491275
7	7	5	Elevated liver enzymes and creatinine. Both of these were thought to be related to end organ hypoperfusion\r\nin the setting of sepsis. Values improved with the administration of IV fluid and stabilization of the patients\r\nhemodynamics. Abdominal ultrasound with doppler flow and urine analysis ruled out other possible\r\netiologies. Liver enzymes remain slightly above normal values at the time of dischargeThe patient had elevated liver enzymes and creatinine which were believed to be caused by decreased blood flow to the organs due to sepsis. The values improved after IV fluid administration and stabilization of the patient's hemodynamics. Abdominal ultrasound with doppler flow and urine analysis were performed to rule out other possible causes. At the time of discharge, the liver enzymes were still slightly above the normal range.The patient had elevated liver enzymes and creatinine which were believed to be caused by decreased blood flow to the organs due to sepsis. The values improved after IV fluid administration and stabilization of the patient's hemodynamics. Abdominal ultrasound with doppler flow and urine analysis were performed to rule out other possible causes. At the time of discharge, the liver enzymes were still slightly above the normal range.	2024-04-03 11:49:43	2024-04-30 13:59:52.440428	46	discharged	2024-04-16 08:38:45.188696	2024-04-30 13:59:52.441118
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.patients (id, first_name, last_name, birthdate, gender, contact, created_at, updated_at, user_id) FROM stdin;
1	Ramona	Wuckert	1979-07-28	Female	8438310871	2024-04-16 08:38:44.992646	2024-04-16 08:38:44.992646	6
2	Kanesha	Monahan	1979-02-11	Other	4019668553	2024-04-16 08:38:44.998513	2024-04-16 08:38:44.998513	6
3	Harrison	Baumbach	1973-04-10	Other	8376776268	2024-04-16 08:38:45.002302	2024-04-16 08:38:45.002302	6
4	Cameron	Gerlach	1959-06-29	Male	6188258958	2024-04-16 08:38:45.006023	2024-04-16 08:38:45.006023	10
5	Cordell	Donnelly	1978-07-22	Male	7338737030	2024-04-16 08:38:45.009798	2024-04-16 08:38:45.009798	9
6	Angila	Marquardt	1946-02-28	Female	7621191098	2024-04-16 08:38:45.013415	2024-04-16 08:38:45.013415	2
7	Douglas	Prohaska	1942-09-02	Male	3865041120	2024-04-16 08:38:45.016776	2024-04-16 08:38:45.016776	5
8	Jefferson	Mante	1959-11-09	Male	9880975305	2024-04-16 08:38:45.019958	2024-04-16 08:38:45.019958	2
9	Edwardo	Mann	1957-10-02	Male	3398349894	2024-04-16 08:38:45.023095	2024-04-16 08:38:45.023095	3
10	Nella	Jacobi	1984-09-15	Other	2751560117	2024-04-16 08:38:45.02661	2024-04-16 08:38:45.02661	1
11	Swpanil	Deshmukh	2001-03-26	Male	8208160146	2024-04-18 13:05:19.998263	2024-04-18 13:05:19.998263	40
12	Sahil	Deshmukh	2001-03-07	Male	9999988888	2024-04-19 11:10:18.532747	2024-04-19 11:10:18.532747	1
13	Danny	Borse	2000-09-23	Male	7655623345	2024-04-19 12:05:42.115832	2024-04-19 12:05:42.115832	3
14	Devansh	Patil	2024-04-09	Male	6786787867	2024-04-30 07:52:34.805452	2024-04-30 07:52:34.805452	44
15	Revansh	Rane	2024-04-11	Male	6786787867	2024-04-30 08:09:02.484011	2024-05-03 09:59:31.546286	46
16	Raaj	Chimulkar	1998-03-10	Male	5678876556	2024-05-03 12:15:23.60123	2024-05-03 12:15:23.60123	46
17	Devansh	Patil	2023-04-12	Male	6756475634	2024-05-09 05:30:54.093483	2024-05-09 05:30:54.093483	46
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.schema_migrations (version) FROM stdin;
20240411101302
20240411101348
20240411101410
20240411103500
20240411103513
20240413101053
20240415110710
20240415131134
20240416083005
20240416083109
20240419073352
20240427060903
\.


--
-- Data for Name: treatments; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.treatments (id, ipd_id, description, datetime, created_at, updated_at) FROM stdin;
1	1	Omnis illo sed. Quo dolorem nihil.	2024-04-15 19:12:00.060946	2024-04-16 08:38:45.055562	2024-04-18 12:20:51.437795
2	1	Aut doloribus sunt. Recusandae delectus assumenda.	2024-04-15 15:45:00.800691	2024-04-16 08:38:45.059333	2024-04-18 12:20:51.447477
3	1	Illum quas culpa. Qui perferendis molestiae.	2024-04-16 23:06:30.76675	2024-04-16 08:38:45.062597	2024-04-18 12:20:51.451124
4	1	Nihil officiis quos. Voluptatum ut voluptas.	2024-04-14 04:46:57.049178	2024-04-16 08:38:45.066265	2024-04-18 12:20:51.453514
5	2	Odio quibusdam necessitatibus. Aut sint iure.	2024-04-04 12:16:35.702448	2024-04-16 08:38:45.07648	2024-04-18 12:20:51.456101
6	2	Illo ullam et. Iusto porro atque.	2024-04-08 07:05:57.680801	2024-04-16 08:38:45.082627	2024-04-18 12:20:51.458362
7	2	Est excepturi et. Fugit numquam repudiandae.	2024-04-12 18:46:23.681735	2024-04-16 08:38:45.086607	2024-04-18 12:20:51.460471
8	2	Quisquam aut aut. Odit facere iure.	2024-04-16 02:15:53.433708	2024-04-16 08:38:45.090527	2024-04-18 12:20:51.463211
9	3	A aut accusamus. Ipsa aut sed.	2024-04-03 12:50:14.22445	2024-04-16 08:38:45.100363	2024-04-18 12:20:51.465265
10	3	Iusto voluptate enim. Itaque error rerum.	2024-04-09 03:05:36.588065	2024-04-16 08:38:45.104087	2024-04-18 12:20:51.46719
11	3	Praesentium accusantium culpa. Facere et voluptatem.	2024-04-11 21:06:55.861839	2024-04-16 08:38:45.108204	2024-04-18 12:20:51.468839
12	3	Eius velit molestiae. Sed quisquam qui.	2024-04-14 15:45:53.942402	2024-04-16 08:38:45.11232	2024-04-18 12:20:51.470398
13	4	Maiores accusamus ut. Provident exercitationem totam.	2024-04-10 09:03:33.443939	2024-04-16 08:38:45.124301	2024-04-18 12:20:51.472101
14	4	Velit voluptate eum. Molestias nihil voluptas.	2024-03-28 21:22:11.112039	2024-04-16 08:38:45.128838	2024-04-18 12:20:51.474263
15	4	Eligendi perferendis aut. Commodi doloribus libero.	2024-04-03 03:50:41.948475	2024-04-16 08:38:45.133388	2024-04-18 12:20:51.476409
16	4	Nostrum debitis repellat. Nam rerum et.	2024-03-27 02:08:44.110271	2024-04-16 08:38:45.137504	2024-04-18 12:20:51.477959
17	5	Dolor incidunt voluptate. Eveniet ut repudiandae.	2024-04-06 02:53:23.712607	2024-04-16 08:38:45.147378	2024-04-18 12:20:51.479767
18	5	Quis asperiores et. Magnam dolor id.	2024-04-07 21:20:28.985202	2024-04-16 08:38:45.1511	2024-04-18 12:20:51.481315
19	5	Eos dignissimos nemo. Dolore molestiae maiores.	2024-04-09 02:52:56.601007	2024-04-16 08:38:45.155307	2024-04-18 12:20:51.482644
21	6	Ut quidem libero. Ad soluta aut.	2024-04-13 03:32:29.171343	2024-04-16 08:38:45.170676	2024-04-18 12:20:51.485257
22	6	Unde et et. Fuga dignissimos praesentium.	2024-04-07 20:48:41.420272	2024-04-16 08:38:45.174442	2024-04-18 12:20:51.487109
23	6	Explicabo porro officiis. Dolorem blanditiis expedita.	2024-04-05 16:36:33.97358	2024-04-16 08:38:45.178299	2024-04-18 12:20:51.489049
24	6	Quam beatae voluptas. Maxime veritatis sed.	2024-04-10 02:13:23.819736	2024-04-16 08:38:45.182323	2024-04-18 12:20:51.490617
25	7	Deserunt esse ipsa. Quia eum suscipit.	2024-04-10 15:45:34.240192	2024-04-16 08:38:45.192857	2024-04-18 12:20:51.492069
26	7	Minus consequatur quas. At explicabo exercitationem.	2024-04-07 11:37:02.638337	2024-04-16 08:38:45.197469	2024-04-18 12:20:51.494278
27	7	Blanditiis perspiciatis ut. Distinctio soluta omnis.	2024-04-09 15:41:53.912839	2024-04-16 08:38:45.201426	2024-04-18 12:20:51.496267
28	7	Non voluptatem suscipit. Doloribus dignissimos quaerat.	2024-04-15 00:40:39.568383	2024-04-16 08:38:45.205374	2024-04-18 12:20:51.498305
29	8	Qui tempore et. Reiciendis aut adipisci.	2024-04-09 03:46:36.784724	2024-04-16 08:38:45.21559	2024-04-18 12:20:51.500131
30	8	Distinctio quia est. Ipsa similique repudiandae.	2024-04-06 00:11:12.926469	2024-04-16 08:38:45.219621	2024-04-18 12:20:51.501891
31	8	Et corporis sequi. Facere minima vero.	2024-03-30 19:25:07.571868	2024-04-16 08:38:45.223611	2024-04-18 12:20:51.503597
32	8	Culpa deserunt voluptatem. Non nesciunt laudantium.	2024-04-12 02:26:01.115716	2024-04-16 08:38:45.227833	2024-04-18 12:20:51.505305
33	9	Nemo architecto sit. Rerum nulla eos.	2024-04-09 16:53:35.570592	2024-04-16 08:38:45.238873	2024-04-18 12:20:51.507496
34	9	Architecto nemo magni. Est illo dolorum.	2024-04-07 05:04:39.66076	2024-04-16 08:38:45.243075	2024-04-18 12:20:51.509249
35	9	Consequatur impedit quaerat. In quis non.	2024-04-05 12:30:50.575229	2024-04-16 08:38:45.247171	2024-04-18 12:20:51.511094
36	9	Voluptates non cum. Sequi itaque ducimus.	2024-04-12 03:36:10.207537	2024-04-16 08:38:45.25157	2024-04-18 12:20:51.513366
41	8	Ex excepturi est. Magni iste debitis.	2024-04-15 00:00:00	2024-04-18 10:53:26.1552	2024-04-18 12:20:51.522207
42	8	Ex corporis est. Qui pariatur ut.	2024-04-15 00:00:00	2024-04-18 10:54:22.516979	2024-04-18 12:20:51.523781
43	16	xyz injection	2024-04-15 00:00:00	2024-04-18 14:57:41.324859	2024-04-18 14:57:41.324859
44	19	Painkiller injection	2024-04-18 18:30:00	2024-04-19 14:46:41.775515	2024-04-19 14:46:41.775515
45	19	TT injection	2024-04-19 14:30:00	2024-04-19 14:47:21.553688	2024-04-19 14:47:21.553688
46	19	TT injection	2024-04-19 14:30:00	2024-04-20 05:36:23.4122	2024-04-20 05:36:23.4122
51	20	TT Injection3	2024-05-01 07:07:00	2024-05-01 07:07:50.668461	2024-05-01 07:07:50.668461
52	20	TT Injection4	2024-05-02 07:09:00	2024-05-01 07:10:05.603091	2024-05-01 07:10:05.603091
53	10	TT Injection	2024-05-01 07:46:00	2024-05-01 07:46:40.769425	2024-05-01 07:46:40.769425
54	10	TT Injection	2024-05-01 07:47:00	2024-05-01 07:47:58.162237	2024-05-01 07:47:58.162237
57	10	TT Injection	2024-05-01 07:57:00	2024-05-01 08:12:04.757844	2024-05-01 08:12:04.757844
58	10	TT Injection	2024-05-01 07:57:00	2024-05-01 08:12:08.707563	2024-05-01 08:12:08.707563
59	10	TT Injection	2024-05-01 07:57:00	2024-05-01 08:12:09.021951	2024-05-01 08:12:09.021951
60	10	TT Injection	2024-05-01 07:57:00	2024-05-01 08:12:42.317821	2024-05-01 08:12:42.317821
62	10	TT Injection	2024-05-01 08:23:00	2024-05-01 08:24:03.073272	2024-05-01 08:24:03.073272
63	10	TT Injection	2024-05-01 08:24:00	2024-05-01 08:26:58.511548	2024-05-01 08:26:58.511548
65	10	Paracetamol Injection 150 Mg	2024-05-06 10:19:00	2024-05-06 10:19:13.515433	2024-05-06 10:19:13.515433
66	10	Paracetamol Injection 150 Mg	2024-05-06 10:23:00	2024-05-06 10:23:35.085063	2024-05-06 10:23:35.085063
67	20	Paracetamol Injection 250 Mg	2024-05-06 10:34:24	2024-05-06 10:34:31.145831	2024-05-06 10:34:31.145831
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.users (id, first_name, last_name, email, contact, password, role, created_at, updated_at, password_digest, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at) FROM stdin;
1	Renaldo	Cruickshank	ethan_mertz@jacobs-ritchie.example	4322226720	\N	user	2024-04-16 08:31:28.208756	2024-04-16 08:31:28.208756	$2a$12$xzV141ydr3bxEJFL/6Scg.1f89M4j8CzwwhwS1FPnFExCo5zkLpdO		\N	\N	\N
2	Bree	Haley	lesia@osinski.example	8582721646	\N	user	2024-04-16 08:31:28.42063	2024-04-16 08:31:28.42063	$2a$12$ZhYN6R/m5V1AMygoxqLuhuL74.HDheRzFcJz8SkRNKoaYxvVQ26IW		\N	\N	\N
3	Allison	Ryan	mee_carroll@satterfield-marquardt.test	3846142548	\N	user	2024-04-16 08:31:28.639743	2024-04-16 08:31:28.639743	$2a$12$iFprS1ZshVN7dIvivZ.xPevl1DNgBa.ymaqbSRfnthdqM7nphsU6.		\N	\N	\N
4	Terrance	Boyle	audry.waters@feil.test	9414622070	\N	user	2024-04-16 08:31:28.851887	2024-04-16 08:31:28.851887	$2a$12$3ccYoW9OYN.Azye3wFvDiusdwhMDmMMAGLwQuCPTyiYWhfLfB7noW		\N	\N	\N
5	Belle	Jast	carrol@trantow.example	6744153485	\N	user	2024-04-16 08:31:29.064685	2024-04-16 08:31:29.064685	$2a$12$.4.TQRKbinqJXojyKpwCH.fdrElz3J5GK0NihUjl2kX.FGPFGHvEO		\N	\N	\N
6	Emile	Barton	kayleigh.ledner@rice.test	5188800653	\N	user	2024-04-16 08:31:29.277286	2024-04-16 08:31:29.277286	$2a$12$V67onIV6C.iVI2BRCcj7l.u70ch5VGtrFyph4Ernq5Z7PwyVHmnTm		\N	\N	\N
7	Rita	Walker	hyon@monahan.example	6466393142	\N	user	2024-04-16 08:31:29.490165	2024-04-16 08:31:29.490165	$2a$12$1sk4b92cy1mQFiKDqoiqHuSvIXpzC/8REoHQh1lOciCkCcJ6rvfEm		\N	\N	\N
8	Jeffry	Farrell	hugo@jakubowski-hessel.example	2632823265	\N	user	2024-04-16 08:31:29.702117	2024-04-16 08:31:29.702117	$2a$12$2v4WDXP1.VcVOsiJlk9iX.vgMCZqyOdV95STQUuDM4Lk4iZKFa9Vq		\N	\N	\N
9	Cheryl	Ferry	araceli.cassin@johns.example	3758459496	\N	user	2024-04-16 08:31:29.907855	2024-04-16 08:31:29.907855	$2a$12$SYQD1hc91gTKYToN0cmJd.oXIFiihzJ8Zuvtyuy23WA5LqiH4du3q		\N	\N	\N
10	Roman	Herman	yong_swaniawski@bergnaum.example	8344577951	\N	user	2024-04-16 08:31:30.114213	2024-04-16 08:31:30.114213	$2a$12$KiPaGDH4zCK5fq3lvO5XSOfEsSefwRmjBtsFG1ueJmA32JMyV.ZNm		\N	\N	\N
11	Rene	Haag	harlan@larson-mitchell.example	7698246333	\N	doctor	2024-04-16 08:31:30.32028	2024-04-16 08:31:30.32028	$2a$12$iikcj9Un8vZRhcWjUMzPbuXS9FJJ7786r6qtY86oChAidRgFraUHS		\N	\N	\N
12	Ed	Nikolaus	maynard@roob.test	8884174584	\N	user	2024-04-16 08:32:45.269019	2024-04-16 08:32:45.269019	$2a$12$vljyyrqeucEE2hYtwT.hROwamCz8RDUHhbTweWrq1Fl89N/QLWefy		\N	\N	\N
13	Hershel	Schiller	adam@weissnat.test	7806167013	\N	user	2024-04-16 08:32:45.474918	2024-04-16 08:32:45.474918	$2a$12$kDkR1FETDN/979n4f87XdOj4NVoc.Xfvql5MfE6v7EjQRRy13EmDW		\N	\N	\N
14	Gertrude	Osinski	florencio.wiegand@carroll.test	5617486959	\N	user	2024-04-16 08:32:45.693792	2024-04-16 08:32:45.693792	$2a$12$j9Dbsl06Ee99QoLp4rYBIe/5Q/8kNLVxNm0LnYf6XY1UD6pSJhlKC		\N	\N	\N
15	Yolande	Hudson	eleni_stracke@grady-medhurst.test	5012201462	\N	user	2024-04-16 08:32:45.906236	2024-04-16 08:32:45.906236	$2a$12$TER./RMNH5ANaWrOeJM9vOv9c3DOvnAVsal.ueIQ3vyKjkUYSDtt6		\N	\N	\N
16	Nettie	Marquardt	christoper.bernhard@huels.test	7495240044	\N	user	2024-04-16 08:32:46.118824	2024-04-16 08:32:46.118824	$2a$12$DSu0ZNY0ORrv0e8Q/fAYZe9MQjpeJUlEchVnBI9XTLQbcOLJgIiuW		\N	\N	\N
17	Albert	King	leatrice@boyle.test	9920791844	\N	user	2024-04-16 08:32:46.33271	2024-04-16 08:32:46.33271	$2a$12$DLP2y5bMLqjbkxDzTNc9VugkUAcNf1yqM7Uz9/UE8dP.pgH2K4Goe		\N	\N	\N
18	Leonore	Shanahan	neva_macejkovic@metz.test	7062474138	\N	user	2024-04-16 08:35:01.881952	2024-04-16 08:35:01.881952	$2a$12$CEgFdLsDN/.R6CWiYWA4L.ldma/M21.VxcNBiZQiCw8k75UQwcAn6		\N	\N	\N
19	Ouida	Franecki	fermin_kohler@blanda-feil.example	1599759490	\N	user	2024-04-16 08:35:02.094078	2024-04-16 08:35:02.094078	$2a$12$ryxixyeC7tgTE9teMTudP.rgU61glDDjYn7J33XdyM9Ci1irOLAxu		\N	\N	\N
20	Kesha	Prohaska	lupe.yundt@brekke.example	9412730267	\N	user	2024-04-16 08:35:02.306663	2024-04-16 08:35:02.306663	$2a$12$.owJdaZGWp8SGyltsfG45Oo/PpXF9.85ZDjXlUwmhfukOzAaY8uIq		\N	\N	\N
21	Josue	Boyle	kristin@bahringer.test	6540780320	\N	user	2024-04-16 08:35:02.518986	2024-04-16 08:35:02.518986	$2a$12$.Mo6PQvjplA5LuyMGaBHxu1dtADenWZ6AUlv4visI4wVTg8lXbaku		\N	\N	\N
22	Willard	Denesik	lewis@cummings.test	6749598090	\N	user	2024-04-16 08:35:02.732042	2024-04-16 08:35:02.732042	$2a$12$wPHZaiFDM5bNpuCRaZxu8exBp1k2h7Wf5V73lXT5tVw1udoTHWCkC		\N	\N	\N
23	Elliot	Kovacek	setsuko@stroman.test	6672201428	\N	user	2024-04-16 08:35:02.944548	2024-04-16 08:35:02.944548	$2a$12$BMNkyj1Loen98npE7s0hPe7afCin4/T1gulZE.VNMcw1zkPbGbxSe		\N	\N	\N
24	Jolie	Torphy	laureen@brekke.example	3109472579	\N	user	2024-04-16 08:35:03.150391	2024-04-16 08:35:03.150391	$2a$12$iwCmRp3Vq6Ae2EzlUVM94.L3mrTpzSwEa/mnPDgpd8sntu6BR6pX6		\N	\N	\N
25	Brittny	Mcglynn	jess@friesen.example	5990506752	\N	user	2024-04-16 08:35:03.36274	2024-04-16 08:35:03.36274	$2a$12$xCWBYXhq4OgEmelILZVfMOxCqt6arhljjFyu0D3h9sNo/bF.9wbDW		\N	\N	\N
26	Darius	Rutherford	wes.hessel@gislason.test	4971765475	\N	user	2024-04-16 08:35:03.575271	2024-04-16 08:35:03.575271	$2a$12$esBCZP3joy89SHN0YRslCO9cRzOF.Zzokh9Tez31atSwOoJtix2UW		\N	\N	\N
27	Kellie	Fritsch	horacio.dickens@bernhard.example	2629927855	\N	user	2024-04-16 08:35:03.781314	2024-04-16 08:35:03.781314	$2a$12$xacsTeKW4Evggrh9Z2fPT.6DqzsMusLLWVwntWJvIYqxFKfUkqdti		\N	\N	\N
30	Orval	Prohaska	junior@mayer.example	6807436755	\N	doctor	2024-04-16 08:38:42.814356	2024-04-16 08:38:42.814356	$2a$12$8TvqAzaguEXETWnxRWOrY.9qtjDdozrQpqnwyBwKxmK2xuX259ehW		\N	\N	\N
31	Norberto	Hills	ileen_legros@bauch.test	9888414928	\N	doctor	2024-04-16 08:38:43.050129	2024-04-16 08:38:43.050129	$2a$12$.dgtkFyr12GjUvA7SVQUIeNPz92luF5xhi/.yva4vxvsWaNraXr22		\N	\N	\N
32	Louann	Bauch	elmo_lind@rohan-brekke.example	1766245919	\N	doctor	2024-04-16 08:38:43.268268	2024-04-16 08:38:43.268268	$2a$12$xk9A/7A7Ef27b1pJ6S4wceHCrmArf5SIyPJnoRxNWMY8qPME0jGWu		\N	\N	\N
33	Ezequiel	Collier	yuriko@leannon.example	1108283997	\N	doctor	2024-04-16 08:38:43.494251	2024-04-16 08:38:43.494251	$2a$12$h8BdMu2wGJDx3N/TOdRh3OFIhBeRMNu6dJYgmWGFIhiqCt6atAPt6		\N	\N	\N
34	Deangelo	Stiedemann	sharri@langosh.test	9263371261	\N	doctor	2024-04-16 08:38:43.713283	2024-04-16 08:38:43.713283	$2a$12$qSIWKlB71qt6ETStYZJuvuOmYz6NiCxogIqYVzdFQ5HxRDw4BLGiO		\N	\N	\N
35	Eustolia	Gutkowski	jospeh.douglas@brekke-weimann.example	7705748836	\N	doctor	2024-04-16 08:38:43.932027	2024-04-16 08:38:43.932027	$2a$12$h4Q0MBysuMm03RvSlFclz.o03Ne9pm4BuMGFhpO8C66Q8q9a3Cepu		\N	\N	\N
36	Zona	Schimmel	connie@kessler.example	6645893682	\N	doctor	2024-04-16 08:38:44.144664	2024-04-16 08:38:44.144664	$2a$12$JTqPQIUl7Dp.XOqFZnN56O2eeNHMBHklnpy/B5.AZT3O5T6VlPTym		\N	\N	\N
37	Khalilah	Runolfsson	florencia@jakubowski.example	8769405576	\N	doctor	2024-04-16 08:38:44.357481	2024-04-16 08:38:44.357481	$2a$12$7szaWO4qPNJVIEYuplRSjOMSqHQ.F6Hg/wXrfulO45jvqJK9bfP3C		\N	\N	\N
38	Brittni	Sanford	rebbeca@bergstrom.test	8511097611	\N	doctor	2024-04-16 08:38:44.569249	2024-04-16 08:38:44.569249	$2a$12$WJXwnHGxtPqQHb9k8oeYiOWdoqvhUaSwdz1xcpBDcNUEyTnHhWOjq		\N	\N	\N
39	Phillip	Gibson	gerald@langworth.example	2596290860	\N	doctor	2024-04-16 08:38:44.780712	2024-04-16 08:38:44.780712	$2a$12$0I1IjISTsyaBraYGnZlhkevtqM3nwfMdF5dci7OSHE1vHU0uBVFcy		\N	\N	\N
40	Sahil	Bhirud	sahil@gmail.com	8600386608	\N	user	2024-04-18 12:22:19.781189	2024-04-18 12:22:19.781189	$2a$12$MBxvVZWhqgrDoKYqSm5efOFM2ORwSycFMzfjtMK556H9/6LhKWswa		\N	\N	\N
42	Krishna	Gite	krishna@gmail.com	3456543451	\N	doctor	2024-04-19 08:11:24.454375	2024-04-19 08:11:24.454375	$2a$12$OY.6aTZi31Qe903FlUnEDuTvrZDlD4zHhOjvAcZeTCppfkHR6Kn4O		\N	\N	\N
41	Sahil	Gibson	sahil1@gmail.com	8600345608	\N	user	2024-04-19 05:56:10.113852	2024-04-25 09:38:32.076716	$2a$12$HsAL7SkhlUmKF/IpVteN0ey9dLCWda4hzBAf/kvh1t5b94L9M6Yni		\N	\N	\N
43	Chaitanya	Bhavar	chaitanya@gmail.com	9579213171	\N	user	2024-04-27 07:44:11.655466	2024-04-27 10:40:28.961459	$2a$12$45/woNQzMaWLfWufwDcFdetP4hkvCzb14q.X09TWtJkCmFt7rGib6	$2a$12$WwaByFmA8.YREfqq4MhZz.MNsEse0YN1IWEJKPGh7v1bAx2lrZKgi	40d7c97c40924752019b512d39f90c3520b8408802c4ff7cfa0e9d99eb8abb7e	2024-04-27 10:40:28.961137	\N
45	Chetan	Borse	chetan@gmail.com	9878767896	\N	doctor	2024-04-29 13:06:29.056187	2024-04-29 13:06:29.056187	$2a$12$71qyoyfpoUTS1vHyxtqdTeidLse2XvVjjZPdZ7Vv8ct1yA6261fNu	$2a$12$MsVKRcBsXDNR30GLXyJP2u3bOlGRtoHUq8fC//nsYgzCqzXKjG0r.	\N	\N	\N
46	Akash	Vispute	akash@gmail.com	8097007001	\N	user	2024-04-29 13:13:36.391356	2024-04-29 13:13:36.391356	$2a$12$b8wVGLUH0iS4I5rMs.A9AOWG6Tt5aI13USILJOSuoJvqGbJqxe2WO	$2a$12$sR8dvNXCeRl/VZ3FoQVJEO7iBCiDrHADxGy5W0VT0L8nzUvZkyHN2	\N	\N	\N
47	Hrishikesh	Patil	hrishikesh@gmail.com	9878976786	\N	doctor	2024-05-02 13:54:32.50164	2024-05-02 13:54:32.50164	$2a$12$8/A9kS5qmZv2VRYYSEUKuuAZ6ZXndsqLaOalDgM32OjYP7TM.fKVu	$2a$12$uvnry7B.rVfDMPmykDbkiufe9xF3TUUhUEdn4QBHf1RmqrGFHZYmG	\N	\N	\N
48	Prem	Bhangadiya	prem@gmail.com	6576574563	\N	user	2024-05-09 07:21:26.855338	2024-05-09 07:21:26.855338	$2a$12$MRh7qc0Y4S4izlZMyW8ddePjc5s4okEZpRgIyfbyX9GSIYMKT5rsq	$2a$12$Jn5pvGj/rkDDV6zQsOpo8.VNk6Y4vT5qHNE55EIbPPMV.VyKYy71i	\N	\N	\N
44	Kalpesh	Gatkal	kalpesh@gmail.com	7678656756	\N	admin	2024-04-27 11:10:56.338368	2024-05-09 11:46:16.39921	$2a$12$c/FBPvuIB9Nj4ajZ/t/.vuaziod1qYx8KoJ9dJ9/YL7ZprU58yH0.	$2a$12$9iY8vRjqM8OrdlT3ZfpvDOtLk5ZmuB5foEoQU2ZMIsl9Gl8LXfaXm	\N	\N	2024-05-09 11:46:16.398947
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: ue
--

COPY public.versions (id, item_type, item_id, event, whodunnit, object, created_at) FROM stdin;
1	Ipd	18	create	\N	\N	2024-04-19 08:08:12.757931
2	Bed	70	update	\N	---\nid: 70\nward_type: Psychiatric\nbed_no: '10'\nstatus: vaccant\ncreated_at: 2024-04-16 08:38:44.980570000 Z\nupdated_at: 2024-04-16 08:38:44.980570000 Z\n	2024-04-19 10:47:13.420739
3	Bed	70	update	\N	---\nid: 70\nward_type: Psychiatric\nbed_no: '10'\nstatus: acquired\ncreated_at: 2024-04-16 08:38:44.980570000 Z\nupdated_at: 2024-04-19 10:47:13.420739000 Z\n	2024-04-19 10:50:45.639914
4	Ipd	3	update	\N	---\ndischarge_datetime: \ntreatment_description: test treatment\nstatus: admitted\npatient_id: 3\ndepartment_id: 4\nbed_id: 14\nid: 3\nadmission_datetime: 2024-04-01 12:34:15.000000000 Z\ncreated_at: 2024-04-16 08:38:45.096637000 Z\nupdated_at: 2024-04-17 08:15:49.907175000 Z\n	2024-04-19 11:34:23.246168
5	Bed	14	update	\N	---\nstatus: acquired\nid: 14\nward_type: IICU\nbed_no: '4'\ncreated_at: 2024-04-16 08:38:44.831211000 Z\nupdated_at: 2024-04-16 08:38:44.831211000 Z\n	2024-04-19 11:34:23.287808
6	Ipd	19	create	\N	\N	2024-04-19 11:36:22.618776
7	Bed	12	update	\N	---\nstatus: vaccant\nid: 12\nward_type: IICU\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.825375000 Z\nupdated_at: 2024-04-16 08:38:44.825375000 Z\n	2024-04-19 11:36:22.631926
8	Ipd	12	destroy	\N	---\nid: 12\npatient_id: 11\ndepartment_id: 1\ntreatment_description: Test treatment_description1\nadmission_datetime: \ndischarge_datetime: \nbed_id: 6\nstatus: admitted\ncreated_at: 2024-04-18 14:15:16.411668000 Z\nupdated_at: 2024-04-18 14:15:16.411668000 Z\n	2024-04-19 12:35:16.65202
9	Ipd	15	destroy	\N	---\nid: 15\npatient_id: 1\ndepartment_id: 1\ntreatment_description: test desc\nadmission_datetime: \ndischarge_datetime: 2024-04-18 14:43:07.943772000 Z\nbed_id: 10\nstatus: discharged\ncreated_at: 2024-04-18 14:34:55.362954000 Z\nupdated_at: 2024-04-18 14:43:07.944385000 Z\n	2024-04-19 12:35:16.65987
10	Bed	10	update	\N	---\nstatus: acquired\nid: 10\nward_type: ICU\nbed_no: '10'\ncreated_at: 2024-04-16 08:38:44.820223000 Z\nupdated_at: 2024-04-19 08:08:12.775002000 Z\n	2024-04-19 12:36:10.016397
11	Bed	6	update	\N	---\nstatus: acquired\nid: 6\nward_type: ICU\nbed_no: '6'\ncreated_at: 2024-04-16 08:38:44.810059000 Z\nupdated_at: 2024-04-18 14:15:16.416373000 Z\n	2024-04-19 12:36:21.383668
12	Ipd	2	update	\N	---\ndischarge_datetime: \ntreatment_description: test treatment\nstatus: admitted\npatient_id: 2\ndepartment_id: 10\nbed_id: 60\nid: 2\nadmission_datetime: 2024-03-28 22:34:33.000000000 Z\ncreated_at: 2024-04-16 08:38:45.072464000 Z\nupdated_at: 2024-04-17 08:15:49.905828000 Z\n	2024-04-25 12:42:36.740784
13	Bed	60	update	\N	---\nstatus: acquired\nid: 60\nward_type: Maternity\nbed_no: '10'\ncreated_at: 2024-04-16 08:38:44.955397000 Z\nupdated_at: 2024-04-16 08:38:44.955397000 Z\n	2024-04-25 12:42:36.771018
14	Ipd	8	update	\N	---\ndischarge_datetime: \ntreatment_description: test treatment\nstatus: admitted\npatient_id: 8\ndepartment_id: 3\nbed_id: 8\nid: 8\nadmission_datetime: 2024-03-25 15:48:46.000000000 Z\ncreated_at: 2024-04-16 08:38:45.211637000 Z\nupdated_at: 2024-04-17 08:15:49.912200000 Z\n	2024-04-25 12:44:09.110498
15	Bed	8	update	\N	---\nstatus: acquired\nid: 8\nward_type: ICU\nbed_no: '8'\ncreated_at: 2024-04-16 08:38:44.815148000 Z\nupdated_at: 2024-04-16 08:38:44.815148000 Z\n	2024-04-25 12:44:09.125358
16	Bed	10	update	\N	---\nward_type: ICU\nbed_no: '10'\nstatus: vaccant\nid: 10\ncreated_at: 2024-04-16 08:38:44.820223000 Z\nupdated_at: 2024-04-19 12:36:10.016397000 Z\n	2024-04-30 10:09:15.941603
17	Ipd	20	create	\N	\N	2024-04-30 11:48:21.916608
18	Bed	13	update	\N	---\nstatus: vaccant\nid: 13\nward_type: IICU\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.827838000 Z\nupdated_at: 2024-04-16 08:38:44.827838000 Z\n	2024-04-30 11:48:21.95169
19	Ipd	19	update	\N	---\ndischarge_datetime: \ntreatment_description: Test treatment_description1\nstatus: admitted\npatient_id: 12\ndepartment_id: 1\nbed_id: 12\nid: 19\nadmission_datetime: 2024-04-19 11:36:22.606700000 Z\ncreated_at: 2024-04-19 11:36:22.618776000 Z\nupdated_at: 2024-04-19 11:36:22.618776000 Z\n	2024-04-30 13:54:02.491275
20	Bed	12	update	\N	---\nstatus: acquired\nid: 12\nward_type: IICU\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.825375000 Z\nupdated_at: 2024-04-19 11:36:22.631926000 Z\n	2024-04-30 13:54:02.50554
21	Ipd	7	update	\N	---\ndischarge_datetime: \ntreatment_description: test treatment\nstatus: admitted\npatient_id: 7\ndepartment_id: 5\nbed_id: 46\nid: 7\nadmission_datetime: 2024-04-03 11:49:43.000000000 Z\ncreated_at: 2024-04-16 08:38:45.188696000 Z\nupdated_at: 2024-04-17 08:15:49.911378000 Z\n	2024-04-30 13:59:52.441118
22	Bed	71	create	\N	\N	2024-05-01 12:55:24.492515
23	Bed	27	update	\N	---\nstatus: vaccant\nid: 27\nward_type: Emergency\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.866309000 Z\nupdated_at: 2024-04-16 08:38:44.866309000 Z\n	2024-05-02 07:10:23.207948
24	Bed	71	update	\N	---\nstatus: unavailable\nid: 71\nward_type: Emergency\nbed_no: '1'\ncreated_at: 2024-05-01 12:55:24.492515000 Z\nupdated_at: 2024-05-01 12:55:24.492515000 Z\n	2024-05-02 07:14:46.114707
25	Bed	27	update	\N	---\nstatus: unavailable\nid: 27\nward_type: Emergency\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.866309000 Z\nupdated_at: 2024-05-02 07:10:23.207948000 Z\n	2024-05-02 07:14:51.313877
26	Bed	71	update	\N	---\nstatus: vaccant\nid: 71\nward_type: Emergency\nbed_no: '1'\ncreated_at: 2024-05-01 12:55:24.492515000 Z\nupdated_at: 2024-05-02 07:14:46.114707000 Z\n	2024-05-02 07:15:27.152348
27	Bed	21	update	\N	---\nstatus: vaccant\nid: 21\nward_type: Emergency\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.850372000 Z\nupdated_at: 2024-04-16 08:38:44.850372000 Z\n	2024-05-02 07:17:00.685666
28	Bed	71	destroy	\N	---\nid: 71\nward_type: Emergency\nbed_no: '1'\nstatus: unavailable\ncreated_at: 2024-05-01 12:55:24.492515000 Z\nupdated_at: 2024-05-02 07:15:27.152348000 Z\n	2024-05-02 07:18:20.394922
29	Bed	45	update	\N	---\nstatus: vaccant\nid: 45\nward_type: Pediatric\nbed_no: '5'\ncreated_at: 2024-04-16 08:38:44.916154000 Z\nupdated_at: 2024-04-16 08:38:44.916154000 Z\n	2024-05-02 07:41:56.622678
30	Bed	56	update	\N	---\nstatus: vaccant\nid: 56\nward_type: Maternity\nbed_no: '6'\ncreated_at: 2024-04-16 08:38:44.943660000 Z\nupdated_at: 2024-04-16 08:38:44.943660000 Z\n	2024-05-02 07:43:42.686764
31	Bed	42	update	\N	---\nstatus: vaccant\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-04-16 08:38:44.907161000 Z\n	2024-05-02 07:52:03.071451
32	Bed	42	update	\N	---\nstatus: unavailable\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-02 07:52:03.071451000 Z\n	2024-05-02 07:56:25.770562
33	Bed	45	update	\N	---\nstatus: unavailable\nid: 45\nward_type: Pediatric\nbed_no: '5'\ncreated_at: 2024-04-16 08:38:44.916154000 Z\nupdated_at: 2024-05-02 07:41:56.622678000 Z\n	2024-05-02 07:59:01.256229
34	Bed	31	update	\N	---\nstatus: vaccant\nid: 31\nward_type: Surgical\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.877500000 Z\nupdated_at: 2024-04-16 08:38:44.877500000 Z\n	2024-05-02 08:05:42.555638
35	Bed	31	update	\N	---\nstatus: unavailable\nid: 31\nward_type: Surgical\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.877500000 Z\nupdated_at: 2024-05-02 08:05:42.555638000 Z\n	2024-05-02 08:07:39.305074
36	Bed	31	update	\N	---\nstatus: vaccant\nid: 31\nward_type: Surgical\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.877500000 Z\nupdated_at: 2024-05-02 08:07:39.305074000 Z\n	2024-05-02 08:08:16.358486
37	Bed	64	update	\N	---\nstatus: vaccant\nid: 64\nward_type: Psychiatric\nbed_no: '4'\ncreated_at: 2024-04-16 08:38:44.965767000 Z\nupdated_at: 2024-04-16 08:38:44.965767000 Z\n	2024-05-02 08:11:24.627752
38	Bed	31	update	\N	---\nstatus: unavailable\nid: 31\nward_type: Surgical\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.877500000 Z\nupdated_at: 2024-05-02 08:08:16.358486000 Z\n	2024-05-02 08:12:48.62778
39	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-04-16 08:38:44.853174000 Z\n	2024-05-02 09:44:29.723684
40	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:29.723684000 Z\n	2024-05-02 09:44:31.152146
41	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:31.152146000 Z\n	2024-05-02 09:44:32.449864
42	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:32.449864000 Z\n	2024-05-02 09:44:34.888357
43	Bed	12	update	\N	---\nstatus: vaccant\nid: 12\nward_type: IICU\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.825375000 Z\nupdated_at: 2024-04-30 13:54:02.505540000 Z\n	2024-05-02 09:44:46.074427
44	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:34.888357000 Z\n	2024-05-02 09:44:48.3497
45	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:48.349700000 Z\n	2024-05-02 09:44:49.305075
46	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:49.305075000 Z\n	2024-05-02 09:44:50.490799
47	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:50.490799000 Z\n	2024-05-02 09:44:51.457178
48	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:51.457178000 Z\n	2024-05-02 09:44:52.418556
49	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:52.418556000 Z\n	2024-05-02 09:44:53.307389
50	Bed	30	update	\N	---\nstatus: vaccant\nid: 30\nward_type: Emergency\nbed_no: '10'\ncreated_at: 2024-04-16 08:38:44.874949000 Z\nupdated_at: 2024-04-16 08:38:44.874949000 Z\n	2024-05-02 09:44:57.262783
51	Bed	30	update	\N	---\nstatus: unavailable\nid: 30\nward_type: Emergency\nbed_no: '10'\ncreated_at: 2024-04-16 08:38:44.874949000 Z\nupdated_at: 2024-05-02 09:44:57.262783000 Z\n	2024-05-02 09:45:00.141275
52	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:44:53.307389000 Z\n	2024-05-02 09:45:02.083754
53	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:45:02.083754000 Z\n	2024-05-02 09:45:03.027054
54	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:45:03.027054000 Z\n	2024-05-02 09:45:03.802185
55	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:45:03.802185000 Z\n	2024-05-02 09:45:04.489924
56	Bed	27	update	\N	---\nstatus: vaccant\nid: 27\nward_type: Emergency\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.866309000 Z\nupdated_at: 2024-05-02 07:14:51.313877000 Z\n	2024-05-02 09:45:16.416673
57	Bed	27	update	\N	---\nstatus: unavailable\nid: 27\nward_type: Emergency\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.866309000 Z\nupdated_at: 2024-05-02 09:45:16.416673000 Z\n	2024-05-02 09:45:19.303511
58	Bed	51	update	\N	---\nstatus: vaccant\nid: 51\nward_type: Maternity\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.931714000 Z\nupdated_at: 2024-04-16 08:38:44.931714000 Z\n	2024-05-02 09:52:57.169314
59	Bed	51	update	\N	---\nstatus: unavailable\nid: 51\nward_type: Maternity\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.931714000 Z\nupdated_at: 2024-05-02 09:52:57.169314000 Z\n	2024-05-02 09:53:10.255122
60	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:45:04.489924000 Z\n	2024-05-02 09:57:57.858456
61	Bed	21	update	\N	---\nstatus: unavailable\nid: 21\nward_type: Emergency\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.850372000 Z\nupdated_at: 2024-05-02 07:17:00.685666000 Z\n	2024-05-02 10:02:11.22189
62	Bed	12	update	\N	---\nstatus: unavailable\nid: 12\nward_type: IICU\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.825375000 Z\nupdated_at: 2024-05-02 09:44:46.074427000 Z\n	2024-05-02 10:03:40.881324
63	Bed	21	update	\N	---\nstatus: vaccant\nid: 21\nward_type: Emergency\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.850372000 Z\nupdated_at: 2024-05-02 10:02:11.221890000 Z\n	2024-05-02 10:04:12.222777
64	Bed	21	update	\N	---\nstatus: unavailable\nid: 21\nward_type: Emergency\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.850372000 Z\nupdated_at: 2024-05-02 10:04:12.222777000 Z\n	2024-05-02 10:04:13.941522
65	Bed	51	update	\N	---\nstatus: vaccant\nid: 51\nward_type: Maternity\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.931714000 Z\nupdated_at: 2024-05-02 09:53:10.255122000 Z\n	2024-05-02 10:04:19.442015
66	Bed	22	update	\N	---\nstatus: unavailable\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 09:57:57.858456000 Z\n	2024-05-02 10:04:27.05277
67	Bed	41	update	\N	---\nstatus: vaccant\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-04-16 08:38:44.904508000 Z\n	2024-05-02 10:04:42.090234
68	Bed	21	update	\N	---\nstatus: vaccant\nid: 21\nward_type: Emergency\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.850372000 Z\nupdated_at: 2024-05-02 10:04:13.941522000 Z\n	2024-05-02 10:05:25.107311
69	Bed	12	update	\N	---\nstatus: vaccant\nid: 12\nward_type: IICU\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.825375000 Z\nupdated_at: 2024-05-02 10:03:40.881324000 Z\n	2024-05-02 13:55:03.940283
70	Bed	14	update	\N	---\nstatus: vaccant\nid: 14\nward_type: IICU\nbed_no: '4'\ncreated_at: 2024-04-16 08:38:44.831211000 Z\nupdated_at: 2024-04-19 11:34:23.287808000 Z\n	2024-05-03 06:38:49.452256
71	Bed	33	update	\N	---\nstatus: vaccant\nid: 33\nward_type: Surgical\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.883493000 Z\nupdated_at: 2024-04-16 08:38:44.883493000 Z\n	2024-05-03 06:43:26.160379
72	Bed	33	update	\N	---\nstatus: unavailable\nid: 33\nward_type: Surgical\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.883493000 Z\nupdated_at: 2024-05-03 06:43:26.160379000 Z\n	2024-05-03 06:47:40.68519
73	Bed	22	update	\N	---\nstatus: vaccant\nid: 22\nward_type: Emergency\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.853174000 Z\nupdated_at: 2024-05-02 10:04:27.052770000 Z\n	2024-05-03 06:49:10.502293
74	Bed	51	update	\N	---\nstatus: unavailable\nid: 51\nward_type: Maternity\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.931714000 Z\nupdated_at: 2024-05-02 10:04:19.442015000 Z\n	2024-05-03 06:51:49.105738
75	Bed	51	update	\N	---\nstatus: vaccant\nid: 51\nward_type: Maternity\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.931714000 Z\nupdated_at: 2024-05-03 06:51:49.105738000 Z\n	2024-05-03 06:57:25.702059
76	Bed	41	update	\N	---\nstatus: unavailable\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-02 10:04:42.090234000 Z\n	2024-05-03 06:57:45.597983
77	Bed	41	update	\N	---\nstatus: vaccant\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 06:57:45.597983000 Z\n	2024-05-03 07:08:10.597969
78	Bed	41	update	\N	---\nstatus: unavailable\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:08:10.597969000 Z\n	2024-05-03 07:08:10.869771
79	Bed	41	update	\N	---\nstatus: vaccant\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:08:10.869771000 Z\n	2024-05-03 07:08:11.1631
80	Bed	41	update	\N	---\nstatus: unavailable\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:08:11.163100000 Z\n	2024-05-03 07:08:27.923205
81	Bed	41	update	\N	---\nstatus: vaccant\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:08:27.923205000 Z\n	2024-05-03 07:08:28.157431
82	Bed	41	update	\N	---\nstatus: unavailable\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:08:28.157431000 Z\n	2024-05-03 07:08:28.463785
83	Bed	42	update	\N	---\nstatus: vaccant\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-02 07:56:25.770562000 Z\n	2024-05-03 07:08:34.935673
84	Bed	42	update	\N	---\nstatus: unavailable\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:08:34.935673000 Z\n	2024-05-03 07:15:34.93155
85	Bed	42	update	\N	---\nstatus: vaccant\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:34.931550000 Z\n	2024-05-03 07:15:35.34616
86	Bed	42	update	\N	---\nstatus: unavailable\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:35.346160000 Z\n	2024-05-03 07:15:35.693806
87	Bed	42	update	\N	---\nstatus: vaccant\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:35.693806000 Z\n	2024-05-03 07:15:36.041846
88	Bed	42	update	\N	---\nstatus: unavailable\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:36.041846000 Z\n	2024-05-03 07:15:36.415238
89	Bed	42	update	\N	---\nstatus: vaccant\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:36.415238000 Z\n	2024-05-03 07:15:37.735734
90	Bed	42	update	\N	---\nstatus: unavailable\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:37.735734000 Z\n	2024-05-03 07:15:38.429811
91	Bed	42	update	\N	---\nstatus: vaccant\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:38.429811000 Z\n	2024-05-03 07:15:39.326782
92	Bed	42	update	\N	---\nstatus: unavailable\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:39.326782000 Z\n	2024-05-03 07:15:40.541479
93	Bed	47	update	\N	---\nstatus: vaccant\nid: 47\nward_type: Pediatric\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.921687000 Z\nupdated_at: 2024-04-16 08:38:44.921687000 Z\n	2024-05-03 07:24:23.636531
94	Bed	47	update	\N	---\nstatus: unavailable\nid: 47\nward_type: Pediatric\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.921687000 Z\nupdated_at: 2024-05-03 07:24:23.636531000 Z\n	2024-05-03 07:24:55.650152
95	Bed	47	update	\N	---\nstatus: vaccant\nid: 47\nward_type: Pediatric\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.921687000 Z\nupdated_at: 2024-05-03 07:24:55.650152000 Z\n	2024-05-03 07:24:57.087953
96	Bed	48	update	\N	---\nstatus: vaccant\nid: 48\nward_type: Pediatric\nbed_no: '8'\ncreated_at: 2024-04-16 08:38:44.924009000 Z\nupdated_at: 2024-04-16 08:38:44.924009000 Z\n	2024-05-03 07:25:38.932173
97	Bed	41	update	\N	---\nstatus: vaccant\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:08:28.463785000 Z\n	2024-05-03 07:33:18.148465
98	Bed	41	update	\N	---\nstatus: unavailable\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:33:18.148465000 Z\n	2024-05-03 07:44:06.182173
99	Bed	42	update	\N	---\nstatus: vaccant\nid: 42\nward_type: Pediatric\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.907161000 Z\nupdated_at: 2024-05-03 07:15:40.541479000 Z\n	2024-05-03 07:47:09.517478
100	Bed	43	update	\N	---\nstatus: vaccant\nid: 43\nward_type: Pediatric\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.909938000 Z\nupdated_at: 2024-04-16 08:38:44.909938000 Z\n	2024-05-03 07:51:33.206326
101	Bed	43	update	\N	---\nstatus: unavailable\nid: 43\nward_type: Pediatric\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.909938000 Z\nupdated_at: 2024-05-03 07:51:33.206326000 Z\n	2024-05-03 07:52:58.759305
102	Bed	43	update	\N	---\nstatus: vaccant\nid: 43\nward_type: Pediatric\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.909938000 Z\nupdated_at: 2024-05-03 07:52:58.759305000 Z\n	2024-05-03 07:53:04.589814
103	Bed	43	update	\N	---\nstatus: unavailable\nid: 43\nward_type: Pediatric\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.909938000 Z\nupdated_at: 2024-05-03 07:53:04.589814000 Z\n	2024-05-03 07:59:50.456561
104	Bed	41	update	\N	---\nstatus: vaccant\nid: 41\nward_type: Pediatric\nbed_no: '1'\ncreated_at: 2024-04-16 08:38:44.904508000 Z\nupdated_at: 2024-05-03 07:44:06.182173000 Z\n	2024-05-03 08:02:00.865518
105	Bed	43	update	\N	---\nstatus: vaccant\nid: 43\nward_type: Pediatric\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.909938000 Z\nupdated_at: 2024-05-03 07:59:50.456561000 Z\n	2024-05-03 08:06:52.109945
106	Bed	44	update	\N	---\nstatus: vaccant\nid: 44\nward_type: Pediatric\nbed_no: '4'\ncreated_at: 2024-04-16 08:38:44.912459000 Z\nupdated_at: 2024-04-16 08:38:44.912459000 Z\n	2024-05-03 08:08:45.591018
107	Bed	52	update	\N	---\nstatus: vaccant\nid: 52\nward_type: Maternity\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.933977000 Z\nupdated_at: 2024-04-16 08:38:44.933977000 Z\n	2024-05-03 08:12:21.630484
108	Bed	53	update	\N	---\nstatus: vaccant\nid: 53\nward_type: Maternity\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.936580000 Z\nupdated_at: 2024-04-16 08:38:44.936580000 Z\n	2024-05-03 08:13:50.457444
109	Bed	55	update	\N	---\nstatus: vaccant\nid: 55\nward_type: Maternity\nbed_no: '5'\ncreated_at: 2024-04-16 08:38:44.941354000 Z\nupdated_at: 2024-04-16 08:38:44.941354000 Z\n	2024-05-03 08:16:07.711875
110	Bed	57	update	\N	---\nstatus: vaccant\nid: 57\nward_type: Maternity\nbed_no: '7'\ncreated_at: 2024-04-16 08:38:44.946698000 Z\nupdated_at: 2024-04-16 08:38:44.946698000 Z\n	2024-05-03 08:18:45.4664
111	Bed	23	update	\N	---\nstatus: vaccant\nid: 23\nward_type: Emergency\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.855663000 Z\nupdated_at: 2024-04-16 08:38:44.855663000 Z\n	2024-05-03 08:21:12.101443
112	Bed	23	update	\N	---\nstatus: unavailable\nid: 23\nward_type: Emergency\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.855663000 Z\nupdated_at: 2024-05-03 08:21:12.101443000 Z\n	2024-05-03 08:21:28.229117
113	Bed	23	update	\N	---\nstatus: vaccant\nid: 23\nward_type: Emergency\nbed_no: '3'\ncreated_at: 2024-04-16 08:38:44.855663000 Z\nupdated_at: 2024-05-03 08:21:28.229117000 Z\n	2024-05-03 08:21:57.219166
114	Bed	24	update	\N	---\nstatus: vaccant\nid: 24\nward_type: Emergency\nbed_no: '4'\ncreated_at: 2024-04-16 08:38:44.858540000 Z\nupdated_at: 2024-04-16 08:38:44.858540000 Z\n	2024-05-03 08:26:42.741739
115	Bed	58	update	\N	---\nstatus: vaccant\nid: 58\nward_type: Maternity\nbed_no: '8'\ncreated_at: 2024-04-16 08:38:44.949250000 Z\nupdated_at: 2024-04-16 08:38:44.949250000 Z\n	2024-05-03 08:44:49.113469
116	Ipd	21	create	\N	\N	2024-05-08 13:49:15.020557
117	Bed	18	update	\N	---\nstatus: vaccant\nid: 18\nward_type: IICU\nbed_no: '8'\ncreated_at: 2024-04-16 08:38:44.842358000 Z\nupdated_at: 2024-04-16 08:38:44.842358000 Z\n	2024-05-08 13:49:15.041331
118	Ipd	22	create	\N	\N	2024-05-09 05:05:41.995442
119	Bed	25	update	\N	---\nstatus: vaccant\nid: 25\nward_type: Emergency\nbed_no: '5'\ncreated_at: 2024-04-16 08:38:44.860906000 Z\nupdated_at: 2024-04-16 08:38:44.860906000 Z\n	2024-05-09 05:05:42.016538
120	Ipd	23	create	\N	\N	2024-05-09 05:06:21.95756
121	Bed	32	update	\N	---\nstatus: vaccant\nid: 32\nward_type: Surgical\nbed_no: '2'\ncreated_at: 2024-04-16 08:38:44.880597000 Z\nupdated_at: 2024-04-16 08:38:44.880597000 Z\n	2024-05-09 05:06:21.967794
122	Ipd	24	create	\N	\N	2024-05-09 05:08:10.083426
123	Bed	34	update	\N	---\nstatus: vaccant\nid: 34\nward_type: Surgical\nbed_no: '4'\ncreated_at: 2024-04-16 08:38:44.886563000 Z\nupdated_at: 2024-04-16 08:38:44.886563000 Z\n	2024-05-09 05:08:10.093612
124	Ipd	20	update	\N	---\ndischarge_datetime: \ntreatment_description: \nstatus: admitted\npatient_id: 8\ndepartment_id: 3\nbed_id: 13\nid: 20\nadmission_datetime: 2024-04-30 03:50:00.000000000 Z\ncreated_at: 2024-04-30 11:48:21.916608000 Z\nupdated_at: 2024-04-30 11:48:21.916608000 Z\n	2024-05-09 09:39:09.738082
125	Ipd	20	update	44	---\npatient_id: 8\ndepartment_id: 3\ntreatment_description: \nadmission_datetime: 2024-04-30 03:50:00.000000000 Z\ndischarge_datetime: 2024-05-09 09:39:09.737305000 Z\nbed_id: 13\nstatus: discharged\nid: 20\ncreated_at: 2024-04-30 11:48:21.916608000 Z\nupdated_at: 2024-05-09 09:39:09.738082000 Z\n	2024-05-09 09:43:14.747513
126	Ipd	20	update	\N	---\ndischarge_datetime: 2024-05-09 09:39:09.000000000 Z\ntreatment_description: \nstatus: admittted\npatient_id: 8\ndepartment_id: 3\nbed_id: 13\nid: 20\nadmission_datetime: 2024-04-30 03:50:00.000000000 Z\ncreated_at: 2024-04-30 11:48:21.916608000 Z\nupdated_at: 2024-05-09 09:43:14.747513000 Z\n	2024-05-09 09:43:36.961116
127	Ipd	21	update	\N	---\ndischarge_datetime: \ntreatment_description: \nstatus: admitted\npatient_id: 12\ndepartment_id: 5\nbed_id: 18\nid: 21\nadmission_datetime: 2024-05-07 13:49:00.000000000 Z\ncreated_at: 2024-05-08 13:49:15.020557000 Z\nupdated_at: 2024-05-08 13:49:15.020557000 Z\n	2024-05-09 09:52:39.723071
\.


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.appointments_id_seq', 27, true);


--
-- Name: beds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.beds_id_seq', 71, true);


--
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.departments_id_seq', 23, true);


--
-- Name: doctor_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.doctor_details_id_seq', 14, true);


--
-- Name: ipds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.ipds_id_seq', 24, true);


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.patients_id_seq', 17, true);


--
-- Name: treatments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.treatments_id_seq', 67, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.users_id_seq', 48, true);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ue
--

SELECT pg_catalog.setval('public.versions_id_seq', 127, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: beds beds_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.beds
    ADD CONSTRAINT beds_pkey PRIMARY KEY (id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: doctor_details doctor_details_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.doctor_details
    ADD CONSTRAINT doctor_details_pkey PRIMARY KEY (id);


--
-- Name: ipds ipds_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.ipds
    ADD CONSTRAINT ipds_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: treatments treatments_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.treatments
    ADD CONSTRAINT treatments_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_appointments_on_doctor_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_appointments_on_doctor_id ON public.appointments USING btree (doctor_id);


--
-- Name: index_appointments_on_patient_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_appointments_on_patient_id ON public.appointments USING btree (patient_id);


--
-- Name: index_appointments_on_user_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_appointments_on_user_id ON public.appointments USING btree (user_id);


--
-- Name: index_doctor_details_on_department_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_doctor_details_on_department_id ON public.doctor_details USING btree (department_id);


--
-- Name: index_doctor_details_on_user_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_doctor_details_on_user_id ON public.doctor_details USING btree (user_id);


--
-- Name: index_ipds_on_bed_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_ipds_on_bed_id ON public.ipds USING btree (bed_id);


--
-- Name: index_ipds_on_department_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_ipds_on_department_id ON public.ipds USING btree (department_id);


--
-- Name: index_ipds_on_patient_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_ipds_on_patient_id ON public.ipds USING btree (patient_id);


--
-- Name: index_patients_on_user_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_patients_on_user_id ON public.patients USING btree (user_id);


--
-- Name: index_treatments_on_ipd_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_treatments_on_ipd_id ON public.treatments USING btree (ipd_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: ue
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: ue
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: ue
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: patients fk_rails_623f05c630; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT fk_rails_623f05c630 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: ipds fk_rails_62f0caad55; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.ipds
    ADD CONSTRAINT fk_rails_62f0caad55 FOREIGN KEY (bed_id) REFERENCES public.beds(id);


--
-- Name: appointments fk_rails_8db8e1e8a5; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_rails_8db8e1e8a5 FOREIGN KEY (doctor_id) REFERENCES public.users(id);


--
-- Name: treatments fk_rails_9a866db74b; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.treatments
    ADD CONSTRAINT fk_rails_9a866db74b FOREIGN KEY (ipd_id) REFERENCES public.ipds(id);


--
-- Name: appointments fk_rails_9e31213785; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_rails_9e31213785 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: ipds fk_rails_a247a0b52b; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.ipds
    ADD CONSTRAINT fk_rails_a247a0b52b FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: appointments fk_rails_c63da04ab4; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_rails_c63da04ab4 FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: ipds fk_rails_ceeeb65fe6; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.ipds
    ADD CONSTRAINT fk_rails_ceeeb65fe6 FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: doctor_details fk_rails_d2de7ba71c; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.doctor_details
    ADD CONSTRAINT fk_rails_d2de7ba71c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: doctor_details fk_rails_e7391c363d; Type: FK CONSTRAINT; Schema: public; Owner: ue
--

ALTER TABLE ONLY public.doctor_details
    ADD CONSTRAINT fk_rails_e7391c363d FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- PostgreSQL database dump complete
--

