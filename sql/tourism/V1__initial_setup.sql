
--
-- Tourism Database Schema Dump
--
-- Please use the script infrastructure/utils/tourism-dump-schema.sh to update this dump
--

SELECT pg_catalog.set_config('search_path', '', false);
CREATE TABLE public."AspNetRoles" (
    "Id" character varying(128) NOT NULL,
    "Name" character varying(256) NOT NULL
);
CREATE TABLE public."AspNetUserClaims" (
    "Id" integer NOT NULL,
    "ClaimType" character varying(256),
    "ClaimValue" character varying(256),
    "UserId" character varying(128) NOT NULL
);
CREATE SEQUENCE public."AspNetUserClaims_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public."AspNetUserClaims_Id_seq" OWNED BY public."AspNetUserClaims"."Id";
CREATE TABLE public."AspNetUserLogins" (
    "UserId" character varying(128) NOT NULL,
    "LoginProvider" character varying(128) NOT NULL,
    "ProviderKey" character varying(128) NOT NULL
);
CREATE TABLE public."AspNetUserRoles" (
    "UserId" character varying(128) NOT NULL,
    "RoleId" character varying(128) NOT NULL
);
CREATE TABLE public."AspNetUsers" (
    "Id" character varying(128) NOT NULL,
    "UserName" character varying(256) NOT NULL,
    "PasswordHash" character varying(256),
    "SecurityStamp" character varying(256),
    "Email" character varying(256) DEFAULT NULL::character varying,
    "EmailConfirmed" boolean DEFAULT false NOT NULL
);
CREATE TABLE public.accommodationfeatures (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.accommodationrooms (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.accommodationroomsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.accommodations (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.accommodationsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.accommodationtypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.accothemesmobiles (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.activities (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.activitiesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.activitytypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.alpinebits (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.appmessages (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.appsuggestions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.areas (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.articles (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.articlesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.articletypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.districts (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.districtsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.eventeuracnoi (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.events (
    id character varying(50) NOT NULL,
    data jsonb,
    latitude double precision,
    longitude double precision,
    begindate timestamp without time zone,
    enddate timestamp without time zone,
    nextbegindate timestamp without time zone
);
CREATE TABLE public.eventsopen (
    id character varying(50) NOT NULL,
    data jsonb,
    latitude double precision,
    longitude double precision,
    begindate timestamp without time zone,
    enddate timestamp without time zone,
    nextbegindate timestamp without time zone
);
CREATE TABLE public.eventtypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.experienceareas (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.experienceareasopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.gastronomies (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.gastronomiesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.gastronomytypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.ltstaggingtypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.marketinggroups (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.measuringpoints (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.metaregions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.metaregionsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.mobilehtmls (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.municipalities (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.municipalitiesopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.natureparks (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.odhactivitypoimetainfos (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.packages (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.pois (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.poisopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.poitypes (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.regions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.regionsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.skiareas (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.skiareasopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.skiregions (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.skiregionsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.smgpois (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.smgpoismobilefilters (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.smgpoismobiletypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.smgpoisopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.smgpoitypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.smgtags (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.suedtiroltypes (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.tripplaners (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.tutorials (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.tvs (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.tvsopen (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.userdevices (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.users (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.venues (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.venuesopen (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.venuetypes (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.webcams (
    id character varying(50) NOT NULL,
    data jsonb
);
CREATE TABLE public.webcamsopen (
    id character varying(100) NOT NULL,
    data jsonb
);
CREATE TABLE public.wines (
    id character varying(50) NOT NULL,
    data jsonb
);
ALTER TABLE ONLY public."AspNetUserClaims" ALTER COLUMN "Id" SET DEFAULT nextval('public."AspNetUserClaims_Id_seq"'::regclass);
ALTER TABLE ONLY public."AspNetRoles"
    ADD CONSTRAINT "AspNetRoles_pkey" PRIMARY KEY ("Id");
ALTER TABLE ONLY public."AspNetUserClaims"
    ADD CONSTRAINT "AspNetUserClaims_pkey" PRIMARY KEY ("Id");
ALTER TABLE ONLY public."AspNetUserLogins"
    ADD CONSTRAINT "AspNetUserLogins_pkey" PRIMARY KEY ("UserId", "LoginProvider", "ProviderKey");
ALTER TABLE ONLY public."AspNetUserRoles"
    ADD CONSTRAINT "AspNetUserRoles_pkey" PRIMARY KEY ("UserId", "RoleId");
ALTER TABLE ONLY public."AspNetUsers"
    ADD CONSTRAINT "AspNetUsers_pkey" PRIMARY KEY ("Id");
ALTER TABLE ONLY public.accommodationfeatures
    ADD CONSTRAINT accommodationfeatures_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.accommodationrooms
    ADD CONSTRAINT accommodationrooms_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.accommodationroomsopen
    ADD CONSTRAINT accommodationroomsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.accommodations
    ADD CONSTRAINT accommodations_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.accommodationsopen
    ADD CONSTRAINT accommodationsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.accommodationtypes
    ADD CONSTRAINT accommodationtypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.accothemesmobiles
    ADD CONSTRAINT accothemesmobiles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.activitiesopen
    ADD CONSTRAINT activitiesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.activitytypes
    ADD CONSTRAINT activitytypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.alpinebits
    ADD CONSTRAINT alpinebits_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.appmessages
    ADD CONSTRAINT appmessages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.appsuggestions
    ADD CONSTRAINT appsuggestions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.articlesopen
    ADD CONSTRAINT articlesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.articletypes
    ADD CONSTRAINT articletypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.districtsopen
    ADD CONSTRAINT districtsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.eventeuracnoi
    ADD CONSTRAINT eventeuracnoi_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.eventsopen
    ADD CONSTRAINT eventsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.eventtypes
    ADD CONSTRAINT eventtypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.experienceareas
    ADD CONSTRAINT experienceareas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.experienceareasopen
    ADD CONSTRAINT experienceareasopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.gastronomies
    ADD CONSTRAINT gastronomies_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.gastronomiesopen
    ADD CONSTRAINT gastronomiesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.gastronomytypes
    ADD CONSTRAINT gastronomytypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.ltstaggingtypes
    ADD CONSTRAINT ltstaggingtypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.marketinggroups
    ADD CONSTRAINT marketinggroups_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.measuringpoints
    ADD CONSTRAINT measuringpoints_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.metaregions
    ADD CONSTRAINT metaregions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.metaregionsopen
    ADD CONSTRAINT metaregionsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.mobilehtmls
    ADD CONSTRAINT mobilehtmls_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.municipalities
    ADD CONSTRAINT municipalities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.municipalitiesopen
    ADD CONSTRAINT municipalitiesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.natureparks
    ADD CONSTRAINT natureparks_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.odhactivitypoimetainfos
    ADD CONSTRAINT odhactivitypoimetainfos_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.pois
    ADD CONSTRAINT pois_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.poisopen
    ADD CONSTRAINT poisopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.poitypes
    ADD CONSTRAINT poitypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.regionsopen
    ADD CONSTRAINT regionsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.skiareas
    ADD CONSTRAINT skiareas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.skiareasopen
    ADD CONSTRAINT skiareasopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.skiregions
    ADD CONSTRAINT skiregions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.skiregionsopen
    ADD CONSTRAINT skiregionsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.smgpois
    ADD CONSTRAINT smgpois_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.smgpoismobilefilters
    ADD CONSTRAINT smgpoismobilefilters_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.smgpoismobiletypes
    ADD CONSTRAINT smgpoismobiletypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.smgpoisopen
    ADD CONSTRAINT smgpoisopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.smgpoitypes
    ADD CONSTRAINT smgpoitypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.smgtags
    ADD CONSTRAINT smgtags_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.suedtiroltypes
    ADD CONSTRAINT suedtiroltypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tripplaners
    ADD CONSTRAINT tripplaners_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tutorials
    ADD CONSTRAINT tutorials_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tvs
    ADD CONSTRAINT tvs_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tvsopen
    ADD CONSTRAINT tvsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.userdevices
    ADD CONSTRAINT userdevices_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.venuesopen
    ADD CONSTRAINT venuesopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.venuetypes
    ADD CONSTRAINT venuetypes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.webcams
    ADD CONSTRAINT webcams_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.webcamsopen
    ADD CONSTRAINT webcamsopen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.wines
    ADD CONSTRAINT wines_pkey PRIMARY KEY (id);
CREATE INDEX "IX_AspNetUserClaims_UserId" ON public."AspNetUserClaims" USING btree ("UserId");
CREATE INDEX "IX_AspNetUserLogins_UserId" ON public."AspNetUserLogins" USING btree ("UserId");
CREATE INDEX "IX_AspNetUserRoles_RoleId" ON public."AspNetUserRoles" USING btree ("RoleId");
CREATE INDEX "IX_AspNetUserRoles_UserId" ON public."AspNetUserRoles" USING btree ("UserId");
CREATE INDEX accoopenshortnamebtreeix ON public.accommodationsopen USING btree (((data ->> 'Shortname'::text)));
CREATE INDEX accoroomsa0ridbtreeix ON public.accommodationrooms USING btree (((data ->> 'A0RID'::text)));
CREATE INDEX accoroomsopena0ridbtreeix ON public.accommodationroomsopen USING btree (((data ->> 'A0RID'::text)));
CREATE INDEX accosginix ON public.accommodations USING gin (data);
CREATE INDEX accoshortnamebtreeix ON public.accommodations USING btree (((data ->> 'Shortname'::text)));
CREATE INDEX accosopenginix ON public.accommodationsopen USING gin (data);
CREATE INDEX activitiesginix ON public.activities USING gin (data);
CREATE INDEX activitiesopenginix ON public.activitiesopen USING gin (data);
CREATE INDEX articlesginix ON public.articles USING gin (data);
CREATE INDEX articlesopenginix ON public.articlesopen USING gin (data);
CREATE INDEX eventeuracnoiginix ON public.eventeuracnoi USING gin (data);
CREATE INDEX eventsginix ON public.events USING gin (data);
CREATE INDEX eventsopenginix ON public.eventsopen USING gin (data);
CREATE INDEX gastronomiesginix ON public.gastronomies USING gin (data);
CREATE INDEX gastronomiesopenginix ON public.gastronomiesopen USING gin (data);
CREATE INDEX packagesginix ON public.packages USING gin (data);
CREATE INDEX poisginix ON public.pois USING gin (data);
CREATE INDEX poisopenginix ON public.poisopen USING gin (data);
CREATE INDEX smgpoiopensginix ON public.smgpoisopen USING gin (data);
CREATE INDEX smgpoisginix ON public.smgpois USING gin (data);
CREATE INDEX smgtagsginix ON public.smgtags USING gin (data);
ALTER TABLE ONLY public."AspNetUserClaims"
    ADD CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_User_Id" FOREIGN KEY ("UserId") REFERENCES public."AspNetUsers"("Id") ON DELETE CASCADE;
ALTER TABLE ONLY public."AspNetUserLogins"
    ADD CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AspNetUsers"("Id") ON DELETE CASCADE;
ALTER TABLE ONLY public."AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."AspNetRoles"("Id") ON DELETE CASCADE;
ALTER TABLE ONLY public."AspNetUserRoles"
    ADD CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AspNetUsers"("Id") ON DELETE CASCADE;
