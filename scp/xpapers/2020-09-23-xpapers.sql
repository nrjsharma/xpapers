--
-- PostgreSQL database dump
--

-- Dumped from database version 10.14 (Ubuntu 10.14-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.14 (Ubuntu 10.14-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: dashboard_branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_branch (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    created timestamp with time zone NOT NULL,
    slug character varying(500) NOT NULL
);


ALTER TABLE public.dashboard_branch OWNER TO postgres;

--
-- Name: dashboard_branch_courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_branch_courses (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE public.dashboard_branch_courses OWNER TO postgres;

--
-- Name: dashboard_branch_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_branch_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_branch_courses_id_seq OWNER TO postgres;

--
-- Name: dashboard_branch_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_branch_courses_id_seq OWNED BY public.dashboard_branch_courses.id;


--
-- Name: dashboard_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_branch_id_seq OWNER TO postgres;

--
-- Name: dashboard_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_branch_id_seq OWNED BY public.dashboard_branch.id;


--
-- Name: dashboard_branch_universities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_branch_universities (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    university_id integer NOT NULL
);


ALTER TABLE public.dashboard_branch_universities OWNER TO postgres;

--
-- Name: dashboard_branch_universities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_branch_universities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_branch_universities_id_seq OWNER TO postgres;

--
-- Name: dashboard_branch_universities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_branch_universities_id_seq OWNED BY public.dashboard_branch_universities.id;


--
-- Name: dashboard_collage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_collage (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    created timestamp with time zone NOT NULL,
    thumbnail character varying(100),
    slug character varying(500) NOT NULL,
    university_id integer NOT NULL
);


ALTER TABLE public.dashboard_collage OWNER TO postgres;

--
-- Name: dashboard_collage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_collage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_collage_id_seq OWNER TO postgres;

--
-- Name: dashboard_collage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_collage_id_seq OWNED BY public.dashboard_collage.id;


--
-- Name: dashboard_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_course (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    created timestamp with time zone NOT NULL,
    slug character varying(500) NOT NULL
);


ALTER TABLE public.dashboard_course OWNER TO postgres;

--
-- Name: dashboard_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_course_id_seq OWNER TO postgres;

--
-- Name: dashboard_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_course_id_seq OWNED BY public.dashboard_course.id;


--
-- Name: dashboard_course_universities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_course_universities (
    id integer NOT NULL,
    course_id integer NOT NULL,
    university_id integer NOT NULL
);


ALTER TABLE public.dashboard_course_universities OWNER TO postgres;

--
-- Name: dashboard_course_universities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_course_universities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_course_universities_id_seq OWNER TO postgres;

--
-- Name: dashboard_course_universities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_course_universities_id_seq OWNED BY public.dashboard_course_universities.id;


--
-- Name: dashboard_post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_post (
    id integer NOT NULL,
    year integer NOT NULL,
    created timestamp with time zone NOT NULL,
    type character varying(1) NOT NULL,
    branch_id integer NOT NULL,
    collage_id integer,
    course_id integer NOT NULL,
    subject_id integer NOT NULL,
    university_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.dashboard_post OWNER TO postgres;

--
-- Name: dashboard_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_post_id_seq OWNER TO postgres;

--
-- Name: dashboard_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_post_id_seq OWNED BY public.dashboard_post.id;


--
-- Name: dashboard_postfiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_postfiles (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    post_id integer NOT NULL
);


ALTER TABLE public.dashboard_postfiles OWNER TO postgres;

--
-- Name: dashboard_postfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_postfiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_postfiles_id_seq OWNER TO postgres;

--
-- Name: dashboard_postfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_postfiles_id_seq OWNED BY public.dashboard_postfiles.id;


--
-- Name: dashboard_subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_subject (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    created timestamp with time zone NOT NULL,
    slug character varying(500) NOT NULL
);


ALTER TABLE public.dashboard_subject OWNER TO postgres;

--
-- Name: dashboard_subject_branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_subject_branches (
    id integer NOT NULL,
    subject_id integer NOT NULL,
    branch_id integer NOT NULL
);


ALTER TABLE public.dashboard_subject_branches OWNER TO postgres;

--
-- Name: dashboard_subject_branches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_subject_branches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_subject_branches_id_seq OWNER TO postgres;

--
-- Name: dashboard_subject_branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_subject_branches_id_seq OWNED BY public.dashboard_subject_branches.id;


--
-- Name: dashboard_subject_courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_subject_courses (
    id integer NOT NULL,
    subject_id integer NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE public.dashboard_subject_courses OWNER TO postgres;

--
-- Name: dashboard_subject_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_subject_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_subject_courses_id_seq OWNER TO postgres;

--
-- Name: dashboard_subject_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_subject_courses_id_seq OWNED BY public.dashboard_subject_courses.id;


--
-- Name: dashboard_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_subject_id_seq OWNER TO postgres;

--
-- Name: dashboard_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_subject_id_seq OWNED BY public.dashboard_subject.id;


--
-- Name: dashboard_subject_universities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_subject_universities (
    id integer NOT NULL,
    subject_id integer NOT NULL,
    university_id integer NOT NULL
);


ALTER TABLE public.dashboard_subject_universities OWNER TO postgres;

--
-- Name: dashboard_subject_universities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_subject_universities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_subject_universities_id_seq OWNER TO postgres;

--
-- Name: dashboard_subject_universities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_subject_universities_id_seq OWNED BY public.dashboard_subject_universities.id;


--
-- Name: dashboard_university; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_university (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    created timestamp with time zone NOT NULL,
    thumbnail character varying(100),
    slug character varying(500) NOT NULL
);


ALTER TABLE public.dashboard_university OWNER TO postgres;

--
-- Name: dashboard_university_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_university_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_university_id_seq OWNER TO postgres;

--
-- Name: dashboard_university_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_university_id_seq OWNED BY public.dashboard_university.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: xpauth_xpapersuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xpauth_xpapersuser (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    email character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    profile_image character varying(100),
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_admin boolean NOT NULL,
    is_email_varified boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL
);


ALTER TABLE public.xpauth_xpapersuser OWNER TO postgres;

--
-- Name: xpauth_xpapersuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.xpauth_xpapersuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.xpauth_xpapersuser_id_seq OWNER TO postgres;

--
-- Name: xpauth_xpapersuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xpauth_xpapersuser_id_seq OWNED BY public.xpauth_xpapersuser.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: dashboard_branch id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch ALTER COLUMN id SET DEFAULT nextval('public.dashboard_branch_id_seq'::regclass);


--
-- Name: dashboard_branch_courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_courses ALTER COLUMN id SET DEFAULT nextval('public.dashboard_branch_courses_id_seq'::regclass);


--
-- Name: dashboard_branch_universities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_universities ALTER COLUMN id SET DEFAULT nextval('public.dashboard_branch_universities_id_seq'::regclass);


--
-- Name: dashboard_collage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_collage ALTER COLUMN id SET DEFAULT nextval('public.dashboard_collage_id_seq'::regclass);


--
-- Name: dashboard_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course ALTER COLUMN id SET DEFAULT nextval('public.dashboard_course_id_seq'::regclass);


--
-- Name: dashboard_course_universities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course_universities ALTER COLUMN id SET DEFAULT nextval('public.dashboard_course_universities_id_seq'::regclass);


--
-- Name: dashboard_post id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post ALTER COLUMN id SET DEFAULT nextval('public.dashboard_post_id_seq'::regclass);


--
-- Name: dashboard_postfiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_postfiles ALTER COLUMN id SET DEFAULT nextval('public.dashboard_postfiles_id_seq'::regclass);


--
-- Name: dashboard_subject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject ALTER COLUMN id SET DEFAULT nextval('public.dashboard_subject_id_seq'::regclass);


--
-- Name: dashboard_subject_branches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_branches ALTER COLUMN id SET DEFAULT nextval('public.dashboard_subject_branches_id_seq'::regclass);


--
-- Name: dashboard_subject_courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_courses ALTER COLUMN id SET DEFAULT nextval('public.dashboard_subject_courses_id_seq'::regclass);


--
-- Name: dashboard_subject_universities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_universities ALTER COLUMN id SET DEFAULT nextval('public.dashboard_subject_universities_id_seq'::regclass);


--
-- Name: dashboard_university id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_university ALTER COLUMN id SET DEFAULT nextval('public.dashboard_university_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: xpauth_xpapersuser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xpauth_xpapersuser ALTER COLUMN id SET DEFAULT nextval('public.xpauth_xpapersuser_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Token	6	add_token
22	Can change Token	6	change_token
23	Can delete Token	6	delete_token
24	Can view Token	6	view_token
25	Can add branch	7	add_branch
26	Can change branch	7	change_branch
27	Can delete branch	7	delete_branch
28	Can view branch	7	view_branch
29	Can add collage	8	add_collage
30	Can change collage	8	change_collage
31	Can delete collage	8	delete_collage
32	Can view collage	8	view_collage
33	Can add course	9	add_course
34	Can change course	9	change_course
35	Can delete course	9	delete_course
36	Can view course	9	view_course
37	Can add post	10	add_post
38	Can change post	10	change_post
39	Can delete post	10	delete_post
40	Can view post	10	view_post
41	Can add university	11	add_university
42	Can change university	11	change_university
43	Can delete university	11	delete_university
44	Can view university	11	view_university
45	Can add subject	12	add_subject
46	Can change subject	12	change_subject
47	Can delete subject	12	delete_subject
48	Can view subject	12	view_subject
49	Can add post files	13	add_postfiles
50	Can change post files	13	change_postfiles
51	Can delete post files	13	delete_postfiles
52	Can view post files	13	view_postfiles
53	Can add xpapers user	14	add_xpapersuser
54	Can change xpapers user	14	change_xpapersuser
55	Can delete xpapers user	14	delete_xpapersuser
56	Can view xpapers user	14	view_xpapersuser
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: dashboard_branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_branch (id, name, created, slug) FROM stdin;
1	COMPUTER SCIENCE AND ENGINEERING (CSE)	2020-09-19 03:23:02.26106+00	computer-science-and-engineering-cse
2	CIVIL ENGINEERING	2020-09-19 04:01:00.387551+00	civil-engineering
3	ELECTRONICS ENGINEERING (ECE)	2020-09-19 21:00:24.44332+00	electronics-engineering-ece
4	MECHANICAL ENGINEERING (ME)	2020-09-19 21:01:22.316982+00	mechanical-engineering-me
\.


--
-- Data for Name: dashboard_branch_courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_branch_courses (id, branch_id, course_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	1	2
\.


--
-- Data for Name: dashboard_branch_universities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_branch_universities (id, branch_id, university_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
\.


--
-- Data for Name: dashboard_collage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_collage (id, name, created, thumbnail, slug, university_id) FROM stdin;
1	PUNJABI UNIVERSITY CAMPUS	2020-09-19 03:23:02.257479+00		punjabi-university-campus	1
\.


--
-- Data for Name: dashboard_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_course (id, name, created, slug) FROM stdin;
1	BACHELOR OF TECHNOLOGY (BTECH)	2020-09-19 03:23:02.25954+00	bachelor-of-technology-btech
2	MASTER OF ENGINEERING (MTECH)	2020-09-19 21:14:43.056739+00	master-of-engineering-mtech
\.


--
-- Data for Name: dashboard_course_universities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_course_universities (id, course_id, university_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: dashboard_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_post (id, year, created, type, branch_id, collage_id, course_id, subject_id, university_id, user_id) FROM stdin;
1	2020	2020-09-19 03:23:02.303236+00	M	1	1	1	1	1	1
2	2020	2020-09-19 03:25:01.938882+00	F	1	\N	1	2	1	1
3	2020	2020-09-19 03:29:45.1489+00	F	1	\N	1	3	1	1
4	2020	2020-09-19 03:34:01.165433+00	F	1	\N	1	4	1	1
5	2020	2020-09-19 03:35:35.607225+00	M	1	1	1	4	1	1
6	2020	2020-09-19 03:39:38.947374+00	M	1	1	1	5	1	1
7	2020	2020-09-19 03:42:36.34807+00	M	1	1	1	6	1	1
8	2020	2020-09-19 03:46:40.21572+00	F	1	\N	1	7	1	1
9	2020	2020-09-19 03:47:06.31116+00	M	1	1	1	7	1	1
10	2020	2020-09-19 03:49:50.6722+00	F	1	\N	1	8	1	1
11	2020	2020-09-19 03:51:11.381648+00	F	1	\N	1	9	1	1
12	2020	2020-09-19 03:51:43.021421+00	M	1	1	1	9	1	1
13	2020	2020-09-19 04:01:00.409988+00	M	2	1	1	1	1	1
14	2020	2020-09-19 16:37:18.025323+00	M	2	1	1	1	1	1
16	2020	2020-09-19 16:37:18.049162+00	F	2	\N	1	3	1	1
17	2020	2020-09-19 16:37:18.055575+00	F	2	\N	1	4	1	1
18	2020	2020-09-19 16:37:18.062648+00	M	2	1	1	4	1	1
19	2020	2020-09-19 16:37:18.070477+00	M	2	1	1	5	1	1
20	2020	2020-09-19 16:37:18.077664+00	M	2	1	1	6	1	1
21	2020	2020-09-19 16:37:18.083717+00	F	2	\N	1	7	1	1
22	2020	2020-09-19 16:37:18.090902+00	M	2	1	1	7	1	1
23	2020	2020-09-19 16:37:18.097479+00	F	2	\N	1	8	1	1
24	2020	2020-09-19 16:37:18.104245+00	F	2	\N	1	9	1	1
25	2020	2020-09-19 16:37:18.111402+00	M	2	1	1	9	1	1
15	2020	2020-09-19 16:37:18.041701+00	F	2	1	1	2	1	1
26	2020	2020-09-19 21:07:02.447602+00	M	3	1	1	1	1	1
27	2020	2020-09-19 21:07:02.458512+00	F	3	\N	1	2	1	1
28	2020	2020-09-19 21:07:02.465771+00	F	3	\N	1	3	1	1
29	2020	2020-09-19 21:07:02.472937+00	F	3	\N	1	4	1	1
30	2020	2020-09-19 21:07:02.481205+00	M	3	1	1	4	1	1
31	2020	2020-09-19 21:07:02.489213+00	M	3	1	1	5	1	1
32	2020	2020-09-19 21:07:02.497212+00	M	3	1	1	6	1	1
33	2020	2020-09-19 21:07:02.504042+00	F	3	\N	1	7	1	1
34	2020	2020-09-19 21:07:02.511736+00	M	3	1	1	7	1	1
35	2020	2020-09-19 21:07:02.518714+00	F	3	\N	1	8	1	1
36	2020	2020-09-19 21:07:02.52545+00	F	3	\N	1	9	1	1
37	2020	2020-09-19 21:07:02.533469+00	M	3	1	1	9	1	1
38	2020	2020-09-19 21:07:18.293909+00	M	4	1	1	1	1	1
39	2020	2020-09-19 21:07:18.298397+00	F	4	\N	1	2	1	1
40	2020	2020-09-19 21:07:18.301723+00	F	4	\N	1	3	1	1
41	2020	2020-09-19 21:07:18.305238+00	F	4	\N	1	4	1	1
42	2020	2020-09-19 21:07:18.308672+00	M	4	1	1	4	1	1
43	2020	2020-09-19 21:07:18.311962+00	M	4	1	1	5	1	1
44	2020	2020-09-19 21:07:18.315311+00	M	4	1	1	6	1	1
45	2020	2020-09-19 21:07:18.318707+00	F	4	\N	1	7	1	1
46	2020	2020-09-19 21:07:18.322228+00	M	4	1	1	7	1	1
47	2020	2020-09-19 21:07:18.325636+00	F	4	\N	1	8	1	1
48	2020	2020-09-19 21:07:18.328965+00	F	4	\N	1	9	1	1
49	2020	2020-09-19 21:07:18.33225+00	M	4	1	1	9	1	1
50	2020	2020-09-19 21:14:43.098359+00	F	1	\N	2	10	1	1
51	2020	2020-09-19 21:16:46.621497+00	F	1	\N	2	11	1	1
52	2020	2020-09-19 21:18:24.024932+00	F	1	\N	2	12	1	1
53	2020	2020-09-19 21:19:57.220533+00	F	1	\N	2	13	1	1
54	2020	2020-09-19 21:20:46.101176+00	M	1	1	2	14	1	1
55	2020	2020-09-19 21:21:57.98645+00	F	1	\N	2	15	1	1
56	2020	2020-09-19 21:22:37.930565+00	F	1	\N	2	16	1	1
57	2020	2020-09-19 21:23:34.857956+00	M	1	1	2	17	1	1
58	2020	2020-09-19 21:26:16.204655+00	F	1	\N	1	18	1	1
59	2020	2020-09-19 21:27:09.641033+00	M	1	1	1	18	1	1
60	2020	2020-09-19 21:28:01.82507+00	F	1	\N	1	19	1	1
61	2020	2020-09-19 21:28:48.066922+00	M	1	1	1	19	1	1
62	2020	2020-09-19 21:29:59.664384+00	F	1	\N	1	12	1	1
63	2020	2020-09-19 21:30:25.582661+00	M	1	1	1	12	1	1
64	2020	2020-09-19 21:31:53.091046+00	F	1	\N	1	20	1	1
65	2020	2020-09-19 21:32:14.218788+00	M	1	1	1	20	1	1
66	2020	2020-09-19 21:32:30.343106+00	M	1	1	1	20	1	1
67	2020	2020-09-19 21:34:24.856896+00	M	1	1	1	21	1	1
68	2020	2020-09-19 21:34:44.552652+00	M	1	1	1	21	1	1
69	2020	2020-09-19 21:35:48.622666+00	F	1	\N	1	22	1	1
70	2020	2020-09-19 21:36:31.538329+00	F	1	\N	1	23	1	1
71	2020	2020-09-19 21:36:54.953018+00	M	1	1	1	23	1	1
72	2020	2020-09-19 21:38:06.795549+00	M	1	1	1	24	1	1
73	2020	2020-09-19 21:39:09.701141+00	F	1	\N	1	25	1	1
74	2020	2020-09-19 21:39:58.253565+00	F	1	\N	1	26	1	1
75	2020	2020-09-19 21:41:39.933261+00	F	1	\N	1	27	1	1
76	2020	2020-09-19 21:42:08.755804+00	M	1	1	1	27	1	1
77	2020	2020-09-19 21:43:44.508844+00	F	1	\N	1	28	1	1
78	2020	2020-09-19 21:44:06.92681+00	F	1	\N	1	29	1	1
79	2020	2020-09-19 21:44:41.577954+00	M	1	1	1	29	1	1
80	2020	2020-09-19 21:45:29.822502+00	F	1	\N	1	30	1	1
81	2020	2020-09-19 21:52:50.549523+00	F	1	\N	1	31	1	1
82	2020	2020-09-19 21:53:18.728327+00	M	1	1	1	31	1	1
83	2020	2020-09-19 21:54:11.674298+00	F	1	\N	1	32	1	1
84	2020	2020-09-19 21:55:22.604592+00	F	1	\N	1	33	1	1
85	2020	2020-09-19 21:55:43.284803+00	M	1	1	1	33	1	1
86	2020	2020-09-19 21:56:40.564593+00	F	1	\N	1	34	1	1
87	2020	2020-09-19 21:57:14.308062+00	M	1	1	1	34	1	1
88	2020	2020-09-19 21:58:04.054423+00	F	1	\N	1	35	1	1
89	2020	2020-09-19 21:58:23.089786+00	M	1	1	1	35	1	1
90	2020	2020-09-19 21:59:52.961661+00	F	1	\N	1	15	1	1
91	2020	2020-09-19 22:00:18.915075+00	M	1	1	1	15	1	1
92	2020	2020-09-19 22:01:11.00529+00	F	1	\N	1	36	1	1
93	2020	2020-09-19 22:01:46.669032+00	M	1	1	1	36	1	1
94	2020	2020-09-19 22:02:24.6615+00	F	1	\N	1	37	1	1
95	2020	2020-09-19 22:02:49.842256+00	M	1	1	1	37	1	1
96	2020	2020-09-19 22:03:37.922379+00	F	1	\N	1	38	1	1
97	2020	2020-09-19 22:04:05.015116+00	M	1	1	1	38	1	1
98	2020	2020-09-19 22:04:41.641403+00	F	1	\N	1	39	1	1
99	2020	2020-09-19 22:05:03.210875+00	M	1	1	1	39	1	1
100	2020	2020-09-19 22:05:23.747824+00	M	1	1	1	39	1	1
101	2020	2020-09-19 22:05:53.843634+00	F	1	\N	1	40	1	1
102	2020	2020-09-19 22:06:15.721353+00	M	1	1	1	40	1	1
103	2020	2020-09-19 22:06:52.406274+00	F	1	\N	1	41	1	1
104	2020	2020-09-19 22:07:10.346413+00	M	1	1	1	41	1	1
105	2020	2020-09-19 22:07:47.128393+00	F	1	\N	1	42	1	1
106	2020	2020-09-19 22:08:34.868091+00	F	1	\N	1	43	1	1
107	2020	2020-09-19 22:08:51.459872+00	M	1	1	1	43	1	1
108	2020	2020-09-19 22:09:29.845726+00	F	1	\N	1	44	1	1
109	2020	2020-09-19 22:10:04.00738+00	F	1	\N	1	45	1	1
110	2020	2020-09-19 22:10:24.001848+00	M	1	1	1	45	1	1
111	2020	2020-09-19 22:11:16.106905+00	F	1	\N	1	46	1	1
112	2020	2020-09-19 22:11:43.972932+00	M	1	1	1	46	1	1
113	2020	2020-09-19 22:15:31.519697+00	M	1	1	1	47	1	1
114	2020	2020-09-19 22:18:33.333226+00	F	4	\N	1	48	1	1
115	2020	2020-09-19 22:19:07.328474+00	F	4	\N	1	8	1	1
116	2020	2020-09-19 22:19:58.280949+00	F	4	\N	1	49	1	1
117	2020	2020-09-19 22:24:05.347464+00	F	3	\N	1	4	1	1
118	2020	2020-09-19 22:41:33.841849+00	F	3	\N	1	50	1	1
119	2020	2020-09-19 22:41:58.149526+00	F	3	\N	1	51	1	1
120	2020	2020-09-19 22:43:29.784881+00	F	2	\N	1	52	1	1
121	2020	2020-09-19 22:43:45.662266+00	M	2	1	1	52	1	1
122	2020	2020-09-19 22:44:26.935356+00	F	2	\N	1	53	1	1
123	2020	2020-09-19 22:44:42.748477+00	M	2	1	1	53	1	1
124	2020	2020-09-19 22:46:04.712388+00	F	2	\N	1	54	1	1
125	2020	2020-09-19 22:46:24.030037+00	M	2	1	1	54	1	1
126	2020	2020-09-19 22:47:00.971734+00	M	2	1	1	55	1	1
127	2020	2020-09-19 22:48:30.608816+00	F	2	\N	1	56	1	1
128	2020	2020-09-19 22:48:58.602015+00	F	2	\N	1	57	1	1
129	2020	2020-09-19 22:50:17.526869+00	F	2	\N	1	34	1	1
130	2020	2020-09-19 22:53:25.532971+00	F	2	\N	1	9	1	1
131	2020	2020-09-19 22:53:43.093053+00	M	2	1	1	9	1	1
132	2020	2020-09-19 22:55:29.325833+00	F	2	\N	1	36	1	1
133	2020	2020-09-19 22:57:42.313993+00	F	2	\N	1	36	1	1
134	2020	2020-09-19 22:58:03.248642+00	F	1	\N	1	36	1	1
135	2020	2020-09-19 22:58:40.885873+00	M	2	1	1	36	1	1
136	2020	2020-09-19 22:59:29.715213+00	M	2	1	1	36	1	1
138	2020	2020-09-19 23:01:02.070622+00	M	1	1	1	36	1	1
139	2020	2020-09-19 23:03:20.874126+00	F	3	\N	1	36	1	1
140	2020	2020-09-19 23:03:49.029405+00	F	3	\N	1	36	1	1
141	2020	2020-09-19 23:04:13.73651+00	M	3	1	1	36	1	1
142	2020	2020-09-19 23:04:37.937584+00	M	3	1	1	36	1	1
143	2020	2020-09-19 23:05:15.899587+00	M	4	1	1	36	1	1
144	2020	2020-09-19 23:05:55.244448+00	M	4	1	1	36	1	1
145	2020	2020-09-19 23:06:15.61472+00	F	4	\N	1	36	1	1
146	2020	2020-09-19 23:06:50.158027+00	F	4	\N	1	36	1	1
147	2020	2020-09-19 23:09:25.786908+00	F	2	\N	1	58	1	1
148	2020	2020-09-19 23:09:45.637113+00	F	4	\N	1	58	1	1
149	2020	2020-09-19 23:10:41.055879+00	M	2	1	1	58	1	1
150	2020	2020-09-19 23:11:27.718703+00	M	4	1	1	58	1	1
151	2020	2020-09-19 23:12:43.121121+00	F	1	\N	1	59	1	1
152	2020	2020-09-19 23:13:02.178141+00	F	2	\N	1	59	1	1
153	2020	2020-09-19 23:13:38.646003+00	F	2	\N	1	60	1	1
154	2020	2020-09-19 23:14:30.250187+00	F	2	\N	1	61	1	1
155	2020	2020-09-19 23:14:47.090006+00	M	2	1	1	61	1	1
156	2020	2020-09-19 23:16:25.154602+00	F	1	\N	1	62	1	1
157	2020	2020-09-19 23:16:42.216043+00	M	1	1	1	62	1	1
158	2020	2020-09-19 23:17:02.937051+00	F	2	\N	1	62	1	1
159	2020	2020-09-19 23:17:21.162173+00	M	2	1	1	62	1	1
160	2020	2020-09-19 23:18:46.872318+00	F	2	\N	1	63	1	1
161	2020	2020-09-19 23:19:08.709509+00	M	2	1	1	63	1	1
162	2020	2020-09-19 23:19:24.071551+00	F	2	\N	1	64	1	1
\.


--
-- Data for Name: dashboard_postfiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_postfiles (id, file, post_id) FROM stdin;
1	post_files/1/APPLIED-MATHEMATICS-M2-2020-Xpapers-nRj7777.pdf	1
2	post_files/2/APPLIED-PHYSICS-1-2020-Xpapers-nRj7777.pdf	2
3	post_files/3/APPLIED-PHYSICS-2-2020-Xpapers-.pdf	3
4	post_files/4/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	4
5	post_files/5/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	5
6	post_files/6/BASIC-THERMODYNAMICS-2020-Xpapers.pdf	6
7	post_files/7/COMMUNICATION-SKILLS-2020-Xpapers.pdf	7
8	post_files/8/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	8
9	post_files/9/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	9
10	post_files/10/MANAGEMENT-OF-PRODUCTION-SYSTEM-2020-Xpapers.pdf	10
11	post_files/11/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	11
12	post_files/12/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	12
13	post_files/13/APPLIED-MATHEMATICS-M2-2020-Xpapers.pdf	13
14	post_files/1/APPLIED-MATHEMATICS-M2-2020-Xpapers-nRj7777.pdf	14
15	post_files/2/APPLIED-PHYSICS-1-2020-Xpapers-nRj7777.pdf	15
16	post_files/3/APPLIED-PHYSICS-2-2020-Xpapers-.pdf	16
17	post_files/4/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	17
18	post_files/5/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	18
19	post_files/6/BASIC-THERMODYNAMICS-2020-Xpapers.pdf	19
20	post_files/7/COMMUNICATION-SKILLS-2020-Xpapers.pdf	20
21	post_files/8/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	21
22	post_files/9/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	22
23	post_files/10/MANAGEMENT-OF-PRODUCTION-SYSTEM-2020-Xpapers.pdf	23
24	post_files/11/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	24
25	post_files/12/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	25
26	post_files/1/APPLIED-MATHEMATICS-M2-2020-Xpapers-nRj7777.pdf	26
27	post_files/2/APPLIED-PHYSICS-1-2020-Xpapers-nRj7777.pdf	27
28	post_files/3/APPLIED-PHYSICS-2-2020-Xpapers-.pdf	28
29	post_files/4/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	29
30	post_files/5/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	30
31	post_files/6/BASIC-THERMODYNAMICS-2020-Xpapers.pdf	31
32	post_files/7/COMMUNICATION-SKILLS-2020-Xpapers.pdf	32
33	post_files/8/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	33
34	post_files/9/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	34
35	post_files/10/MANAGEMENT-OF-PRODUCTION-SYSTEM-2020-Xpapers.pdf	35
36	post_files/11/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	36
37	post_files/12/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	37
38	post_files/1/APPLIED-MATHEMATICS-M2-2020-Xpapers-nRj7777.pdf	38
39	post_files/2/APPLIED-PHYSICS-1-2020-Xpapers-nRj7777.pdf	39
40	post_files/3/APPLIED-PHYSICS-2-2020-Xpapers-.pdf	40
41	post_files/4/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	41
42	post_files/5/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpapers.pdf	42
43	post_files/6/BASIC-THERMODYNAMICS-2020-Xpapers.pdf	43
44	post_files/7/COMMUNICATION-SKILLS-2020-Xpapers.pdf	44
45	post_files/8/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	45
46	post_files/9/COMPUTER-PROGRAMMING-2020-Xpapers.pdf	46
47	post_files/10/MANAGEMENT-OF-PRODUCTION-SYSTEM-2020-Xpapers.pdf	47
48	post_files/11/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	48
49	post_files/12/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	49
50	post_files/50/ADVANCED-COMPUTER-ARCHITECTURE-2020-Xpapers.pdf	50
51	post_files/51/ADVANCED-DATA-STRUCTURE-AND-APPLICATIONS-2020-Xpapers.pdf	51
52	post_files/52/COMPILER-DESIGN-CD-2020-Xpapers.pdf	52
53	post_files/53/COMPUTER-NETWORK-TECHNOLOGIES-2020-Xpapers.pdf	53
54	post_files/54/DATA-WAREHOUSING-AND-DATA-MINING-2020-Xpapers.pdf	54
55	post_files/55/NETWORK-SECURITY-NS-2020-Xpapers.pdf	55
56	post_files/56/OBJECT-ORIENTED-ANALYSIS-AND-DESIGN-USING-UML-2020-Xpapers.pdf	56
57	post_files/57/VLSI-DESIGN-2020-Xpapers.pdf	57
58	post_files/58/ALGORITHM-ANALYSIS-AND-DESIGN-AAD-2020-Xpapers.pdf	58
59	post_files/59/ALGORITHM-ANALYSIS-AND-DESIGN-AAD-2020-Xpapers.pdf	59
60	post_files/60/ARTIFICIAL-INTELLIGENCE-AI-2020-Xpapers.pdf	60
61	post_files/61/ARTIFICIAL-INTELLIGENCE-AI-2020-Xpapers.pdf	61
62	post_files/62/COMPILER-DESIGN-CD-2020-Xpapers.pdf	62
63	post_files/63/COMPILER-DESIGN-CD-2020-Xpapers.pdf	63
64	post_files/64/COMPUTER-ARCHITECTURE-CA-2020-Xpapers.pdf	64
65	post_files/65/COMPUTER-ARCHITECTURE-CA-2020-Xpapers.pdf	65
66	post_files/66/COMPUTER-ARCHITECTURE-CA-2020-Xpapers.pdf	66
67	post_files/67/COMPUTER-GRAPHICS-CG-2020-Xpapers.pdf	67
68	post_files/68/COMPUTER-GRAPHICS-CG-2020-Xpapers.pdf	68
69	post_files/69/COMPUTER-NETWORKS-CN-2020-Xpapers.pdf	69
70	post_files/70/COMPUTER-PERIPHERAL-AND-INTERFACE-CPI-2020-Xpapers.pdf	70
71	post_files/71/COMPUTER-PERIPHERAL-AND-INTERFACE-CPI-2020-Xpapers.pdf	71
72	post_files/72/DATA-MINING--WAREHOUSE-DMW-2020-Xpapers.pdf	72
73	post_files/73/DATA-STRUCTURES-DS-2020-Xpapers.pdf	73
74	post_files/74/DATABASE-MANAGEMENT-SYSTEM-DBMS-2020-Xpapers.pdf	74
75	post_files/75/DIGITAL-ELECTRONIC-CIRCUITS-DEC-2020-Xpapers.pdf	75
76	post_files/76/DIGITAL-ELECTRONIC-CIRCUITS-DEC-2020-Xpapers.pdf	76
77	post_files/77/DISCRETE-MATHEMATICAL-STRUCTURE-DMATH-2020-Xpapers.pdf	77
78	post_files/78/DISTRIBUTED-COMPUTING-DC-2020-Xpapers.pdf	78
79	post_files/79/DISTRIBUTED-COMPUTING-DC-2020-Xpapers.pdf	79
80	post_files/80/ENVIRONMENT-AND-ROAD-SAFETY-AWARENESS-2020-Xpapers.pdf	80
81	post_files/81/GRID-COMPUTING-GC-2020-Xpapers.pdf	81
82	post_files/82/GRID-COMPUTING-GC-2020-Xpapers.pdf	82
83	post_files/83/INTERNET-AND-WEB-TECHNOLOGIES-IWT-2020-Xpapers.pdf	83
84	post_files/84/JAVA-PROGRAMMING-2020-Xpapers.pdf	84
85	post_files/85/JAVA-PROGRAMMING-2020-Xpapers.pdf	85
86	post_files/86/MANAGEMENT-PRACTICE-AND-ORGANIZATION-BEHAVIOUR-MPOB-2020-Xpapers.pdf	86
87	post_files/87/MANAGEMENT-PRACTICE-AND-ORGANIZATION-BEHAVIOUR-MPOB-2020-Xpapers.pdf	87
88	post_files/88/MICROPROCESSOR-AND-ASSEMBLY-LANGUAGE-PROG-2020-Xpapers.pdf	88
89	post_files/89/MICROPROCESSOR-AND-ASSEMBLY-LANGUAGE-PROG-2020-Xpapers.pdf	89
90	post_files/90/NETWORK-SECURITY-NS-2020-Xpapers.pdf	90
91	post_files/91/NETWORK-SECURITY-NS-2020-Xpapers.pdf	91
92	post_files/92/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	92
93	post_files/93/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	93
94	post_files/94/OBJECT-ORIENTED-ANALYSIS-AND-DESIGN-USING-UML-OOAD-2020-Xpapers.pdf	94
95	post_files/95/OBJECT-ORIENTED-ANALYSIS-AND-DESIGN-USING-UML-OOAD-2020-Xpapers.pdf	95
96	post_files/96/OBJECT-ORIENTED-PROGRAMMING-USING-C-OOPS-2020-Xpapers.pdf	96
97	post_files/97/OBJECT-ORIENTED-PROGRAMMING-USING-C-OOPS-2020-Xpapers.pdf	97
98	post_files/98/OPERATING-SYSTEMS-OS-2020-Xpapers.pdf	98
99	post_files/99/OPERATING-SYSTEMS-OS-2020-Xpapers.pdf	99
100	post_files/100/OPERATING-SYSTEMS-OS-2020-Xpapers.pdf	100
101	post_files/101/RELATIONAL-DATABASE-MANAGEMENT-SYSTEM-RDBMS-2020-Xpapers.pdf	101
102	post_files/102/RELATIONAL-DATABASE-MANAGEMENT-SYSTEM-RDBMS-2020-Xpapers.pdf	102
103	post_files/103/SOFTWARE-ENGINEERING-SE-2020-Xpapers.pdf	103
104	post_files/104/SOFTWARE-ENGINEERING-SE-2020-Xpapers.pdf	104
105	post_files/105/SOFTWARE-PROJECT-MANAGEMENT-2020-Xpapers.pdf	105
106	post_files/106/SYSTEM-ANALYSIS--DESIGN-SAD-2020-Xpapers.pdf	106
107	post_files/107/SYSTEM-ANALYSIS--DESIGN-SAD-2020-Xpapers.pdf	107
108	post_files/108/SYSTEM-MODELING--SIMULATION-SMS-2020-Xpapers.pdf	108
109	post_files/109/SYSTEM-PROGRAMMING-SPR-2020-Xpapers.pdf	109
110	post_files/110/SYSTEM-PROGRAMMING-SPR-2020-Xpapers.pdf	110
111	post_files/111/THEORY-OF-COMPUTATION-TOC-2020-Xpapers.pdf	111
112	post_files/112/THEORY-OF-COMPUTATION-TOC-2020-Xpapers.pdf	112
113	post_files/113/WIRELESS-AND-MOBILE-COMMUNICATION-2020-Xpapers.pdf	113
114	post_files/114/HEAT--MASS-TRANSFER-2020-Xpapers.pdf	114
115	post_files/115/MANAGEMENT-OF-PRODUCTION-SYSTEM-2020-Xpapers.pdf	115
116	post_files/116/REFRIGERATION--AIR-CONDITIONING-2020-Xpapers.pdf	116
117	post_files/117/BASIC-ELECTRONICS-ENGINEERING-BEE-2020-Xpaperslfw8jgui.pdf	117
118	post_files/118/DIGITAL-VLSI-DESIGN-2020-Xpapersot0mnap8.pdf	118
119	post_files/119/ELECTROMAGNETIC-FIELD-THEORY-2020-Xpapers7awycnkz.pdf	119
120	post_files/120/BUILDING-CONSTRUCTION-2020-Xpapers.pdf	120
121	post_files/121/BUILDING-CONSTRUCTION-2020-Xpapers.pdf	121
122	post_files/122/BUILDING-MATERIALS-2020-Xpapers.pdf	122
123	post_files/123/BUILDING-MATERIALS-2020-Xpapers.pdf	123
124	post_files/124/COMPUTER-PROGRAMMING-CP-2020-Xpapers.pdf	124
125	post_files/125/COMPUTER-PROGRAMMING-CP-2020-Xpapers.pdf	125
126	post_files/126/CONCRETE-STRUCTURE-DESIGN-2020-Xpapers.pdf	126
127	post_files/127/FLUID-MECHANICS-2020-Xpapers.pdf	127
128	post_files/128/HYDROLOGY--GROUNDWATER-2020-Xpapers.pdf	128
129	post_files/129/MANAGEMENT-PRACTICE-AND-ORGANIZATION-BEHAVIOUR-MPOB-2020-Xpapers.pdf	129
130	post_files/130/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	130
131	post_files/131/MANUFACTURING-PROCESSES-MP-2020-Xpapers.pdf	131
132	post_files/132/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	132
133	post_files/133/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	133
134	post_files/134/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	134
135	post_files/135/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	135
136	post_files/136/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	136
138	post_files/138/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	138
139	post_files/139/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	139
140	post_files/140/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	140
141	post_files/141/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	141
142	post_files/142/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	142
143	post_files/143/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	143
144	post_files/144/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	144
145	post_files/145/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	145
146	post_files/146/NUMERICAL-METHODS-AND-APPLICATIONS-NM-2020-Xpapers.pdf	146
147	post_files/147/OPERATION-RESEARCH-OR-2020-Xpapers.pdf	147
148	post_files/148/OPERATION-RESEARCH-OR-2020-Xpapers.pdf	148
149	post_files/149/OPERATION-RESEARCH-OR-2020-Xpapers.pdf	149
150	post_files/150/OPERATION-RESEARCH-OR-2020-Xpapers.pdf	150
151	post_files/151/PUNJABI-2020-Xpapers.pdf	151
152	post_files/152/PUNJABI-2020-Xpapers.pdf	152
153	post_files/153/ROCK-MECHANICS--ENGINEERING-GEOLOGY-2020-Xpapers.pdf	153
154	post_files/154/SOLID-MECHANICS-SM-2020-Xpapers.pdf	154
155	post_files/155/SOLID-MECHANICS-SM-2020-Xpapers.pdf	155
156	post_files/156/VISUAL-PROGRAMMING-VP-2020-Xpapers.pdf	156
157	post_files/157/VISUAL-PROGRAMMING-VP-2020-Xpapers.pdf	157
158	post_files/158/VISUAL-PROGRAMMING-VP-2020-Xpapers.pdf	158
159	post_files/159/VISUAL-PROGRAMMING-VP-2020-Xpapers.pdf	159
160	post_files/160/SURVEY-1-2020-Xpapers.pdf	160
161	post_files/161/SURVEY-1-2020-Xpapers.pdf	161
162	post_files/162/SURVEY-2-2020-Xpapers.pdf	162
\.


--
-- Data for Name: dashboard_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_subject (id, name, created, slug) FROM stdin;
55	CONCRETE STRUCTURE DESIGN (CSD)	2020-09-19 22:47:00.952854+00	concrete-structure-design-csd
56	FLUID MECHANICS	2020-09-19 22:48:30.590199+00	fluid-mechanics
57	HYDROLOGY & GROUNDWATER	2020-09-19 22:48:58.582878+00	hydrology-groundwater
58	OPERATION RESEARCH (OR)	2020-09-19 23:09:25.767584+00	operation-research-or
59	PUNJABI	2020-09-19 23:12:43.102155+00	punjabi
60	ROCK MECHANICS & ENGINEERING GEOLOGY	2020-09-19 23:13:38.627159+00	rock-mechanics-engineering-geology
61	SOLID MECHANICS (SM)	2020-09-19 23:14:30.232036+00	solid-mechanics-sm
1	APPLIED MATHEMATICS (M2)	2020-09-19 03:23:02.262774+00	applied-mathematics-m2
9	MANUFACTURING PROCESSES (MP)	2020-09-19 03:51:11.359183+00	manufacturing-processes-mp
8	MANAGEMENT OF PRODUCTION SYSTEM	2020-09-19 03:49:50.633729+00	management-of-production-system
7	COMPUTER PROGRAMMING	2020-09-19 03:46:40.19419+00	computer-programming
6	COMMUNICATION SKILLS	2020-09-19 03:42:36.325237+00	communication-skills
5	BASIC THERMODYNAMICS	2020-09-19 03:39:38.927995+00	basic-thermodynamics
4	BASIC ELECTRONICS ENGINEERING (BEE)	2020-09-19 03:34:01.139816+00	basic-electronics-engineering-bee
3	APPLIED PHYSICS 2	2020-09-19 03:29:45.128003+00	applied-physics-2
2	APPLIED PHYSICS 1	2020-09-19 03:25:01.909609+00	applied-physics-1
10	ADVANCED COMPUTER ARCHITECTURE	2020-09-19 21:14:43.064749+00	advanced-computer-architecture
11	ADVANCED DATA STRUCTURE AND APPLICATIONS	2020-09-19 21:16:46.595417+00	advanced-data-structure-and-applications
12	COMPILER DESIGN (CD)	2020-09-19 21:18:24.00089+00	compiler-design-cd
13	COMPUTER NETWORK TECHNOLOGIES	2020-09-19 21:19:57.194134+00	computer-network-technologies
14	DATA WAREHOUSING AND DATA MINING	2020-09-19 21:20:46.076753+00	data-warehousing-and-data-mining
15	NETWORK SECURITY (NS)	2020-09-19 21:21:57.961604+00	network-security-ns
16	OBJECT ORIENTED ANALYSIS AND DESIGN USING UML	2020-09-19 21:22:37.907109+00	object-oriented-analysis-and-design-using-uml
17	VLSI DESIGN	2020-09-19 21:23:34.834738+00	vlsi-design
18	ALGORITHM ANALYSIS AND DESIGN (AAD)	2020-09-19 21:26:16.182559+00	algorithm-analysis-and-design-aad
19	ARTIFICIAL INTELLIGENCE (AI)	2020-09-19 21:28:01.794384+00	artificial-intelligence-ai
20	COMPUTER ARCHITECTURE (CA)	2020-09-19 21:31:53.065392+00	computer-architecture-ca
21	COMPUTER GRAPHICS (CG)	2020-09-19 21:34:24.825125+00	computer-graphics-cg
22	COMPUTER NETWORKS (CN)	2020-09-19 21:35:48.591661+00	computer-networks-cn
23	COMPUTER PERIPHERAL AND INTERFACE (CPI)	2020-09-19 21:36:31.514635+00	computer-peripheral-and-interface-cpi
24	DATA MINING & WAREHOUSE (DMW)	2020-09-19 21:38:06.771354+00	data-mining-warehouse-dmw
25	DATA STRUCTURES (DS)	2020-09-19 21:39:09.676473+00	data-structures-ds
26	DATABASE MANAGEMENT SYSTEM (DBMS)	2020-09-19 21:39:58.229665+00	database-management-system-dbms
27	DIGITAL ELECTRONIC CIRCUITS (DEC)	2020-09-19 21:41:39.907441+00	digital-electronic-circuits-dec
28	DISCRETE MATHEMATICAL STRUCTURE (DMATH)	2020-09-19 21:43:44.484624+00	discrete-mathematical-structure-dmath
29	DISTRIBUTED COMPUTING (DC)	2020-09-19 21:44:06.904428+00	distributed-computing-dc
30	ENVIRONMENT AND ROAD SAFETY AWARENESS	2020-09-19 21:45:29.796255+00	environment-and-road-safety-awareness
31	GRID COMPUTING (GC)	2020-09-19 21:52:50.514615+00	grid-computing-gc
32	INTERNET AND WEB TECHNOLOGIES (IWT)	2020-09-19 21:54:11.654397+00	internet-and-web-technologies-iwt
33	JAVA PROGRAMMING	2020-09-19 21:55:22.585878+00	java-programming
34	MANAGEMENT PRACTICE AND ORGANIZATION BEHAVIOUR (MPOB)	2020-09-19 21:56:40.545257+00	management-practice-and-organization-behaviour-mpob
35	MICROPROCESSOR AND ASSEMBLY LANGUAGE PROG	2020-09-19 21:58:04.03514+00	microprocessor-and-assembly-language-prog
36	NUMERICAL METHODS AND APPLICATIONS (NM)	2020-09-19 22:01:10.986972+00	numerical-methods-and-applications-nm
37	OBJECT ORIENTED ANALYSIS AND DESIGN USING UML (OOAD)	2020-09-19 22:02:24.642514+00	object-oriented-analysis-and-design-using-uml-ooad
38	OBJECT ORIENTED PROGRAMMING USING C++ (OOPS)	2020-09-19 22:03:37.903299+00	object-oriented-programming-using-c-oops
39	OPERATING SYSTEMS (OS)	2020-09-19 22:04:41.622925+00	operating-systems-os
40	RELATIONAL DATABASE MANAGEMENT SYSTEM (RDBMS)	2020-09-19 22:05:53.825898+00	relational-database-management-system-rdbms
41	SOFTWARE ENGINEERING (SE)	2020-09-19 22:06:52.387194+00	software-engineering-se
42	SOFTWARE PROJECT MANAGEMENT	2020-09-19 22:07:47.109646+00	software-project-management
43	SYSTEM ANALYSIS & DESIGN (SAD)	2020-09-19 22:08:34.848879+00	system-analysis-design-sad
44	SYSTEM MODELING & SIMULATION (SMS)	2020-09-19 22:09:29.82702+00	system-modeling-simulation-sms
45	SYSTEM PROGRAMMING (SPR)	2020-09-19 22:10:03.989353+00	system-programming-spr
46	THEORY OF COMPUTATION (TOC)	2020-09-19 22:11:16.088554+00	theory-of-computation-toc
47	WIRELESS AND MOBILE COMMUNICATION	2020-09-19 22:15:31.50018+00	wireless-and-mobile-communication
48	HEAT & MASS TRANSFER	2020-09-19 22:18:33.314104+00	heat-mass-transfer
49	REFRIGERATION & AIR CONDITIONING	2020-09-19 22:19:58.262815+00	refrigeration-air-conditioning
50	DIGITAL VLSI DESIGN	2020-09-19 22:41:33.82118+00	digital-vlsi-design
51	ELECTROMAGNETIC FIELD THEORY	2020-09-19 22:41:58.13088+00	electromagnetic-field-theory
52	BUILDING CONSTRUCTION	2020-09-19 22:43:29.765361+00	building-construction
53	BUILDING MATERIALS	2020-09-19 22:44:26.916743+00	building-materials
54	COMPUTER PROGRAMMING (CP)	2020-09-19 22:46:04.693788+00	computer-programming-cp
62	VISUAL PROGRAMMING (VP)	2020-09-19 23:16:25.135841+00	visual-programming-vp
63	SURVEY 1	2020-09-19 23:18:46.851792+00	survey-1
64	SURVEY 2	2020-09-19 23:19:24.051657+00	survey-2
\.


--
-- Data for Name: dashboard_subject_branches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_subject_branches (id, subject_id, branch_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
10	1	2
11	2	2
12	3	2
13	4	2
14	5	2
15	6	2
16	7	2
17	8	2
18	9	2
19	1	3
20	1	4
21	9	3
22	9	4
23	8	3
24	8	4
25	7	3
26	7	4
27	6	3
28	6	4
29	5	3
30	5	4
31	4	3
32	4	4
33	3	3
34	3	4
35	2	3
36	2	4
37	10	1
38	11	1
39	12	1
40	13	1
41	14	1
42	15	1
43	16	1
44	17	1
45	18	1
46	19	1
47	20	1
48	21	1
49	22	1
50	23	1
51	24	1
52	25	1
53	26	1
54	27	1
55	28	1
56	29	1
57	30	1
58	31	1
59	32	1
60	33	1
61	34	1
62	35	1
63	36	1
64	37	1
65	38	1
66	39	1
67	40	1
68	41	1
69	42	1
70	43	1
71	44	1
72	45	1
73	46	1
74	47	1
75	48	4
76	49	4
77	50	3
78	51	3
79	52	2
80	53	2
81	54	2
82	55	2
83	56	2
84	57	2
85	34	2
86	36	2
87	36	3
88	36	4
89	58	2
90	58	4
91	59	1
92	59	2
93	60	2
94	61	2
95	62	1
96	62	2
97	63	2
98	64	2
\.


--
-- Data for Name: dashboard_subject_courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_subject_courses (id, subject_id, course_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
10	10	2
11	11	2
12	12	2
13	13	2
14	14	2
15	15	2
16	16	2
17	17	2
18	18	1
19	19	1
20	12	1
21	20	1
22	21	1
23	22	1
24	23	1
25	24	1
26	25	1
27	26	1
28	27	1
29	28	1
30	29	1
31	30	1
32	31	1
33	32	1
34	33	1
35	34	1
36	35	1
37	15	1
38	36	1
39	37	1
40	38	1
41	39	1
42	40	1
43	41	1
44	42	1
45	43	1
46	44	1
47	45	1
48	46	1
49	47	1
50	48	1
51	49	1
52	50	1
53	51	1
54	52	1
55	53	1
56	54	1
57	55	1
58	56	1
59	57	1
60	58	1
61	59	1
62	60	1
63	61	1
64	62	1
65	63	1
66	64	1
\.


--
-- Data for Name: dashboard_subject_universities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_subject_universities (id, subject_id, university_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
10	10	1
11	11	1
12	12	1
13	13	1
14	14	1
15	15	1
16	16	1
17	17	1
18	18	1
19	19	1
20	20	1
21	21	1
22	22	1
23	23	1
24	24	1
25	25	1
26	26	1
27	27	1
28	28	1
29	29	1
30	30	1
31	31	1
32	32	1
33	33	1
34	34	1
35	35	1
36	36	1
37	37	1
38	38	1
39	39	1
40	40	1
41	41	1
42	42	1
43	43	1
44	44	1
45	45	1
46	46	1
47	47	1
48	48	1
49	49	1
50	50	1
51	51	1
52	52	1
53	53	1
54	54	1
55	55	1
56	56	1
57	57	1
58	58	1
59	59	1
60	60	1
61	61	1
62	62	1
63	63	1
64	64	1
\.


--
-- Data for Name: dashboard_university; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_university (id, name, created, thumbnail, slug) FROM stdin;
1	PUNJABI UNIVERSITY	2020-09-19 03:23:02.255051+00		punjabi-university
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-09-19 16:50:03.59016+00	15	15	2	[{"changed": {"fields": ["collage"]}}]	10	1
2	2020-09-19 20:55:15.230696+00	2	2	2	[{"changed": {"fields": ["branches"]}}]	12	1
3	2020-09-19 20:55:30.977027+00	3	3	2	[{"changed": {"fields": ["branches"]}}]	12	1
4	2020-09-19 20:55:35.393275+00	4	4	2	[{"changed": {"fields": ["branches"]}}]	12	1
5	2020-09-19 20:55:39.822139+00	5	5	2	[{"changed": {"fields": ["branches"]}}]	12	1
6	2020-09-19 20:55:45.627078+00	6	6	2	[{"changed": {"fields": ["branches"]}}]	12	1
7	2020-09-19 20:55:49.539199+00	7	7	2	[{"changed": {"fields": ["branches"]}}]	12	1
8	2020-09-19 20:55:53.864515+00	8	8	2	[{"changed": {"fields": ["branches"]}}]	12	1
9	2020-09-19 20:55:57.349439+00	9	9	2	[{"changed": {"fields": ["branches"]}}]	12	1
10	2020-09-19 21:00:24.456942+00	3	3	1	[{"added": {}}]	7	1
11	2020-09-19 21:01:22.323818+00	4	4	1	[{"added": {}}]	7	1
12	2020-09-19 21:01:44.665043+00	1	1	2	[{"changed": {"fields": ["branches"]}}]	12	1
13	2020-09-19 21:01:56.913675+00	9	9	2	[{"changed": {"fields": ["branches"]}}]	12	1
14	2020-09-19 21:02:03.018616+00	8	8	2	[{"changed": {"fields": ["branches"]}}]	12	1
15	2020-09-19 21:02:06.62183+00	7	7	2	[{"changed": {"fields": ["branches"]}}]	12	1
16	2020-09-19 21:02:12.721271+00	6	6	2	[{"changed": {"fields": ["branches"]}}]	12	1
17	2020-09-19 21:02:16.966367+00	5	5	2	[{"changed": {"fields": ["branches"]}}]	12	1
18	2020-09-19 21:02:22.002938+00	4	4	2	[{"changed": {"fields": ["branches"]}}]	12	1
19	2020-09-19 21:02:25.972929+00	3	3	2	[{"changed": {"fields": ["branches"]}}]	12	1
20	2020-09-19 21:02:29.810292+00	2	2	2	[{"changed": {"fields": ["branches"]}}]	12	1
21	2020-09-19 21:32:58.290915+00	66	66	2	[{"changed": {"fields": ["collage", "type"]}}]	10	1
22	2020-09-19 22:47:41.08349+00	55	55	2	[{"changed": {"fields": ["name"]}}]	12	1
23	2020-09-19 22:58:50.017758+00	135	135	2	[{"changed": {"fields": ["collage", "type"]}}]	10	1
24	2020-09-19 22:58:50.295192+00	135	135	2	[]	10	1
25	2020-09-19 23:02:04.552878+00	137	137	3		10	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	authtoken	token
7	dashboard	branch
8	dashboard	collage
9	dashboard	course
10	dashboard	post
11	dashboard	university
12	dashboard	subject
13	dashboard	postfiles
14	xpauth	xpapersuser
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	xpauth	0001_initial	2020-09-19 03:19:33.991928+00
2	contenttypes	0001_initial	2020-09-19 03:19:34.010143+00
3	admin	0001_initial	2020-09-19 03:19:34.024909+00
4	admin	0002_logentry_remove_auto_add	2020-09-19 03:19:34.040253+00
5	admin	0003_logentry_add_action_flag_choices	2020-09-19 03:19:34.046399+00
6	contenttypes	0002_remove_content_type_name	2020-09-19 03:19:34.059961+00
7	auth	0001_initial	2020-09-19 03:19:34.101302+00
8	auth	0002_alter_permission_name_max_length	2020-09-19 03:19:34.13225+00
9	auth	0003_alter_user_email_max_length	2020-09-19 03:19:34.145343+00
10	auth	0004_alter_user_username_opts	2020-09-19 03:19:34.155631+00
11	auth	0005_alter_user_last_login_null	2020-09-19 03:19:34.164441+00
12	auth	0006_require_contenttypes_0002	2020-09-19 03:19:34.171166+00
13	auth	0007_alter_validators_add_error_messages	2020-09-19 03:19:34.204732+00
14	auth	0008_alter_user_username_max_length	2020-09-19 03:19:34.212453+00
15	auth	0009_alter_user_last_name_max_length	2020-09-19 03:19:34.21947+00
16	auth	0010_alter_group_name_max_length	2020-09-19 03:19:34.22633+00
17	auth	0011_update_proxy_permissions	2020-09-19 03:19:34.23568+00
18	authtoken	0001_initial	2020-09-19 03:19:34.249686+00
19	authtoken	0002_auto_20160226_1747	2020-09-19 03:19:34.288292+00
20	dashboard	0001_initial	2020-09-19 03:19:34.486502+00
21	sessions	0001_initial	2020-09-19 03:19:34.636637+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
vpt6d5zs259nv0ma5q866c1okn1nx2vv	Njc4YjBjMWI2NGVjMzg0ODI2YzdjYThiY2FiMmZlMjM0NmQyYTRkMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNjVlYzNlZDExNjY3YWJmMjExZjU2OGJlZTM3ZjE0MWU2YzQ2N2ZjIn0=	2020-10-03 03:21:10.947372+00
x9z0qemjwouf8ehcrx6fr300c50tija4	Njc4YjBjMWI2NGVjMzg0ODI2YzdjYThiY2FiMmZlMjM0NmQyYTRkMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNjVlYzNlZDExNjY3YWJmMjExZjU2OGJlZTM3ZjE0MWU2YzQ2N2ZjIn0=	2020-10-03 04:04:27.398918+00
\.


--
-- Data for Name: xpauth_xpapersuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.xpauth_xpapersuser (id, password, last_login, email, username, first_name, last_name, profile_image, is_active, is_staff, is_admin, is_email_varified, created, updated) FROM stdin;
1	pbkdf2_sha256$150000$WLitBfPQvmGW$a2YyZV9y18O5ss0ibYxbapy4BwCEN5m+eiZmP3o6STE=	2020-09-19 04:04:27.379184+00	admin@xpapers.in	admin	\N	\N		t	t	t	f	2020-09-19 03:20:53.697421+00	2020-09-19 03:20:53.699648+00
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);


--
-- Name: dashboard_branch_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_branch_courses_id_seq', 5, true);


--
-- Name: dashboard_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_branch_id_seq', 4, true);


--
-- Name: dashboard_branch_universities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_branch_universities_id_seq', 4, true);


--
-- Name: dashboard_collage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_collage_id_seq', 1, true);


--
-- Name: dashboard_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_course_id_seq', 2, true);


--
-- Name: dashboard_course_universities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_course_universities_id_seq', 2, true);


--
-- Name: dashboard_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_post_id_seq', 162, true);


--
-- Name: dashboard_postfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_postfiles_id_seq', 162, true);


--
-- Name: dashboard_subject_branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_subject_branches_id_seq', 98, true);


--
-- Name: dashboard_subject_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_subject_courses_id_seq', 66, true);


--
-- Name: dashboard_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_subject_id_seq', 64, true);


--
-- Name: dashboard_subject_universities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_subject_universities_id_seq', 64, true);


--
-- Name: dashboard_university_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_university_id_seq', 1, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 25, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 21, true);


--
-- Name: xpauth_xpapersuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.xpauth_xpapersuser_id_seq', 1, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: dashboard_branch_courses dashboard_branch_courses_branch_id_course_id_6d4f2978_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_courses
    ADD CONSTRAINT dashboard_branch_courses_branch_id_course_id_6d4f2978_uniq UNIQUE (branch_id, course_id);


--
-- Name: dashboard_branch_courses dashboard_branch_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_courses
    ADD CONSTRAINT dashboard_branch_courses_pkey PRIMARY KEY (id);


--
-- Name: dashboard_branch dashboard_branch_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch
    ADD CONSTRAINT dashboard_branch_name_key UNIQUE (name);


--
-- Name: dashboard_branch dashboard_branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch
    ADD CONSTRAINT dashboard_branch_pkey PRIMARY KEY (id);


--
-- Name: dashboard_branch_universities dashboard_branch_univers_branch_id_university_id_68efb30a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_universities
    ADD CONSTRAINT dashboard_branch_univers_branch_id_university_id_68efb30a_uniq UNIQUE (branch_id, university_id);


--
-- Name: dashboard_branch_universities dashboard_branch_universities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_universities
    ADD CONSTRAINT dashboard_branch_universities_pkey PRIMARY KEY (id);


--
-- Name: dashboard_collage dashboard_collage_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_collage
    ADD CONSTRAINT dashboard_collage_name_key UNIQUE (name);


--
-- Name: dashboard_collage dashboard_collage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_collage
    ADD CONSTRAINT dashboard_collage_pkey PRIMARY KEY (id);


--
-- Name: dashboard_course dashboard_course_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course
    ADD CONSTRAINT dashboard_course_name_key UNIQUE (name);


--
-- Name: dashboard_course dashboard_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course
    ADD CONSTRAINT dashboard_course_pkey PRIMARY KEY (id);


--
-- Name: dashboard_course_universities dashboard_course_univers_course_id_university_id_f67ffda6_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course_universities
    ADD CONSTRAINT dashboard_course_univers_course_id_university_id_f67ffda6_uniq UNIQUE (course_id, university_id);


--
-- Name: dashboard_course_universities dashboard_course_universities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course_universities
    ADD CONSTRAINT dashboard_course_universities_pkey PRIMARY KEY (id);


--
-- Name: dashboard_post dashboard_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post
    ADD CONSTRAINT dashboard_post_pkey PRIMARY KEY (id);


--
-- Name: dashboard_postfiles dashboard_postfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_postfiles
    ADD CONSTRAINT dashboard_postfiles_pkey PRIMARY KEY (id);


--
-- Name: dashboard_subject_branches dashboard_subject_branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_branches
    ADD CONSTRAINT dashboard_subject_branches_pkey PRIMARY KEY (id);


--
-- Name: dashboard_subject_branches dashboard_subject_branches_subject_id_branch_id_4c3bf4e6_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_branches
    ADD CONSTRAINT dashboard_subject_branches_subject_id_branch_id_4c3bf4e6_uniq UNIQUE (subject_id, branch_id);


--
-- Name: dashboard_subject_courses dashboard_subject_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_courses
    ADD CONSTRAINT dashboard_subject_courses_pkey PRIMARY KEY (id);


--
-- Name: dashboard_subject_courses dashboard_subject_courses_subject_id_course_id_9d1106fe_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_courses
    ADD CONSTRAINT dashboard_subject_courses_subject_id_course_id_9d1106fe_uniq UNIQUE (subject_id, course_id);


--
-- Name: dashboard_subject dashboard_subject_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject
    ADD CONSTRAINT dashboard_subject_name_key UNIQUE (name);


--
-- Name: dashboard_subject dashboard_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject
    ADD CONSTRAINT dashboard_subject_pkey PRIMARY KEY (id);


--
-- Name: dashboard_subject_universities dashboard_subject_univer_subject_id_university_id_1ecfb1c9_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_universities
    ADD CONSTRAINT dashboard_subject_univer_subject_id_university_id_1ecfb1c9_uniq UNIQUE (subject_id, university_id);


--
-- Name: dashboard_subject_universities dashboard_subject_universities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_universities
    ADD CONSTRAINT dashboard_subject_universities_pkey PRIMARY KEY (id);


--
-- Name: dashboard_university dashboard_university_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_university
    ADD CONSTRAINT dashboard_university_name_key UNIQUE (name);


--
-- Name: dashboard_university dashboard_university_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_university
    ADD CONSTRAINT dashboard_university_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: xpauth_xpapersuser xpauth_xpapersuser_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xpauth_xpapersuser
    ADD CONSTRAINT xpauth_xpapersuser_email_key UNIQUE (email);


--
-- Name: xpauth_xpapersuser xpauth_xpapersuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xpauth_xpapersuser
    ADD CONSTRAINT xpauth_xpapersuser_pkey PRIMARY KEY (id);


--
-- Name: xpauth_xpapersuser xpauth_xpapersuser_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xpauth_xpapersuser
    ADD CONSTRAINT xpauth_xpapersuser_username_key UNIQUE (username);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: dashboard_branch_courses_branch_id_4c3a6e13; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_branch_courses_branch_id_4c3a6e13 ON public.dashboard_branch_courses USING btree (branch_id);


--
-- Name: dashboard_branch_courses_course_id_54dc4df4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_branch_courses_course_id_54dc4df4 ON public.dashboard_branch_courses USING btree (course_id);


--
-- Name: dashboard_branch_name_f7fde0d1_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_branch_name_f7fde0d1_like ON public.dashboard_branch USING btree (name varchar_pattern_ops);


--
-- Name: dashboard_branch_slug_c996c734; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_branch_slug_c996c734 ON public.dashboard_branch USING btree (slug);


--
-- Name: dashboard_branch_slug_c996c734_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_branch_slug_c996c734_like ON public.dashboard_branch USING btree (slug varchar_pattern_ops);


--
-- Name: dashboard_branch_universities_branch_id_8e6c59c3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_branch_universities_branch_id_8e6c59c3 ON public.dashboard_branch_universities USING btree (branch_id);


--
-- Name: dashboard_branch_universities_university_id_bfd523e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_branch_universities_university_id_bfd523e9 ON public.dashboard_branch_universities USING btree (university_id);


--
-- Name: dashboard_collage_name_a023a61f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_collage_name_a023a61f_like ON public.dashboard_collage USING btree (name varchar_pattern_ops);


--
-- Name: dashboard_collage_slug_2500d458; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_collage_slug_2500d458 ON public.dashboard_collage USING btree (slug);


--
-- Name: dashboard_collage_slug_2500d458_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_collage_slug_2500d458_like ON public.dashboard_collage USING btree (slug varchar_pattern_ops);


--
-- Name: dashboard_collage_university_id_952e3dda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_collage_university_id_952e3dda ON public.dashboard_collage USING btree (university_id);


--
-- Name: dashboard_course_name_d3375e3e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_course_name_d3375e3e_like ON public.dashboard_course USING btree (name varchar_pattern_ops);


--
-- Name: dashboard_course_slug_8f677be8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_course_slug_8f677be8 ON public.dashboard_course USING btree (slug);


--
-- Name: dashboard_course_slug_8f677be8_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_course_slug_8f677be8_like ON public.dashboard_course USING btree (slug varchar_pattern_ops);


--
-- Name: dashboard_course_universities_course_id_aaa82d5e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_course_universities_course_id_aaa82d5e ON public.dashboard_course_universities USING btree (course_id);


--
-- Name: dashboard_course_universities_university_id_c4b93c77; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_course_universities_university_id_c4b93c77 ON public.dashboard_course_universities USING btree (university_id);


--
-- Name: dashboard_post_branch_id_bd353892; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_post_branch_id_bd353892 ON public.dashboard_post USING btree (branch_id);


--
-- Name: dashboard_post_collage_id_23739a2e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_post_collage_id_23739a2e ON public.dashboard_post USING btree (collage_id);


--
-- Name: dashboard_post_course_id_7287fa49; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_post_course_id_7287fa49 ON public.dashboard_post USING btree (course_id);


--
-- Name: dashboard_post_subject_id_cf2244d5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_post_subject_id_cf2244d5 ON public.dashboard_post USING btree (subject_id);


--
-- Name: dashboard_post_university_id_4513e199; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_post_university_id_4513e199 ON public.dashboard_post USING btree (university_id);


--
-- Name: dashboard_post_user_id_1db754c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_post_user_id_1db754c9 ON public.dashboard_post USING btree (user_id);


--
-- Name: dashboard_postfiles_post_id_8672aa94; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_postfiles_post_id_8672aa94 ON public.dashboard_postfiles USING btree (post_id);


--
-- Name: dashboard_subject_branches_branch_id_a1b5751b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_branches_branch_id_a1b5751b ON public.dashboard_subject_branches USING btree (branch_id);


--
-- Name: dashboard_subject_branches_subject_id_275adc02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_branches_subject_id_275adc02 ON public.dashboard_subject_branches USING btree (subject_id);


--
-- Name: dashboard_subject_courses_course_id_8cd8f431; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_courses_course_id_8cd8f431 ON public.dashboard_subject_courses USING btree (course_id);


--
-- Name: dashboard_subject_courses_subject_id_54a38e98; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_courses_subject_id_54a38e98 ON public.dashboard_subject_courses USING btree (subject_id);


--
-- Name: dashboard_subject_name_2f854f67_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_name_2f854f67_like ON public.dashboard_subject USING btree (name varchar_pattern_ops);


--
-- Name: dashboard_subject_slug_b2347027; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_slug_b2347027 ON public.dashboard_subject USING btree (slug);


--
-- Name: dashboard_subject_slug_b2347027_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_slug_b2347027_like ON public.dashboard_subject USING btree (slug varchar_pattern_ops);


--
-- Name: dashboard_subject_universities_subject_id_4cf9d078; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_universities_subject_id_4cf9d078 ON public.dashboard_subject_universities USING btree (subject_id);


--
-- Name: dashboard_subject_universities_university_id_100e6453; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_subject_universities_university_id_100e6453 ON public.dashboard_subject_universities USING btree (university_id);


--
-- Name: dashboard_university_name_d4d179b4_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_university_name_d4d179b4_like ON public.dashboard_university USING btree (name varchar_pattern_ops);


--
-- Name: dashboard_university_slug_d1fbe299; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_university_slug_d1fbe299 ON public.dashboard_university USING btree (slug);


--
-- Name: dashboard_university_slug_d1fbe299_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dashboard_university_slug_d1fbe299_like ON public.dashboard_university USING btree (slug varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: xpauth_xpapersuser_email_302ac0f8_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX xpauth_xpapersuser_email_302ac0f8_like ON public.xpauth_xpapersuser USING btree (email varchar_pattern_ops);


--
-- Name: xpauth_xpapersuser_username_90fec24c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX xpauth_xpapersuser_username_90fec24c_like ON public.xpauth_xpapersuser USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_xpauth_xpapersuser_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_xpauth_xpapersuser_id FOREIGN KEY (user_id) REFERENCES public.xpauth_xpapersuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_branch_courses dashboard_branch_cou_branch_id_4c3a6e13_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_courses
    ADD CONSTRAINT dashboard_branch_cou_branch_id_4c3a6e13_fk_dashboard FOREIGN KEY (branch_id) REFERENCES public.dashboard_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_branch_courses dashboard_branch_cou_course_id_54dc4df4_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_courses
    ADD CONSTRAINT dashboard_branch_cou_course_id_54dc4df4_fk_dashboard FOREIGN KEY (course_id) REFERENCES public.dashboard_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_branch_universities dashboard_branch_uni_branch_id_8e6c59c3_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_universities
    ADD CONSTRAINT dashboard_branch_uni_branch_id_8e6c59c3_fk_dashboard FOREIGN KEY (branch_id) REFERENCES public.dashboard_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_branch_universities dashboard_branch_uni_university_id_bfd523e9_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_branch_universities
    ADD CONSTRAINT dashboard_branch_uni_university_id_bfd523e9_fk_dashboard FOREIGN KEY (university_id) REFERENCES public.dashboard_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_collage dashboard_collage_university_id_952e3dda_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_collage
    ADD CONSTRAINT dashboard_collage_university_id_952e3dda_fk_dashboard FOREIGN KEY (university_id) REFERENCES public.dashboard_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_course_universities dashboard_course_uni_course_id_aaa82d5e_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course_universities
    ADD CONSTRAINT dashboard_course_uni_course_id_aaa82d5e_fk_dashboard FOREIGN KEY (course_id) REFERENCES public.dashboard_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_course_universities dashboard_course_uni_university_id_c4b93c77_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_course_universities
    ADD CONSTRAINT dashboard_course_uni_university_id_c4b93c77_fk_dashboard FOREIGN KEY (university_id) REFERENCES public.dashboard_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_post dashboard_post_branch_id_bd353892_fk_dashboard_branch_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post
    ADD CONSTRAINT dashboard_post_branch_id_bd353892_fk_dashboard_branch_id FOREIGN KEY (branch_id) REFERENCES public.dashboard_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_post dashboard_post_collage_id_23739a2e_fk_dashboard_collage_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post
    ADD CONSTRAINT dashboard_post_collage_id_23739a2e_fk_dashboard_collage_id FOREIGN KEY (collage_id) REFERENCES public.dashboard_collage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_post dashboard_post_course_id_7287fa49_fk_dashboard_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post
    ADD CONSTRAINT dashboard_post_course_id_7287fa49_fk_dashboard_course_id FOREIGN KEY (course_id) REFERENCES public.dashboard_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_post dashboard_post_subject_id_cf2244d5_fk_dashboard_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post
    ADD CONSTRAINT dashboard_post_subject_id_cf2244d5_fk_dashboard_subject_id FOREIGN KEY (subject_id) REFERENCES public.dashboard_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_post dashboard_post_university_id_4513e199_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post
    ADD CONSTRAINT dashboard_post_university_id_4513e199_fk_dashboard FOREIGN KEY (university_id) REFERENCES public.dashboard_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_post dashboard_post_user_id_1db754c9_fk_xpauth_xpapersuser_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_post
    ADD CONSTRAINT dashboard_post_user_id_1db754c9_fk_xpauth_xpapersuser_id FOREIGN KEY (user_id) REFERENCES public.xpauth_xpapersuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_postfiles dashboard_postfiles_post_id_8672aa94_fk_dashboard_post_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_postfiles
    ADD CONSTRAINT dashboard_postfiles_post_id_8672aa94_fk_dashboard_post_id FOREIGN KEY (post_id) REFERENCES public.dashboard_post(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_subject_branches dashboard_subject_br_branch_id_a1b5751b_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_branches
    ADD CONSTRAINT dashboard_subject_br_branch_id_a1b5751b_fk_dashboard FOREIGN KEY (branch_id) REFERENCES public.dashboard_branch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_subject_branches dashboard_subject_br_subject_id_275adc02_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_branches
    ADD CONSTRAINT dashboard_subject_br_subject_id_275adc02_fk_dashboard FOREIGN KEY (subject_id) REFERENCES public.dashboard_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_subject_courses dashboard_subject_co_course_id_8cd8f431_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_courses
    ADD CONSTRAINT dashboard_subject_co_course_id_8cd8f431_fk_dashboard FOREIGN KEY (course_id) REFERENCES public.dashboard_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_subject_courses dashboard_subject_co_subject_id_54a38e98_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_courses
    ADD CONSTRAINT dashboard_subject_co_subject_id_54a38e98_fk_dashboard FOREIGN KEY (subject_id) REFERENCES public.dashboard_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_subject_universities dashboard_subject_un_subject_id_4cf9d078_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_universities
    ADD CONSTRAINT dashboard_subject_un_subject_id_4cf9d078_fk_dashboard FOREIGN KEY (subject_id) REFERENCES public.dashboard_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_subject_universities dashboard_subject_un_university_id_100e6453_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_subject_universities
    ADD CONSTRAINT dashboard_subject_un_university_id_100e6453_fk_dashboard FOREIGN KEY (university_id) REFERENCES public.dashboard_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_xpauth_xpapersuser_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_xpauth_xpapersuser_id FOREIGN KEY (user_id) REFERENCES public.xpauth_xpapersuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

