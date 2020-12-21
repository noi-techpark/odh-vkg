
--
-- Database Schema Dump of 'prod-postgres-tourism-2.co90ybcr8iim.eu-west-1.rds.amazonaws.com/tourism/public'
--
-- Please use the script infrastructure/utils/originaldb-dump-schema.sh to update this dump
--

SELECT pg_catalog.set_config('search_path', '${tourism_schema_vkg}', false);
CREATE TABLE accommodationfeatures (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE accommodationrooms (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE accommodationroomsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE accommodations (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE accommodationsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE accommodationtypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE accothemesmobiles (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE activities (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE activitiesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE activitytypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE alpinebits (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE appmessages (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE appsuggestions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE areas (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE articles (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE articlesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE articletypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE districts (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE districtsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE eventeuracnoi (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE events (
    id character varying(50) NOT NULL,
    data jsonb,
    latitude double precision,
    longitude double precision,
    begindate timestamp without time zone,
    enddate timestamp without time zone,
    nextbegindate timestamp without time zone
);
CREATE TABLE eventsopen (
    id character varying(50) NOT NULL,
    data jsonb,
    latitude double precision,
    longitude double precision,
    begindate timestamp without time zone,
    enddate timestamp without time zone,
    nextbegindate timestamp without time zone
);
CREATE TABLE eventtypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE experienceareas (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE experienceareasopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE gastronomies (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE gastronomiesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE gastronomytypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE ltstaggingtypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE marketinggroups (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE measuringpoints (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE metaregions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE metaregionsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE mobilehtmls (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE municipalities (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE municipalitiesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE natureparks (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE odhactivitypoimetainfos (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE packages (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE pois (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE poisopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE poitypes (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE regions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE regionsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE skiareas (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE skiareasopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE skiregions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE skiregionsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE smgpois (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE smgpoismobilefilters (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE smgpoismobiletypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE smgpoisopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE smgpoitypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE smgtags (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE suedtiroltypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE tripplaners (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE tutorials (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE tvs (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE tvsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE userdevices (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE users (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE venues (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE venuesopen (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE venuetypes (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE webcams (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE webcamsopen (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE wines (
    id character varying(50) NOT NULL,
    data jsonb
);
ALTER TABLE ONLY accommodationfeatures
    ADD CONSTRAINT accommodationfeatures_pkey PRIMARY KEY (id);
ALTER TABLE ONLY accommodationrooms
    ADD CONSTRAINT accommodationrooms_pkey PRIMARY KEY (id);
ALTER TABLE ONLY accommodationroomsopen
    ADD CONSTRAINT accommodationroomsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY accommodations
    ADD CONSTRAINT accommodations_pkey PRIMARY KEY (id);
ALTER TABLE ONLY accommodationsopen
    ADD CONSTRAINT accommodationsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY accommodationtypes
    ADD CONSTRAINT accommodationtypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY accothemesmobiles
    ADD CONSTRAINT accothemesmobiles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY activitiesopen
    ADD CONSTRAINT activitiesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY activitytypes
    ADD CONSTRAINT activitytypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY alpinebits
    ADD CONSTRAINT alpinebits_pkey PRIMARY KEY (id);
ALTER TABLE ONLY appmessages
    ADD CONSTRAINT appmessages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY appsuggestions
    ADD CONSTRAINT appsuggestions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY articlesopen
    ADD CONSTRAINT articlesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY articletypes
    ADD CONSTRAINT articletypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY districtsopen
    ADD CONSTRAINT districtsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY eventeuracnoi
    ADD CONSTRAINT eventeuracnoi_pkey PRIMARY KEY (id);
ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
ALTER TABLE ONLY eventsopen
    ADD CONSTRAINT eventsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY eventtypes
    ADD CONSTRAINT eventtypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY experienceareas
    ADD CONSTRAINT experienceareas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY experienceareasopen
    ADD CONSTRAINT experienceareasopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY gastronomies
    ADD CONSTRAINT gastronomies_pkey PRIMARY KEY (id);
ALTER TABLE ONLY gastronomiesopen
    ADD CONSTRAINT gastronomiesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY gastronomytypes
    ADD CONSTRAINT gastronomytypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY ltstaggingtypes
    ADD CONSTRAINT ltstaggingtypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY marketinggroups
    ADD CONSTRAINT marketinggroups_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measuringpoints
    ADD CONSTRAINT measuringpoints_pkey PRIMARY KEY (id);
ALTER TABLE ONLY metaregions
    ADD CONSTRAINT metaregions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY metaregionsopen
    ADD CONSTRAINT metaregionsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY mobilehtmls
    ADD CONSTRAINT mobilehtmls_pkey PRIMARY KEY (id);
ALTER TABLE ONLY municipalities
    ADD CONSTRAINT municipalities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY municipalitiesopen
    ADD CONSTRAINT municipalitiesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY natureparks
    ADD CONSTRAINT natureparks_pkey PRIMARY KEY (id);
ALTER TABLE ONLY odhactivitypoimetainfos
    ADD CONSTRAINT odhactivitypoimetainfos_pkey PRIMARY KEY (id);
ALTER TABLE ONLY packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY pois
    ADD CONSTRAINT pois_pkey PRIMARY KEY (id);
ALTER TABLE ONLY poisopen
    ADD CONSTRAINT poisopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY poitypes
    ADD CONSTRAINT poitypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY regionsopen
    ADD CONSTRAINT regionsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY skiareas
    ADD CONSTRAINT skiareas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY skiareasopen
    ADD CONSTRAINT skiareasopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY skiregions
    ADD CONSTRAINT skiregions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY skiregionsopen
    ADD CONSTRAINT skiregionsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY smgpois
    ADD CONSTRAINT smgpois_pkey PRIMARY KEY (id);
ALTER TABLE ONLY smgpoismobilefilters
    ADD CONSTRAINT smgpoismobilefilters_pkey PRIMARY KEY (id);
ALTER TABLE ONLY smgpoismobiletypes
    ADD CONSTRAINT smgpoismobiletypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY smgpoisopen
    ADD CONSTRAINT smgpoisopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY smgpoitypes
    ADD CONSTRAINT smgpoitypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY smgtags
    ADD CONSTRAINT smgtags_pkey PRIMARY KEY (id);
ALTER TABLE ONLY suedtiroltypes
    ADD CONSTRAINT suedtiroltypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY tripplaners
    ADD CONSTRAINT tripplaners_pkey PRIMARY KEY (id);
ALTER TABLE ONLY tutorials
    ADD CONSTRAINT tutorials_pkey PRIMARY KEY (id);
ALTER TABLE ONLY tvs
    ADD CONSTRAINT tvs_pkey PRIMARY KEY (id);
ALTER TABLE ONLY tvsopen
    ADD CONSTRAINT tvsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY userdevices
    ADD CONSTRAINT userdevices_pkey PRIMARY KEY (id);
ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);
ALTER TABLE ONLY venuesopen
    ADD CONSTRAINT venuesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY venuetypes
    ADD CONSTRAINT venuetypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY webcams
    ADD CONSTRAINT webcams_pkey PRIMARY KEY (id);
ALTER TABLE ONLY webcamsopen
    ADD CONSTRAINT webcamsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY wines
    ADD CONSTRAINT wines_pkey PRIMARY KEY (id);
CREATE INDEX accoopenshortnamebtreeix ON accommodationsopen USING btree (((data ->> 'Shortname'::text)));
CREATE INDEX accoroomsa0ridbtreeix ON accommodationrooms USING btree (((data ->> 'A0RID'::text)));
CREATE INDEX accoroomsopena0ridbtreeix ON accommodationroomsopen USING btree (((data ->> 'A0RID'::text)));
CREATE INDEX accosginix ON accommodations USING gin (data);
CREATE INDEX accoshortnamebtreeix ON accommodations USING btree (((data ->> 'Shortname'::text)));
CREATE INDEX accosopenginix ON accommodationsopen USING gin (data);
CREATE INDEX activitiesginix ON activities USING gin (data);
CREATE INDEX activitiesopenginix ON activitiesopen USING gin (data);
CREATE INDEX articlesginix ON articles USING gin (data);
CREATE INDEX articlesopenginix ON articlesopen USING gin (data);
CREATE INDEX eventeuracnoiginix ON eventeuracnoi USING gin (data);
CREATE INDEX eventsginix ON events USING gin (data);
CREATE INDEX eventsopenginix ON eventsopen USING gin (data);
CREATE INDEX gastronomiesginix ON gastronomies USING gin (data);
CREATE INDEX gastronomiesopenginix ON gastronomiesopen USING gin (data);
CREATE INDEX packagesginix ON packages USING gin (data);
CREATE INDEX poisginix ON pois USING gin (data);
CREATE INDEX poisopenginix ON poisopen USING gin (data);
CREATE INDEX smgpoiopensginix ON smgpoisopen USING gin (data);
CREATE INDEX smgpoisginix ON smgpois USING gin (data);
CREATE INDEX smgtagsginix ON smgtags USING gin (data);
