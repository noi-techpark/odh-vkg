
--
-- Database Schema Dump of 'test-pg-bdp.co90ybcr8iim.eu-west-1.rds.amazonaws.com/bdp/intimev2'
--
-- Please use the script infrastructure/utils/originaldb-dump-schema.sh to update this dump
--

SELECT pg_catalog.set_config('search_path', '', false);
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
CREATE FUNCTION deltart(p_arr measurementhistory[], p_mints timestamp without time zone, p_maxts timestamp without time zone, p_station_id bigint, p_type_id bigint, p_period bigint, p_extkey boolean DEFAULT false, p_epsilon double precision DEFAULT 0.0) RETURNS integer[]
    LANGUAGE plpgsql
    AS $$
    declare
        ele measurementhistory;
        rec measurementhistory;
        val double precision;
        cnt bigint;
        ret int[4];
    begin
        ret[1] := 0;  -- DELete count
        ret[2] := 0;  -- upDAte count
        ret[3] := 0;  -- inseRT count
        ret[4] := coalesce(array_length(p_arr, 1),0); -- input element count, zero when null or zero length array
        if (p_extkey) then
            -- ----------------------------------------------------------------------------------------- -- 
            -- case 1/2: key = (station_id, type_id, period, double_value) -> insert or delete                  --
            -- ----------------------------------------------------------------------------------------- -- 
            create temporary table tt ( 
                timestamp  timestamp without time zone,
                double_value      double precision,
                station_id bigint,
                type_id    bigint,
                period     integer
            );
            if (array_length(p_arr, 1) > 0) then
                -- loop over array for insert and copy the array into a temporary table
                foreach ele in array p_arr loop
                    insert into tt
                        (timestamp, double_value, station_id, type_id, period) 
                        values (ele.timestamp, ele.double_value, ele.station_id, ele.type_id, ele.period); 
                    if (ele.station_id != p_station_id or ele.type_id != p_type_id or ele.period != p_period) then
                        drop table tt;
                        raise exception 'parameter inconsistency';
                    end if;
                    if (ele.timestamp not between p_mints - '1 minute'::interval and p_maxts + '1 minute'::interval) then
                        drop table tt;
                        raise exception 'timestamp inconsistency';
                    end if;
                    select count(*) into cnt from measurementhistory t1
                    where t1.timestamp  = ele.timestamp  and
                          t1.type_id    = ele.type_id    and
                          t1.period     = ele.period     and
                          t1.station_id = ele.station_id and
                          abs(t1.double_value - ele.double_value) <= p_epsilon;
                    if (cnt = 0) then 
                        insert into measurementhistory
                        (created_on, timestamp, double_value, station_id, type_id, period) 
                        values (ele.created_on, ele.timestamp, ele.double_value, ele.station_id, ele.type_id, ele.period); 
                        ret[3] := ret[3] + 1;
                    end if;
                end loop;
            end if;
            -- loop over measurementhistory for delete
            for rec in select * from measurementhistory t1
                where t1.type_id    = p_type_id    and
                      t1.period     = p_period     and
                      t1.station_id = p_station_id and
                      t1.timestamp between p_mints and p_maxts
            loop
                select count(*) into cnt from tt t1
                where t1.timestamp  = rec.timestamp  and
                      t1.type_id    = rec.type_id    and
                      t1.period     = rec.period     and
                      t1.station_id = rec.station_id and
                      abs(t1.double_value - rec.double_value) <= p_epsilon;
                if (cnt = 0) then
                    delete from measurementhistory t1
                    where t1.timestamp  = rec.timestamp  and
                          t1.type_id    = rec.type_id    and
                          t1.period     = rec.period     and
                          t1.station_id = rec.station_id;
                    ret[1] := ret[1] + 1;
                end if;
            end loop;
        else
            -- ----------------------------------------------------------------------------------------- -- 
            -- case 2/2: key = (station_id, type_id, period) -> insert, update or delete                 --
            -- ----------------------------------------------------------------------------------------- -- 
            create temporary table tt ( 
                timestamp  timestamp without time zone,
                double_value      double precision,
                station_id bigint,
                type_id    bigint,
                period     integer
            );
            if (array_length(p_arr, 1) > 0) then
                -- loop over array for insert/update and copy the array into a temporary table
                foreach ele in array p_arr loop
                    insert into tt
                        (timestamp, double_value, station_id, type_id, period) 
                        values (ele.timestamp, ele.double_value, ele.station_id, ele.type_id, ele.period); 
                    if (ele.station_id != p_station_id or ele.type_id != p_type_id or ele.period != p_period) then
                        drop table tt;
                        raise exception 'parameter inconsistency';
                    end if;
                    if (ele.timestamp not between p_mints - '1 minute'::interval and p_maxts + '1 minute'::interval) then
                        drop table tt;
                        raise exception 'timestamp inconsistency';
                    end if;
                    select double_value into val from measurementhistory t1
                    where t1.timestamp  = ele.timestamp  and
                          t1.type_id    = ele.type_id    and
                          t1.period     = ele.period     and
                          t1.station_id = ele.station_id;
                    if (not found) then 
                        insert into measurementhistory
                        (created_on, timestamp, double_value, station_id, type_id, period) 
                        values (ele.created_on, ele.timestamp, ele.double_value, ele.station_id, ele.type_id, ele.period); 
                        ret[3] := ret[3] + 1;
                    elsif (abs(val - ele.double_value) > p_epsilon) then
                        update measurementhistory t1 set double_value = ele.double_value
                        where t1.timestamp  = ele.timestamp  and
                              t1.type_id    = ele.type_id    and
                              t1.period     = ele.period     and
                              t1.station_id = ele.station_id;
                        ret[2] := ret[2] + 1;
                    end if;
                end loop;
            end if;
            -- loop over measurementhistory for delete
            for rec in select * from measurementhistory t1
                where t1.type_id    = p_type_id    and
                      t1.period     = p_period     and
                      t1.station_id = p_station_id and
                      t1.timestamp between p_mints and p_maxts
            loop
                select double_value into val from tt t1
                where t1.timestamp  = rec.timestamp  and
                      t1.type_id    = rec.type_id    and
                      t1.period     = rec.period     and
                      t1.station_id = rec.station_id;
                if (not found) then
                    delete from measurementhistory t1
                    where t1.timestamp  = rec.timestamp  and
                          t1.type_id    = rec.type_id    and
                          t1.period     = rec.period     and
                          t1.station_id = rec.station_id;
                    ret[1] := ret[1] + 1;
                end if;
            end loop;
        end if;
        drop table tt;
        return ret;
    end;
$$;
CREATE SEQUENCE bdprole_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE bdprole (
    id bigint DEFAULT nextval('bdprole_seq'::regclass) NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL,
    parent_id bigint
);
CREATE VIEW bdproles_unrolled AS
 WITH RECURSIVE roles(role, subroles) AS (
         SELECT bdprole.id,
            ARRAY[bdprole.id] AS "array"
           FROM bdprole
          WHERE (bdprole.parent_id IS NULL)
        UNION ALL
         SELECT t.id,
            (roles_1.subroles || t.id)
           FROM bdprole t,
            roles roles_1
          WHERE (t.parent_id = roles_1.role)
        )
 SELECT roles.role,
    unnest(roles.subroles) AS sr
   FROM roles;
CREATE SEQUENCE bdprules_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE bdprules (
    id bigint DEFAULT nextval('bdprules_seq'::regclass) NOT NULL,
    period integer,
    role_id bigint,
    station_id bigint,
    type_id bigint
);
CREATE VIEW bdpfilters_unrolled AS
 SELECT DISTINCT x.role,
    f.station_id,
    f.type_id,
    f.period
   FROM (bdprules f
     JOIN bdproles_unrolled x ON ((f.role_id = x.sr)))
  ORDER BY x.role;
CREATE MATERIALIZED VIEW bdppermissions AS
 WITH x AS (
         SELECT row_number() OVER (ORDER BY bdpfilters_unrolled.role) AS uuid,
            bdpfilters_unrolled.role AS role_id,
            bdpfilters_unrolled.station_id,
            bdpfilters_unrolled.type_id,
            bdpfilters_unrolled.period,
            bool_or((bdpfilters_unrolled.station_id IS NULL)) OVER (PARTITION BY bdpfilters_unrolled.role) AS e_stationid,
            bool_or((bdpfilters_unrolled.type_id IS NULL)) OVER (PARTITION BY bdpfilters_unrolled.role, bdpfilters_unrolled.station_id) AS e_typeid,
            bool_or((bdpfilters_unrolled.period IS NULL)) OVER (PARTITION BY bdpfilters_unrolled.role, bdpfilters_unrolled.station_id, bdpfilters_unrolled.type_id) AS e_period
           FROM bdpfilters_unrolled
          ORDER BY bdpfilters_unrolled.role, bdpfilters_unrolled.station_id, bdpfilters_unrolled.type_id, bdpfilters_unrolled.period
        )
 SELECT x.uuid,
    x.role_id,
    x.station_id,
    x.type_id,
    x.period
   FROM x
  WHERE (((x.station_id IS NULL) AND (x.type_id IS NULL) AND (x.period IS NULL)) OR ((x.station_id IS NOT NULL) AND (x.type_id IS NULL) AND (x.period IS NULL) AND (NOT x.e_stationid)) OR ((x.station_id IS NOT NULL) AND (x.type_id IS NOT NULL) AND (x.period IS NULL) AND (NOT x.e_stationid) AND (NOT x.e_typeid)) OR ((x.station_id IS NOT NULL) AND (x.type_id IS NULL) AND (x.period IS NOT NULL) AND (NOT x.e_stationid) AND (NOT x.e_period)) OR ((x.station_id IS NOT NULL) AND (x.type_id IS NOT NULL) AND (x.period IS NOT NULL) AND (NOT x.e_stationid) AND (NOT x.e_typeid) AND (NOT x.e_period)))
  WITH NO DATA;
CREATE SEQUENCE bdpuser_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE bdpuser (
    id bigint DEFAULT nextval('bdpuser_seq'::regclass) NOT NULL,
    email character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    password character varying(255) NOT NULL,
    token_expired boolean DEFAULT false NOT NULL
);
CREATE TABLE bdpusers_bdproles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);
CREATE TABLE classification (
    id integer NOT NULL,
    type_id integer,
    threshold character varying(512),
    min double precision,
    max double precision
);
CREATE SEQUENCE classification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE classification_id_seq OWNED BY classification.id;
CREATE TABLE copert_emisfact (
    type_id bigint NOT NULL,
    copert_parcom_id integer NOT NULL,
    v_min numeric(5,1) DEFAULT '-99.0'::numeric NOT NULL,
    v_max numeric(5,1) DEFAULT '-99.0'::numeric NOT NULL,
    coef_a real,
    coef_b real,
    coef_c real,
    coef_d real,
    coef_e real,
    id integer NOT NULL
);
CREATE SEQUENCE copert_emisfact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE copert_emisfact_id_seq OWNED BY copert_emisfact.id;
CREATE TABLE copert_parcom (
    descriz character(80) NOT NULL,
    id integer NOT NULL,
    percent real,
    id_class smallint,
    eurocl smallint
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
CREATE TABLE measurementmobile (
    id bigint,
    ts_ms timestamp without time zone,
    af_1_sccm double precision,
    af_1_valid_b boolean,
    can_acc_lat_mean_mps2 double precision,
    can_acc_lat_mps2 double precision,
    can_acc_lat_var_m2ps4 double precision,
    can_acc_long_mean_mps2 double precision,
    can_acc_long_mps2 double precision,
    can_acc_long_var_m2ps4 double precision,
    can_speed_mps double precision,
    can_valid_b boolean,
    co_1_ppm double precision,
    co_1_runtime_s integer,
    co_1_valid_b boolean,
    gps_1_alt_m double precision,
    gps_1_hdg_deg double precision,
    gps_1_lat_deg double precision,
    gps_1_long_deg double precision,
    gps_1_speed_mps double precision,
    id_driver_nr integer,
    id_runtime_s integer,
    id_status_char character varying(255),
    id_system_nr integer,
    id_vehicle_nr integer,
    id_version_char character varying(255),
    imu_acc_lat_mean_mps2 double precision,
    imu_acc_lat_mps2 double precision,
    imu_acc_lat_var_m2ps4 double precision,
    imu_acc_long_mean_mps2 double precision,
    imu_acc_long_mps2 double precision,
    imu_acc_long_var_m2ps4 double precision,
    imu_speed_mps double precision,
    imu_valid_b boolean,
    no2_1_ppb double precision,
    no2_1_runtime_s integer,
    no2_1_valid_b boolean,
    no2_2_ppb double precision,
    no2_2_runtime_s integer,
    no2_2_valid_b boolean,
    res_1_a double precision,
    res_1_runtime_s integer,
    res_1_valid_b boolean,
    res_2_a double precision,
    res_2_runtime_s integer,
    res_2_valid_b boolean,
    rh_1_pct double precision,
    rh_1_valid_b boolean,
    temp_1_c double precision,
    temp_1_valid_b boolean,
    gps_1_sat_nr integer,
    gps_1_valid_b boolean,
    gps_1_pdop_nr double precision,
    o3_1_ppb double precision,
    o3_1_runtime_s integer,
    o3_1_valid_b boolean,
    the_geom public.geometry,
    station_id bigint,
    created_on timestamp without time zone,
    "position" public.geometry,
    realtime_delay bigint,
    no2_1_microgm3_ma double precision,
    no2_1_microgm3_exp double precision
);
CREATE TABLE measurementmobilehistory (
    id bigint,
    ts_ms timestamp without time zone,
    af_1_sccm double precision,
    af_1_valid_b boolean,
    can_acc_lat_mean_mps2 double precision,
    can_acc_lat_mps2 double precision,
    can_acc_lat_var_m2ps4 double precision,
    can_acc_long_mean_mps2 double precision,
    can_acc_long_mps2 double precision,
    can_acc_long_var_m2ps4 double precision,
    can_speed_mps double precision,
    can_valid_b boolean,
    co_1_ppm double precision,
    co_1_runtime_s integer,
    co_1_valid_b boolean,
    gps_1_alt_m double precision,
    gps_1_hdg_deg double precision,
    gps_1_lat_deg double precision,
    gps_1_long_deg double precision,
    gps_1_speed_mps double precision,
    id_driver_nr integer,
    id_runtime_s integer,
    id_status_char character varying(255),
    id_system_nr integer,
    id_vehicle_nr integer,
    id_version_char character varying(255),
    imu_acc_lat_mean_mps2 double precision,
    imu_acc_lat_mps2 double precision,
    imu_acc_lat_var_m2ps4 double precision,
    imu_acc_long_mean_mps2 double precision,
    imu_acc_long_mps2 double precision,
    imu_acc_long_var_m2ps4 double precision,
    imu_speed_mps double precision,
    imu_valid_b boolean,
    no2_1_ppb double precision,
    no2_1_runtime_s integer,
    no2_1_valid_b boolean,
    no2_2_ppb double precision,
    no2_2_runtime_s integer,
    no2_2_valid_b boolean,
    res_1_a double precision,
    res_1_runtime_s integer,
    res_1_valid_b boolean,
    res_2_a double precision,
    res_2_runtime_s integer,
    res_2_valid_b boolean,
    rh_1_pct double precision,
    rh_1_valid_b boolean,
    temp_1_c double precision,
    temp_1_valid_b boolean,
    gps_1_sat_nr integer,
    gps_1_valid_b boolean,
    gps_1_pdop_nr double precision,
    o3_1_ppb double precision,
    o3_1_runtime_s integer,
    o3_1_valid_b boolean,
    station_id bigint,
    "position" public.geometry,
    created_on timestamp without time zone,
    realtime_delay bigint,
    no2_1_microgm3_ma double precision,
    no2_1_microgm3_exp double precision
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
CREATE SEQUENCE provenance_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE provenance (
    id bigint DEFAULT nextval('provenance_seq'::regclass) NOT NULL,
    data_collector character varying(255) NOT NULL,
    data_collector_version character varying(255),
    lineage character varying(255) NOT NULL,
    uuid character varying(255)
);
CREATE TABLE schemaversion (
    version character varying NOT NULL
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
ALTER TABLE ONLY classification ALTER COLUMN id SET DEFAULT nextval('classification_id_seq'::regclass);
ALTER TABLE ONLY copert_emisfact ALTER COLUMN id SET DEFAULT nextval('copert_emisfact_id_seq'::regclass);
ALTER TABLE ONLY bdprole
    ADD CONSTRAINT bdprole_pkey PRIMARY KEY (id);
ALTER TABLE ONLY bdprules
    ADD CONSTRAINT bdprules_pkey PRIMARY KEY (id);
ALTER TABLE ONLY bdpuser
    ADD CONSTRAINT bdpuser_pkey PRIMARY KEY (id);
ALTER TABLE ONLY classification
    ADD CONSTRAINT classification_pkey PRIMARY KEY (id);
ALTER TABLE ONLY copert_emisfact
    ADD CONSTRAINT copert_emisfact_pk PRIMARY KEY (id);
ALTER TABLE ONLY copert_parcom
    ADD CONSTRAINT copert_parcom_id PRIMARY KEY (id);
ALTER TABLE ONLY edge
    ADD CONSTRAINT edge_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurement
    ADD CONSTRAINT measurement_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurementhistory
    ADD CONSTRAINT measurementhistory_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurementstring
    ADD CONSTRAINT measurementstring_pkey PRIMARY KEY (id);
ALTER TABLE ONLY measurementstringhistory
    ADD CONSTRAINT measurementstringhistory_pkey PRIMARY KEY (id);
ALTER TABLE ONLY metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);
ALTER TABLE ONLY provenance
    ADD CONSTRAINT provenance_pkey PRIMARY KEY (id);
ALTER TABLE ONLY station
    ADD CONSTRAINT station_pkey PRIMARY KEY (id);
ALTER TABLE ONLY type_metadata
    ADD CONSTRAINT type_metadata_pkey PRIMARY KEY (id);
ALTER TABLE ONLY type
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);
ALTER TABLE ONLY bdprole
    ADD CONSTRAINT uc_bdprole_name UNIQUE (name);
ALTER TABLE ONLY bdpuser
    ADD CONSTRAINT uc_bdpuser_email UNIQUE (email);
ALTER TABLE ONLY measurement
    ADD CONSTRAINT uc_measurement_station_id_type_id_period UNIQUE (station_id, type_id, period);
ALTER TABLE ONLY measurementhistory
    ADD CONSTRAINT uc_measurementhistory_station_i__timestamp_period_double_value_ UNIQUE (station_id, type_id, "timestamp", period, double_value);
ALTER TABLE ONLY measurementstring
    ADD CONSTRAINT uc_measurementstring_station_id_type_id_period UNIQUE (station_id, type_id, period);
ALTER TABLE ONLY measurementstringhistory
    ADD CONSTRAINT uc_measurementstringhistory_sta__timestamp_period_string_value_ UNIQUE (station_id, type_id, "timestamp", period, string_value);
ALTER TABLE ONLY provenance
    ADD CONSTRAINT uc_provenance_lineage_data_collector_data_collector_version UNIQUE (lineage, data_collector, data_collector_version);
ALTER TABLE ONLY provenance
    ADD CONSTRAINT uc_provenance_uuid UNIQUE (uuid);
ALTER TABLE ONLY station
    ADD CONSTRAINT uc_station_stationcode_stationtype UNIQUE (stationcode, stationtype);
ALTER TABLE ONLY type
    ADD CONSTRAINT uc_type_cname UNIQUE (cname);
CREATE INDEX bdp_permissions_opendata ON bdppermissions USING btree (role_id) WHERE (role_id = 1);
CREATE INDEX idx_measurement_timestamp ON measurement USING btree ("timestamp" DESC);
CREATE INDEX idx_measurementhistory_created_on ON measurementhistory USING btree (created_on DESC);
CREATE INDEX idx_measurementhistory_station_id_type_id_timestamp_period ON measurementhistory USING btree (station_id, type_id, "timestamp" DESC, period);
CREATE INDEX idx_measurementmobilehistory_no2_1_microgm3_ma ON measurementmobilehistory USING btree (no2_1_microgm3_ma);
CREATE INDEX idx_measurementmobilehistory_no2_1_ppb ON measurementmobilehistory USING btree (no2_1_ppb);
CREATE INDEX idx_measurementmobilehistory_station_id ON measurementmobilehistory USING btree (station_id);
CREATE INDEX idx_measurementmobilehistory_ts_ms ON measurementmobilehistory USING btree (ts_ms);
CREATE INDEX idx_measurementstring_timestamp ON measurementstring USING btree ("timestamp" DESC);
CREATE INDEX idx_measurementstringhistory_created_on ON measurementstringhistory USING btree (created_on DESC);
CREATE INDEX idx_measurementstringhistory_st_on_id_type_id_timestamp_period_ ON measurementstringhistory USING btree (station_id, type_id, "timestamp" DESC, period);
CREATE INDEX idx_station_parkingstation ON station USING btree (id) WHERE ((stationtype)::text = 'ParkingStation'::text);
CREATE INDEX mviewindex ON bdppermissions USING btree (role_id);
ALTER TABLE ONLY classification
    ADD CONSTRAINT classification_type_id_fkey FOREIGN KEY (type_id) REFERENCES type(id) ON DELETE CASCADE;
ALTER TABLE ONLY copert_emisfact
    ADD CONSTRAINT copert_emisfact_fk_type FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY copert_emisfact
    ADD CONSTRAINT copert_emisfact_id FOREIGN KEY (copert_parcom_id) REFERENCES copert_parcom(id);
ALTER TABLE ONLY bdprole
    ADD CONSTRAINT fk_bdprole_parent_id_bdprole_pk FOREIGN KEY (parent_id) REFERENCES bdprole(id);
ALTER TABLE ONLY bdprules
    ADD CONSTRAINT fk_bdprules_role_id_bdprole_pk FOREIGN KEY (role_id) REFERENCES bdprole(id);
ALTER TABLE ONLY bdprules
    ADD CONSTRAINT fk_bdprules_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY bdprules
    ADD CONSTRAINT fk_bdprules_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY bdpusers_bdproles
    ADD CONSTRAINT fk_bdpusers_bdproles_role_id_bdprole_pk FOREIGN KEY (role_id) REFERENCES bdprole(id);
ALTER TABLE ONLY bdpusers_bdproles
    ADD CONSTRAINT fk_bdpusers_bdproles_user_id_bdpuser_pk FOREIGN KEY (user_id) REFERENCES bdpuser(id);
ALTER TABLE ONLY edge
    ADD CONSTRAINT fk_edge_destination_id_station_pk FOREIGN KEY (destination_id) REFERENCES station(id);
ALTER TABLE ONLY edge
    ADD CONSTRAINT fk_edge_edge_data_id_station_pk FOREIGN KEY (edge_data_id) REFERENCES station(id);
ALTER TABLE ONLY edge
    ADD CONSTRAINT fk_edge_origin_id_station_pk FOREIGN KEY (origin_id) REFERENCES station(id);
ALTER TABLE ONLY measurement
    ADD CONSTRAINT fk_measurement_provenance_id_provenance_pk FOREIGN KEY (provenance_id) REFERENCES provenance(id);
ALTER TABLE ONLY measurement
    ADD CONSTRAINT fk_measurement_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurement
    ADD CONSTRAINT fk_measurement_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY measurementhistory
    ADD CONSTRAINT fk_measurementhistory_provenance_id_provenance_pk FOREIGN KEY (provenance_id) REFERENCES provenance(id);
ALTER TABLE ONLY measurementhistory
    ADD CONSTRAINT fk_measurementhistory_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurementhistory
    ADD CONSTRAINT fk_measurementhistory_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY measurementstring
    ADD CONSTRAINT fk_measurementstring_provenance_id_provenance_pk FOREIGN KEY (provenance_id) REFERENCES provenance(id);
ALTER TABLE ONLY measurementstring
    ADD CONSTRAINT fk_measurementstring_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurementstring
    ADD CONSTRAINT fk_measurementstring_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY measurementstringhistory
    ADD CONSTRAINT fk_measurementstringhistory_provenance_id_provenance_pk FOREIGN KEY (provenance_id) REFERENCES provenance(id);
ALTER TABLE ONLY measurementstringhistory
    ADD CONSTRAINT fk_measurementstringhistory_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY measurementstringhistory
    ADD CONSTRAINT fk_measurementstringhistory_type_id_type_pk FOREIGN KEY (type_id) REFERENCES type(id);
ALTER TABLE ONLY metadata
    ADD CONSTRAINT fk_metadata_station_id_station_pk FOREIGN KEY (station_id) REFERENCES station(id);
ALTER TABLE ONLY station
    ADD CONSTRAINT fk_station_meta_data_id_metadata_pk FOREIGN KEY (meta_data_id) REFERENCES metadata(id);
ALTER TABLE ONLY station
    ADD CONSTRAINT fk_station_parent_id_station_pk FOREIGN KEY (parent_id) REFERENCES station(id);
ALTER TABLE ONLY type
    ADD CONSTRAINT fk_type_meta_data_id_type_metadata_pk FOREIGN KEY (meta_data_id) REFERENCES type_metadata(id);
ALTER TABLE ONLY type_metadata
    ADD CONSTRAINT type_metadata_type_id_fkey FOREIGN KEY (type_id) REFERENCES type(id);
