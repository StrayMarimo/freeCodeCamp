--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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
-- Name: constellation; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.constellation (
    constellation_id integer NOT NULL,
    name character varying(100) NOT NULL,
    is_visible_from_earth boolean NOT NULL
);


ALTER TABLE public.constellation OWNER TO freecodecamp;

--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.constellation_constellation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.constellation_constellation_id_seq OWNER TO freecodecamp;

--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.constellation_constellation_id_seq OWNED BY public.constellation.constellation_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    number_of_stars integer,
    number_of_planets integer,
    number_of_moons integer,
    description text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    planet_id integer,
    radius numeric(10,2),
    distance_from_planet numeric(10,2),
    description text NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    star_id integer,
    radius numeric(15,2),
    distance_from_star numeric(15,2),
    number_of_moons integer,
    description text NOT NULL,
    has_atmosphere boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    galaxy_id integer,
    mass numeric,
    luminosity numeric,
    description text NOT NULL,
    is_pulsar boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.star_id;


--
-- Name: constellation constellation_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation ALTER COLUMN constellation_id SET DEFAULT nextval('public.constellation_constellation_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Data for Name: constellation; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.constellation (constellation_id, name, is_visible_from_earth) FROM stdin;
1	Orion	t
2	Ursa Major	t
3	Cassiopeia	t
\.


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.galaxy (galaxy_id, name, number_of_stars, number_of_planets, number_of_moons, description) FROM stdin;
1	Milky Way	\N	8	181	The galaxy containing our Solar System.
2	Andromeda	\N	10	230	The closest spiral galaxy to the Milky Way.
3	Messier 87	\N	15	150	A supergiant elliptical galaxy in the constellation Virgo.
4	Triangulum Galaxy	\N	5	60	A smaller spiral galaxy in the constellation Triangulum.
5	Sombrero Galaxy	\N	12	80	A spiral galaxy in the constellation Virgo.
6	Whirlpool Galaxy	\N	8	50	A spiral galaxy in the constellation Canes Venatici.
\.


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.moon (moon_id, name, planet_id, radius, distance_from_planet, description) FROM stdin;
51	Moon	3	1737.40	0.38	Earth's only natural satellite.
52	Phobos	4	11.10	9376.00	One of the two moons of Mars.
53	Deimos	4	6.20	23460.00	The other moon of Mars.
54	Io	5	1821.60	421800.00	One of Jupiter's Galilean moons, known for its volcanic activity.
55	Europa	5	1560.80	671100.00	One of Jupiter's Galilean moons, believed to have a subsurface ocean.
56	Ganymede	5	2634.10	1070000.00	The largest moon in the Solar System, and Jupiter's moon.
57	Callisto	5	2410.30	1883000.00	One of Jupiter's Galilean moons, with a heavily cratered surface.
58	Titan	6	2575.00	1221870.00	Saturn's largest moon, known for its thick atmosphere and lakes of liquid methane.
59	Enceladus	6	252.10	238020.00	An icy moon of Saturn, with geysers erupting from its south pole.
60	Rhea	6	763.80	527040.00	Saturn's second-largest moon, with a heavily cratered surface.
61	Miranda	7	235.80	129780.00	A small, icy moon of Uranus, with a varied terrain including canyons.
62	Triton	8	1353.40	354760.00	Neptune's largest moon, and one of the few moons in the Solar System with a retrograde orbit.
63	Proxima b Moon	9	1200.00	0.01	Hypothetical moon orbiting Proxima Centauri b.
64	PSR B1257+12 B	12	8500.00	0.36	Hypothetical moon orbiting PSR B1257+12 A.
65	OGLE-2005-BLG-390Lc Moon	13	15000.00	0.32	Hypothetical moon orbiting OGLE-2005-BLG-390Lb.
66	TRAPPIST-1d Moon 1	14	2500.00	0.01	Hypothetical moon orbiting TRAPPIST-1d.
67	TRAPPIST-1d Moon 2	14	2800.00	0.01	Hypothetical moon orbiting TRAPPIST-1d.
68	TRAPPIST-1e Moon 1	15	2000.00	0.00	Hypothetical moon orbiting TRAPPIST-1e.
69	TRAPPIST-1e Moon 2	15	2100.00	0.00	Hypothetical moon orbiting TRAPPIST-1e.
70	TRAPPIST-1f Moon 1	15	1900.00	0.00	Hypothetical moon orbiting TRAPPIST-1f.
71	TRAPPIST-1f Moon 2	15	2200.00	0.00	Hypothetical moon orbiting TRAPPIST-1f.
\.


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.planet (planet_id, name, star_id, radius, distance_from_star, number_of_moons, description, has_atmosphere) FROM stdin;
1	Mercury	1	2439.70	57.91	0	The smallest planet in the Solar System.	f
2	Venus	1	6051.80	108.20	0	The second planet from the Sun, known for its thick atmosphere.	t
3	Earth	1	6371.00	149.60	1	Our home planet, the only one known to support life.	t
4	Mars	1	3389.50	227.90	2	The Red Planet, known for its red appearance due to iron oxide.	t
5	Jupiter	1	69911.00	778.60	79	The largest planet in the Solar System, known for its Great Red Spot.	t
6	Saturn	1	58232.00	1433.50	82	The second-largest planet, known for its prominent rings.	t
7	Uranus	1	25362.00	2872.50	27	The seventh planet from the Sun, known for its extreme axial tilt.	t
8	Neptune	1	24622.00	4495.10	14	The eighth planet from the Sun, known for its deep blue color.	t
9	Proxima b	7	6000.00	0.05	0	The closest known exoplanet to the Solar System.	t
10	HD 209458 b	8	130000.00	0.05	0	An exoplanet known for its atmosphere being detected from Earth.	t
11	Kepler-186f	9	12100.00	0.36	0	The first Earth-size planet discovered in the habitable zone of another star.	t
12	TRAPPIST-1d	10	7500.00	0.03	0	One of the seven Earth-size planets in the TRAPPIST-1 system.	t
13	PSR B1257+12 A	11	19200.00	0.19	0	One of the first extrasolar planets discovered, in a pulsar system.	t
14	OGLE-2005-BLG-390Lb	12	20800.00	2.60	0	An exoplanet discovered by microlensing.	t
15	Gliese 581g	13	22400.00	0.15	2	A potentially habitable exoplanet in the Gliese 581 system.	t
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.star (star_id, name, galaxy_id, mass, luminosity, description, is_pulsar) FROM stdin;
1	Sun	1	1989000000000000000000000000000	382800000000000000000000000	The star at the center of the Solar System.	f
2	Sirius	1	2.02	25.4	The brightest star in the night sky, in the constellation Canis Major.	f
3	Alpha Centauri	1	1.1	1.519	A triple star system closest to the Solar System.	f
4	Betelgeuse	2	11.6	126000	A red supergiant in the constellation Orion.	f
5	Vega	1	2.1	40	The brightest star in the constellation Lyra.	f
6	Polaris	1	5.4	46.0	The north star, located in the constellation Ursa Minor.	f
7	Proxima Centauri	1	0.12	0.0017	The closest known star to the Sun, part of the Alpha Centauri system.	f
8	Arcturus	2	1.08	170	The brightest star in the northern celestial hemisphere.	f
9	Antares	2	12	65	A red supergiant star in the constellation Scorpius.	f
10	Aldebaran	2	1.7	518	An orange giant star in the constellation Taurus.	f
11	Rigel	2	21	120000	A blue supergiant star in the constellation Orion.	f
12	Pollux	2	1.8	37	A red giant star in the constellation Gemini.	f
13	Deneb	2	19	196000	A blue-white supergiant star in the constellation Cygnus.	f
\.


--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.constellation_constellation_id_seq', 3, true);


--
-- Name: galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 71, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 15, true);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_id_seq', 13, true);


--
-- Name: constellation constellation_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_name_key UNIQUE (name);


--
-- Name: constellation constellation_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_pkey PRIMARY KEY (constellation_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_unique UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_unique UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_unique UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

