------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--
-- Database Schema Dump of 'test-pg-bdp.co90ybcr8iim.eu-west-1.rds.amazonaws.com/bdp/intimev2'
--
-- Created with the script infrastructure/utils/originaldb-dump-schema.sh and then manually cleaned
--
--
-- Due to floating point precision accuracy issues, this constraint might have different results on different 
-- machines, hence not applicable for logical replication
-- ALTER TABLE ONLY measurementhistory
--    ADD CONSTRAINT uc_measurementhistory_station_i__timestamp_period_double_value_ UNIQUE (station_id, type_id, "timestamp", period, double_value);
-- ALTER TABLE ONLY measurementhistory ADD CONSTRAINT uc_measurementhistory_station_id_type_id_timestamp_period UNIQUE (station_id, type_id, "timestamp", period);
--   ^-- also not possible, duplicates exist
------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

SELECT pg_catalog.set_config('search_path', 'intimev2', false);
CREATE SEQUENCE measurementhistory_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE measurementhistory (
    id bigint DEFAULT nextval('measurementhistory_seq'::regclass) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    period integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    double_value double precision NOT NULL,
    provenance_id bigint,
    station_id bigint NOT NULL,
    type_id bigint NOT NULL
);
CREATE SEQUENCE edge_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE edge (
    id bigint DEFAULT nextval('edge_seq'::regclass) NOT NULL,
    directed boolean DEFAULT true NOT NULL,
    linegeometry public.geometry(Geometry,25832),
    destination_id bigint,
    edge_data_id bigint NOT NULL,
    origin_id bigint
);
CREATE SEQUENCE measurement_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE measurement (
    id bigint DEFAULT nextval('measurement_seq'::regclass) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    period integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    double_value double precision NOT NULL,
    provenance_id bigint,
    station_id bigint NOT NULL,
    type_id bigint NOT NULL
);
CREATE SEQUENCE measurementstring_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE measurementstring (
    id bigint DEFAULT nextval('measurementstring_seq'::regclass) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    period integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    string_value character varying(255) NOT NULL,
    provenance_id bigint,
    station_id bigint NOT NULL,
    type_id bigint NOT NULL
);
CREATE SEQUENCE measurementstringhistory_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE measurementstringhistory (
    id bigint DEFAULT nextval('measurementstringhistory_seq'::regclass) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    period integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    string_value character varying(255) NOT NULL,
    provenance_id bigint,
    station_id bigint NOT NULL,
    type_id bigint NOT NULL
);
CREATE SEQUENCE metadata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE metadata (
    id bigint DEFAULT nextval('metadata_seq'::regclass) NOT NULL,
    created_on timestamp without time zone,
    json jsonb,
    station_id bigint
);
CREATE SEQUENCE station_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE station (
    id bigint DEFAULT nextval('station_seq'::regclass) NOT NULL,
    active boolean,
    available boolean,
    name character varying(255) NOT NULL,
    origin character varying(255),
    pointprojection public.geometry,
    stationcode character varying(255) NOT NULL,
    stationtype character varying(255) NOT NULL,
    meta_data_id bigint,
    parent_id bigint
);
CREATE SEQUENCE type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE type (
    id bigint DEFAULT nextval('type_seq'::regclass) NOT NULL,
    cname character varying(255) NOT NULL,
    created_on timestamp without time zone,
    cunit character varying(255),
    description character varying(255),
    rtype character varying(255),
    meta_data_id bigint
);
CREATE SEQUENCE type_metadata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE type_metadata (
    id bigint DEFAULT nextval('type_metadata_seq'::regclass) NOT NULL,
    created_on timestamp without time zone,
    json jsonb,
    type_id bigint
);

ALTER TABLE ONLY edge ADD CONSTRAINT edge_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurement ADD CONSTRAINT measurement_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurementstring ADD CONSTRAINT measurementstring_pkey PRIMARY KEY (id);
ALTER TABLE ONLY metadata ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);
ALTER TABLE ONLY station ADD CONSTRAINT station_pkey PRIMARY KEY (id);
ALTER TABLE ONLY type_metadata ADD CONSTRAINT type_metadata_pkey PRIMARY KEY (id);
ALTER TABLE ONLY type ADD CONSTRAINT type_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurementstringhistory ADD CONSTRAINT measurementstringhistory_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurementhistory ADD CONSTRAINT measurementhistory_pkey PRIMARY KEY (id);

ALTER TABLE ONLY station ADD CONSTRAINT uc_station_stationcode_stationtype UNIQUE (stationcode, stationtype);
ALTER TABLE ONLY type ADD CONSTRAINT uc_type_cname UNIQUE (cname);

ALTER TABLE ONLY measurement ADD CONSTRAINT uc_measurement_station_id_type_id_period UNIQUE (station_id, type_id, period);
CREATE INDEX idx_measurement_timestamp ON measurement USING btree ("timestamp" DESC);

CREATE INDEX idx_measurementhistory_station_id_type_id_timestamp_period ON measurementhistory USING btree (station_id, type_id, "timestamp" DESC, period);

ALTER TABLE ONLY measurementstring ADD CONSTRAINT uc_measurementstring_station_id_type_id_period UNIQUE (station_id, type_id, period);
CREATE INDEX idx_measurementstring_timestamp ON measurementstring USING btree ("timestamp" DESC);

ALTER TABLE ONLY measurementstringhistory ADD CONSTRAINT uc_measurementstringhistory_sta__timestamp_period_string_value_ UNIQUE (station_id, type_id, "timestamp", period, string_value);
CREATE INDEX idx_measurementstringhistory_st_on_id_type_id_timestamp_period_ ON measurementstringhistory USING btree (station_id, type_id, "timestamp" DESC, period);

ALTER TABLE ONLY edge ADD CONSTRAINT fk_edge_destination_id_station_pk FOREIGN KEY (destination_id) REFERENCES station(id);
ALTER TABLE ONLY edge ADD CONSTRAINT fk_edge_edge_data_id_station_pk FOREIGN KEY (edge_data_id) REFERENCES station(id);
ALTER TABLE ONLY edge ADD CONSTRAINT fk_edge_origin_id_station_pk FOREIGN KEY (origin_id) REFERENCES station(id);
ALTER TABLE ONLY measurement ADD CONSTRAINT fk_measurement_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurement ADD CONSTRAINT fk_measurement_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY measurementhistory ADD CONSTRAINT fk_measurementhistory_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurementhistory ADD CONSTRAINT fk_measurementhistory_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY measurementstring ADD CONSTRAINT fk_measurementstring_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurementstring ADD CONSTRAINT fk_measurementstring_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY measurementstringhistory ADD CONSTRAINT fk_measurementstringhistory_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurementstringhistory ADD CONSTRAINT fk_measurementstringhistory_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY metadata ADD CONSTRAINT fk_metadata_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY station ADD CONSTRAINT fk_station_meta_data_id_metadata_pk FOREIGN KEY (meta_data_id) REFERENCES metadata(id);
ALTER TABLE ONLY station ADD CONSTRAINT fk_station_parent_id_station_pk FOREIGN KEY (parent_id) REFERENCES station(id);
ALTER TABLE ONLY type ADD CONSTRAINT fk_type_meta_data_id_type_metadata_pk FOREIGN KEY (meta_data_id) REFERENCES type_metadata(id);
ALTER TABLE ONLY type_metadata ADD CONSTRAINT type_metadata_type_id_fkey FOREIGN KEY (type_id) REFERENCES type(id);
