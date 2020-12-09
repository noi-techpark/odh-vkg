
ALTER SUBSCRIPTION ${subscription_name} DISABLE;


DROP TABLE IF EXISTS "v_accommodationsopen";

CREATE TABLE "v_accommodationsopen" (
"Id" varchar,
"Beds" integer,
"Units" integer,
"Active" bool,
"Gpstype" varchar,
"HasRoom" bool,
"Altitude" float,
"Latitude" float,
"TVMember" bool,
"IsCamping" bool,
"Longitude" float,
"Shortname" varchar,
"SmgActive" bool,
"AccoTypeId" varchar,
"DistrictId" varchar,
"IsBookable" bool,
"LastChange" varchar,
"FirstImport" varchar,
"GastronomyId" varchar,
"HasApartment" bool,
"IsGastronomy" bool,
"MainLanguage" varchar,
"TrustYouScore" float,
"TrustYouState" integer,
"AccoCategoryId" varchar,
"Representation" integer,
"TrustYouActive" bool,
"IsAccommodation" bool,
"TourismVereinId" varchar,
"TrustYouResults" integer,
"AltitudeUnitofMeasure" varchar,
"AccoDetail-de-Fax" varchar,
"AccoDetail-de-Vat" varchar,
"AccoDetail-de-Zip" varchar,
"AccoDetail-de-City" varchar,
"AccoDetail-de-Name" varchar,
"AccoDetail-de-Email" varchar,
"AccoDetail-de-Phone" varchar,
"AccoDetail-de-Mobile" varchar,
"AccoDetail-de-Street" varchar,
"AccoDetail-de-Website" varchar,
"AccoDetail-de-Language" varchar,
"AccoDetail-de-Lastname" varchar,
"AccoDetail-de-Longdesc" varchar,
"AccoDetail-de-Firstname" varchar,
"AccoDetail-de-Shortdesc" varchar,
"AccoDetail-de-NameAddition" varchar,
"AccoDetail-en-Fax" varchar,
"AccoDetail-en-Vat" varchar,
"AccoDetail-en-Zip" varchar,
"AccoDetail-en-City" varchar,
"AccoDetail-en-Name" varchar,
"AccoDetail-en-Email" varchar,
"AccoDetail-en-Phone" varchar,
"AccoDetail-en-Mobile" varchar,
"AccoDetail-en-Street" varchar,
"AccoDetail-en-Website" varchar,
"AccoDetail-en-Language" varchar,
"AccoDetail-en-Lastname" varchar,
"AccoDetail-en-Longdesc" varchar,
"AccoDetail-en-Firstname" varchar,
"AccoDetail-en-Shortdesc" varchar,
"AccoDetail-en-NameAddition" varchar,
"AccoDetail-it-Fax" varchar,
"AccoDetail-it-Vat" varchar,
"AccoDetail-it-Zip" varchar,
"AccoDetail-it-City" varchar,
"AccoDetail-it-Name" varchar,
"AccoDetail-it-Email" varchar,
"AccoDetail-it-Phone" varchar,
"AccoDetail-it-Mobile" varchar,
"AccoDetail-it-Street" varchar,
"AccoDetail-it-Website" varchar,
"AccoDetail-it-Language" varchar,
"AccoDetail-it-Lastname" varchar,
"AccoDetail-it-Longdesc" varchar,
"AccoDetail-it-Firstname" varchar,
"AccoDetail-it-Shortdesc" varchar,
"AccoDetail-it-NameAddition" varchar,
"LocationInfo-TvInfo-Id" varchar,
"LocationInfo-TvInfo-Name-cs" varchar,
"LocationInfo-TvInfo-Name-de" varchar,
"LocationInfo-TvInfo-Name-en" varchar,
"LocationInfo-TvInfo-Name-fr" varchar,
"LocationInfo-TvInfo-Name-it" varchar,
"LocationInfo-TvInfo-Name-nl" varchar,
"LocationInfo-TvInfo-Name-pl" varchar,
"LocationInfo-TvInfo-Name-ru" varchar,
"LocationInfo-RegionInfo-Id" varchar,
"LocationInfo-RegionInfo-Name-cs" varchar,
"LocationInfo-RegionInfo-Name-de" varchar,
"LocationInfo-RegionInfo-Name-en" varchar,
"LocationInfo-RegionInfo-Name-fr" varchar,
"LocationInfo-RegionInfo-Name-it" varchar,
"LocationInfo-RegionInfo-Name-nl" varchar,
"LocationInfo-RegionInfo-Name-pl" varchar,
"LocationInfo-RegionInfo-Name-ru" varchar,
"LocationInfo-DistrictInfo-Id" varchar,
"LocationInfo-DistrictInfo-Name-cs" varchar,
"LocationInfo-DistrictInfo-Name-de" varchar,
"LocationInfo-DistrictInfo-Name-en" varchar,
"LocationInfo-DistrictInfo-Name-fr" varchar,
"LocationInfo-DistrictInfo-Name-it" varchar,
"LocationInfo-DistrictInfo-Name-nl" varchar,
"LocationInfo-DistrictInfo-Name-pl" varchar,
"LocationInfo-DistrictInfo-Name-ru" varchar,
"LocationInfo-MunicipalityInfo-Id" varchar,
"LocationInfo-MunicipalityInfo-Name-cs" varchar,
"LocationInfo-MunicipalityInfo-Name-de" varchar,
"LocationInfo-MunicipalityInfo-Name-en" varchar,
"LocationInfo-MunicipalityInfo-Name-fr" varchar,
"LocationInfo-MunicipalityInfo-Name-it" varchar,
"LocationInfo-MunicipalityInfo-Name-nl" varchar,
"LocationInfo-MunicipalityInfo-Name-pl" varchar,
"LocationInfo-MunicipalityInfo-Name-ru" varchar,
"HgvId" varchar,
"TrustYouID" varchar
);

ALTER TABLE "v_accommodationsopen" ADD PRIMARY KEY ("Id");

DROP FUNCTION IF EXISTS v_accommodationsopen_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public.v_accommodationsopen
SELECT
CAST(NEW."data"->>'Id' As varchar) AS "Id",
CAST(NEW."data"->>'Beds' As integer) AS "Beds",
CAST(NEW."data"->>'Units' As integer) AS "Units",
CAST(NEW."data"->>'Active' As bool) AS "Active",
CAST(NEW."data"->>'Gpstype' As varchar) AS "Gpstype",
CAST(NEW."data"->>'HasRoom' As bool) AS "HasRoom",
CAST(NEW."data"->>'Altitude' As float) AS "Altitude",
CAST(NEW."data"->>'Latitude' As float) AS "Latitude",
CAST(NEW."data"->>'TVMember' As bool) AS "TVMember",
CAST(NEW."data"->>'IsCamping' As bool) AS "IsCamping",
CAST(NEW."data"->>'Longitude' As float) AS "Longitude",
CAST(NEW."data"->>'Shortname' As varchar) AS "Shortname",
CAST(NEW."data"->>'SmgActive' As bool) AS "SmgActive",
CAST(NEW."data"->>'AccoTypeId' As varchar) AS "AccoTypeId",
CAST(NEW."data"->>'DistrictId' As varchar) AS "DistrictId",
CAST(NEW."data"->>'IsBookable' As bool) AS "IsBookable",
CAST(NEW."data"->>'LastChange' As varchar) AS "LastChange",
CAST(NEW."data"->>'FirstImport' As varchar) AS "FirstImport",
CAST(NEW."data"->>'GastronomyId' As varchar) AS "GastronomyId",
CAST(NEW."data"->>'HasApartment' As bool) AS "HasApartment",
CAST(NEW."data"->>'IsGastronomy' As bool) AS "IsGastronomy",
CAST(NEW."data"->>'MainLanguage' As varchar) AS "MainLanguage",
CAST(NEW."data"->>'TrustYouScore' As float) AS "TrustYouScore",
CAST(NEW."data"->>'TrustYouState' As integer) AS "TrustYouState",
CAST(NEW."data"->>'AccoCategoryId' As varchar) AS "AccoCategoryId",
CAST(NEW."data"->>'Representation' As integer) AS "Representation",
CAST(NEW."data"->>'TrustYouActive' As bool) AS "TrustYouActive",
CAST(NEW."data"->>'IsAccommodation' As bool) AS "IsAccommodation",
CAST(NEW."data"->>'TourismVereinId' As varchar) AS "TourismVereinId",
CAST(NEW."data"->>'TrustYouResults' As integer) AS "TrustYouResults",
CAST(NEW."data"->>'AltitudeUnitofMeasure' As varchar) AS "AltitudeUnitofMeasure",
CAST(NEW."data"->'AccoDetail'->'de'->>'Fax' As varchar) AS "AccoDetail-de-Fax",
CAST(NEW."data"->'AccoDetail'->'de'->>'Vat' As varchar) AS "AccoDetail-de-Vat",
CAST(NEW."data"->'AccoDetail'->'de'->>'Zip' As varchar) AS "AccoDetail-de-Zip",
CAST(NEW."data"->'AccoDetail'->'de'->>'City' As varchar) AS "AccoDetail-de-City",
CAST(NEW."data"->'AccoDetail'->'de'->>'Name' As varchar) AS "AccoDetail-de-Name",
CAST(NEW."data"->'AccoDetail'->'de'->>'Email' As varchar) AS "AccoDetail-de-Email",
CAST(NEW."data"->'AccoDetail'->'de'->>'Phone' As varchar) AS "AccoDetail-de-Phone",
CAST(NEW."data"->'AccoDetail'->'de'->>'Mobile' As varchar) AS "AccoDetail-de-Mobile",
CAST(NEW."data"->'AccoDetail'->'de'->>'Street' As varchar) AS "AccoDetail-de-Street",
CAST(NEW."data"->'AccoDetail'->'de'->>'Website' As varchar) AS "AccoDetail-de-Website",
CAST(NEW."data"->'AccoDetail'->'de'->>'Language' As varchar) AS "AccoDetail-de-Language",
CAST(NEW."data"->'AccoDetail'->'de'->>'Lastname' As varchar) AS "AccoDetail-de-Lastname",
CAST(NEW."data"->'AccoDetail'->'de'->>'Longdesc' As varchar) AS "AccoDetail-de-Longdesc",
CAST(NEW."data"->'AccoDetail'->'de'->>'Firstname' As varchar) AS "AccoDetail-de-Firstname",
CAST(NEW."data"->'AccoDetail'->'de'->>'Shortdesc' As varchar) AS "AccoDetail-de-Shortdesc",
CAST(NEW."data"->'AccoDetail'->'de'->>'NameAddition' As varchar) AS "AccoDetail-de-NameAddition",
CAST(NEW."data"->'AccoDetail'->'en'->>'Fax' As varchar) AS "AccoDetail-en-Fax",
CAST(NEW."data"->'AccoDetail'->'en'->>'Vat' As varchar) AS "AccoDetail-en-Vat",
CAST(NEW."data"->'AccoDetail'->'en'->>'Zip' As varchar) AS "AccoDetail-en-Zip",
CAST(NEW."data"->'AccoDetail'->'en'->>'City' As varchar) AS "AccoDetail-en-City",
CAST(NEW."data"->'AccoDetail'->'en'->>'Name' As varchar) AS "AccoDetail-en-Name",
CAST(NEW."data"->'AccoDetail'->'en'->>'Email' As varchar) AS "AccoDetail-en-Email",
CAST(NEW."data"->'AccoDetail'->'en'->>'Phone' As varchar) AS "AccoDetail-en-Phone",
CAST(NEW."data"->'AccoDetail'->'en'->>'Mobile' As varchar) AS "AccoDetail-en-Mobile",
CAST(NEW."data"->'AccoDetail'->'en'->>'Street' As varchar) AS "AccoDetail-en-Street",
CAST(NEW."data"->'AccoDetail'->'en'->>'Website' As varchar) AS "AccoDetail-en-Website",
CAST(NEW."data"->'AccoDetail'->'en'->>'Language' As varchar) AS "AccoDetail-en-Language",
CAST(NEW."data"->'AccoDetail'->'en'->>'Lastname' As varchar) AS "AccoDetail-en-Lastname",
CAST(NEW."data"->'AccoDetail'->'en'->>'Longdesc' As varchar) AS "AccoDetail-en-Longdesc",
CAST(NEW."data"->'AccoDetail'->'en'->>'Firstname' As varchar) AS "AccoDetail-en-Firstname",
CAST(NEW."data"->'AccoDetail'->'en'->>'Shortdesc' As varchar) AS "AccoDetail-en-Shortdesc",
CAST(NEW."data"->'AccoDetail'->'en'->>'NameAddition' As varchar) AS "AccoDetail-en-NameAddition",
CAST(NEW."data"->'AccoDetail'->'it'->>'Fax' As varchar) AS "AccoDetail-it-Fax",
CAST(NEW."data"->'AccoDetail'->'it'->>'Vat' As varchar) AS "AccoDetail-it-Vat",
CAST(NEW."data"->'AccoDetail'->'it'->>'Zip' As varchar) AS "AccoDetail-it-Zip",
CAST(NEW."data"->'AccoDetail'->'it'->>'City' As varchar) AS "AccoDetail-it-City",
CAST(NEW."data"->'AccoDetail'->'it'->>'Name' As varchar) AS "AccoDetail-it-Name",
CAST(NEW."data"->'AccoDetail'->'it'->>'Email' As varchar) AS "AccoDetail-it-Email",
CAST(NEW."data"->'AccoDetail'->'it'->>'Phone' As varchar) AS "AccoDetail-it-Phone",
CAST(NEW."data"->'AccoDetail'->'it'->>'Mobile' As varchar) AS "AccoDetail-it-Mobile",
CAST(NEW."data"->'AccoDetail'->'it'->>'Street' As varchar) AS "AccoDetail-it-Street",
CAST(NEW."data"->'AccoDetail'->'it'->>'Website' As varchar) AS "AccoDetail-it-Website",
CAST(NEW."data"->'AccoDetail'->'it'->>'Language' As varchar) AS "AccoDetail-it-Language",
CAST(NEW."data"->'AccoDetail'->'it'->>'Lastname' As varchar) AS "AccoDetail-it-Lastname",
CAST(NEW."data"->'AccoDetail'->'it'->>'Longdesc' As varchar) AS "AccoDetail-it-Longdesc",
CAST(NEW."data"->'AccoDetail'->'it'->>'Firstname' As varchar) AS "AccoDetail-it-Firstname",
CAST(NEW."data"->'AccoDetail'->'it'->>'Shortdesc' As varchar) AS "AccoDetail-it-Shortdesc",
CAST(NEW."data"->'AccoDetail'->'it'->>'NameAddition' As varchar) AS "AccoDetail-it-NameAddition",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->>'Id' As varchar) AS "LocationInfo-TvInfo-Id",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-TvInfo-Name-cs",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'de' As varchar) AS "LocationInfo-TvInfo-Name-de",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'en' As varchar) AS "LocationInfo-TvInfo-Name-en",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-TvInfo-Name-fr",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'it' As varchar) AS "LocationInfo-TvInfo-Name-it",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-TvInfo-Name-nl",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-TvInfo-Name-pl",
CAST(NEW."data"->'LocationInfo'->'TvInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-TvInfo-Name-ru",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->>'Id' As varchar) AS "LocationInfo-RegionInfo-Id",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-RegionInfo-Name-cs",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'de' As varchar) AS "LocationInfo-RegionInfo-Name-de",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'en' As varchar) AS "LocationInfo-RegionInfo-Name-en",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-RegionInfo-Name-fr",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'it' As varchar) AS "LocationInfo-RegionInfo-Name-it",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-RegionInfo-Name-nl",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-RegionInfo-Name-pl",
CAST(NEW."data"->'LocationInfo'->'RegionInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-RegionInfo-Name-ru",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->>'Id' As varchar) AS "LocationInfo-DistrictInfo-Id",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-DistrictInfo-Name-cs",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'de' As varchar) AS "LocationInfo-DistrictInfo-Name-de",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'en' As varchar) AS "LocationInfo-DistrictInfo-Name-en",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-DistrictInfo-Name-fr",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'it' As varchar) AS "LocationInfo-DistrictInfo-Name-it",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-DistrictInfo-Name-nl",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-DistrictInfo-Name-pl",
CAST(NEW."data"->'LocationInfo'->'DistrictInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-DistrictInfo-Name-ru",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->>'Id' As varchar) AS "LocationInfo-MunicipalityInfo-Id",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-MunicipalityInfo-Name-cs",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'de' As varchar) AS "LocationInfo-MunicipalityInfo-Name-de",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'en' As varchar) AS "LocationInfo-MunicipalityInfo-Name-en",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-MunicipalityInfo-Name-fr",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'it' As varchar) AS "LocationInfo-MunicipalityInfo-Name-it",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-MunicipalityInfo-Name-nl",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-MunicipalityInfo-Name-pl",
CAST(NEW."data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-MunicipalityInfo-Name-ru",
CAST(NEW."data"->>'HgvId' As varchar) AS "HgvId",
CAST(NEW."data"->>'TrustYouID' As varchar) AS "TrustYouID";
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen;

DROP TABLE IF EXISTS "v_accommodationsopen_SmgTags";

CREATE TABLE  "v_accommodationsopen_SmgTags" (
"Id" varchar,
"data" varchar
); 

DROP FUNCTION IF EXISTS v_accommodationsopen_SmgTags_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_SmgTags_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_SmgTags"
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text(NEW."data" -> 'SmgTags') AS "data"
        WHERE NEW."data" -> 'SmgTags' != 'null';
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_SmgTags
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_SmgTags_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_SmgTags;        
 
DROP TABLE IF EXISTS "v_accommodationsopen_ThemeIds";

CREATE TABLE  "v_accommodationsopen_ThemeIds" (
"Id" varchar,
"data" varchar
); 

DROP FUNCTION IF EXISTS v_accommodationsopen_ThemeIds_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_ThemeIds_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_ThemeIds"
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text(NEW."data" -> 'ThemeIds') AS "data"
        WHERE NEW."data" -> 'ThemeIds' != 'null';
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_ThemeIds
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_ThemeIds_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_ThemeIds;        
 
DROP TABLE IF EXISTS "v_accommodationsopen_HasLanguage";

CREATE TABLE  "v_accommodationsopen_HasLanguage" (
"Id" varchar,
"data" varchar
); 

DROP FUNCTION IF EXISTS v_accommodationsopen_HasLanguage_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_HasLanguage_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_HasLanguage"
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text(NEW."data" -> 'HasLanguage') AS "data"
        WHERE NEW."data" -> 'HasLanguage' != 'null';
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_HasLanguage
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_HasLanguage_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_HasLanguage;        
 
DROP TABLE IF EXISTS "v_accommodationsopen_SpecialFeaturesIds";

CREATE TABLE  "v_accommodationsopen_SpecialFeaturesIds" (
"Id" varchar,
"data" varchar
); 

DROP FUNCTION IF EXISTS v_accommodationsopen_SpecialFeaturesIds_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_SpecialFeaturesIds_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_SpecialFeaturesIds"
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text(NEW."data" -> 'SpecialFeaturesIds') AS "data"
        WHERE NEW."data" -> 'SpecialFeaturesIds' != 'null';
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_SpecialFeaturesIds
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_SpecialFeaturesIds_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_SpecialFeaturesIds;        
 
DROP TABLE IF EXISTS "v_accommodationsopen_Features";

CREATE TABLE "v_accommodationsopen_Features" (
"accommodationsopen_Id" varchar,
"Id" varchar,
"Name" varchar,
"HgvId" varchar
);

DROP FUNCTION IF EXISTS v_accommodationsopen_Features_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_Features_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_Features"
WITH t ("Id", "data") AS (
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements(NEW."data" -> 'Features') AS "data"
        WHERE NEW."data" -> 'Features' != 'null')
    SELECT "Id" AS "accommodationsopen_Id", CAST("data"->>'Id' As varchar) AS "Id",
CAST("data"->>'Name' As varchar) AS "Name",
CAST("data"->>'HgvId' As varchar) AS "HgvId"
    FROM t;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_Features
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_Features_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_Features;        
    

DROP TABLE IF EXISTS "v_accommodationsopen_BoardIds";

CREATE TABLE  "v_accommodationsopen_BoardIds" (
"Id" varchar,
"data" varchar
); 

DROP FUNCTION IF EXISTS v_accommodationsopen_BoardIds_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_BoardIds_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_BoardIds"
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text(NEW."data" -> 'BoardIds') AS "data"
        WHERE NEW."data" -> 'BoardIds' != 'null';
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_BoardIds
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_BoardIds_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_BoardIds;        
 
DROP TABLE IF EXISTS "v_accommodationsopen_BadgeIds";

CREATE TABLE  "v_accommodationsopen_BadgeIds" (
"Id" varchar,
"data" varchar
); 

DROP FUNCTION IF EXISTS v_accommodationsopen_BadgeIds_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_BadgeIds_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_BadgeIds"
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text(NEW."data" -> 'BadgeIds') AS "data"
        WHERE NEW."data" -> 'BadgeIds' != 'null';
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_BadgeIds
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_BadgeIds_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_BadgeIds;        
 
DROP TABLE IF EXISTS "v_accommodationsopen_MarketingGroupIds";

CREATE TABLE  "v_accommodationsopen_MarketingGroupIds" (
"Id" varchar,
"data" varchar
); 

DROP FUNCTION IF EXISTS v_accommodationsopen_MarketingGroupIds_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_MarketingGroupIds_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_MarketingGroupIds"
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text(NEW."data" -> 'MarketingGroupIds') AS "data"
        WHERE NEW."data" -> 'MarketingGroupIds' != 'null';
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_MarketingGroupIds
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_MarketingGroupIds_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_MarketingGroupIds;        
 
DROP TABLE IF EXISTS "v_accommodationsopen_AccoBookingChannel";

CREATE TABLE "v_accommodationsopen_AccoBookingChannel" (
"accommodationsopen_Id" varchar,
"Id" varchar,
"Pos1ID" varchar,
"BookingId" varchar,
"Portalname" varchar
);

DROP FUNCTION IF EXISTS v_accommodationsopen_AccoBookingChannel_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_AccoBookingChannel_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_AccoBookingChannel"
WITH t ("Id", "data") AS (
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements(NEW."data" -> 'AccoBookingChannel') AS "data"
        WHERE NEW."data" -> 'AccoBookingChannel' != 'null')
    SELECT "Id" AS "accommodationsopen_Id", CAST("data"->>'Id' As varchar) AS "Id",
CAST("data"->>'Pos1ID' As varchar) AS "Pos1ID",
CAST("data"->>'BookingId' As varchar) AS "BookingId",
CAST("data"->>'Portalname' As varchar) AS "Portalname"
    FROM t;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_AccoBookingChannel
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_AccoBookingChannel_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_AccoBookingChannel;        
    

DROP TABLE IF EXISTS "v_accommodationsopen_ImageGallery";

CREATE TABLE "v_accommodationsopen_ImageGallery" (
"accommodationsopen_Id" varchar,
"Width" integer,
"Height" integer,
"License" varchar,
"ValidTo" varchar,
"ImageUrl" varchar,
"CopyRight" varchar,
"ValidFrom" varchar,
"IsInGallery" bool,
"ListPosition" integer,
"ImageDesc-de" varchar,
"ImageDesc-en" varchar,
"ImageDesc-it" varchar
);

DROP FUNCTION IF EXISTS v_accommodationsopen_ImageGallery_fn CASCADE;

CREATE FUNCTION v_accommodationsopen_ImageGallery_fn()
RETURNS TRIGGER
AS $$
BEGIN
INSERT INTO public."v_accommodationsopen_ImageGallery"
WITH t ("Id", "data") AS (
        SELECT CAST(NEW."data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements(NEW."data" -> 'ImageGallery') AS "data"
        WHERE NEW."data" -> 'ImageGallery' != 'null')
    SELECT "Id" AS "accommodationsopen_Id", CAST("data"->>'Width' As integer) AS "Width",
CAST("data"->>'Height' As integer) AS "Height",
CAST("data"->>'License' As varchar) AS "License",
CAST("data"->>'ValidTo' As varchar) AS "ValidTo",
CAST("data"->>'ImageUrl' As varchar) AS "ImageUrl",
CAST("data"->>'CopyRight' As varchar) AS "CopyRight",
CAST("data"->>'ValidFrom' As varchar) AS "ValidFrom",
CAST("data"->>'IsInGallery' As bool) AS "IsInGallery",
CAST("data"->>'ListPosition' As integer) AS "ListPosition",
CAST("data"->'ImageDesc'->>'de' As varchar) AS "ImageDesc-de",
CAST("data"->'ImageDesc'->>'en' As varchar) AS "ImageDesc-en",
CAST("data"->'ImageDesc'->>'it' As varchar) AS "ImageDesc-it"
    FROM t;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_v_accommodationsopen_ImageGallery
    BEFORE INSERT
    ON accommodationsopen
    FOR EACH ROW
    EXECUTE PROCEDURE v_accommodationsopen_ImageGallery_fn();

ALTER TABLE accommodationsopen
    ENABLE ALWAYS TRIGGER t_v_accommodationsopen_ImageGallery;        
    

INSERT INTO v_accommodationsopen
SELECT
CAST("data"->>'Id' As varchar) AS "Id",
CAST("data"->>'Beds' As integer) AS "Beds",
CAST("data"->>'Units' As integer) AS "Units",
CAST("data"->>'Active' As bool) AS "Active",
CAST("data"->>'Gpstype' As varchar) AS "Gpstype",
CAST("data"->>'HasRoom' As bool) AS "HasRoom",
CAST("data"->>'Altitude' As float) AS "Altitude",
CAST("data"->>'Latitude' As float) AS "Latitude",
CAST("data"->>'TVMember' As bool) AS "TVMember",
CAST("data"->>'IsCamping' As bool) AS "IsCamping",
CAST("data"->>'Longitude' As float) AS "Longitude",
CAST("data"->>'Shortname' As varchar) AS "Shortname",
CAST("data"->>'SmgActive' As bool) AS "SmgActive",
CAST("data"->>'AccoTypeId' As varchar) AS "AccoTypeId",
CAST("data"->>'DistrictId' As varchar) AS "DistrictId",
CAST("data"->>'IsBookable' As bool) AS "IsBookable",
CAST("data"->>'LastChange' As varchar) AS "LastChange",
CAST("data"->>'FirstImport' As varchar) AS "FirstImport",
CAST("data"->>'GastronomyId' As varchar) AS "GastronomyId",
CAST("data"->>'HasApartment' As bool) AS "HasApartment",
CAST("data"->>'IsGastronomy' As bool) AS "IsGastronomy",
CAST("data"->>'MainLanguage' As varchar) AS "MainLanguage",
CAST("data"->>'TrustYouScore' As float) AS "TrustYouScore",
CAST("data"->>'TrustYouState' As integer) AS "TrustYouState",
CAST("data"->>'AccoCategoryId' As varchar) AS "AccoCategoryId",
CAST("data"->>'Representation' As integer) AS "Representation",
CAST("data"->>'TrustYouActive' As bool) AS "TrustYouActive",
CAST("data"->>'IsAccommodation' As bool) AS "IsAccommodation",
CAST("data"->>'TourismVereinId' As varchar) AS "TourismVereinId",
CAST("data"->>'TrustYouResults' As integer) AS "TrustYouResults",
CAST("data"->>'AltitudeUnitofMeasure' As varchar) AS "AltitudeUnitofMeasure",
CAST("data"->'AccoDetail'->'de'->>'Fax' As varchar) AS "AccoDetail-de-Fax",
CAST("data"->'AccoDetail'->'de'->>'Vat' As varchar) AS "AccoDetail-de-Vat",
CAST("data"->'AccoDetail'->'de'->>'Zip' As varchar) AS "AccoDetail-de-Zip",
CAST("data"->'AccoDetail'->'de'->>'City' As varchar) AS "AccoDetail-de-City",
CAST("data"->'AccoDetail'->'de'->>'Name' As varchar) AS "AccoDetail-de-Name",
CAST("data"->'AccoDetail'->'de'->>'Email' As varchar) AS "AccoDetail-de-Email",
CAST("data"->'AccoDetail'->'de'->>'Phone' As varchar) AS "AccoDetail-de-Phone",
CAST("data"->'AccoDetail'->'de'->>'Mobile' As varchar) AS "AccoDetail-de-Mobile",
CAST("data"->'AccoDetail'->'de'->>'Street' As varchar) AS "AccoDetail-de-Street",
CAST("data"->'AccoDetail'->'de'->>'Website' As varchar) AS "AccoDetail-de-Website",
CAST("data"->'AccoDetail'->'de'->>'Language' As varchar) AS "AccoDetail-de-Language",
CAST("data"->'AccoDetail'->'de'->>'Lastname' As varchar) AS "AccoDetail-de-Lastname",
CAST("data"->'AccoDetail'->'de'->>'Longdesc' As varchar) AS "AccoDetail-de-Longdesc",
CAST("data"->'AccoDetail'->'de'->>'Firstname' As varchar) AS "AccoDetail-de-Firstname",
CAST("data"->'AccoDetail'->'de'->>'Shortdesc' As varchar) AS "AccoDetail-de-Shortdesc",
CAST("data"->'AccoDetail'->'de'->>'NameAddition' As varchar) AS "AccoDetail-de-NameAddition",
CAST("data"->'AccoDetail'->'en'->>'Fax' As varchar) AS "AccoDetail-en-Fax",
CAST("data"->'AccoDetail'->'en'->>'Vat' As varchar) AS "AccoDetail-en-Vat",
CAST("data"->'AccoDetail'->'en'->>'Zip' As varchar) AS "AccoDetail-en-Zip",
CAST("data"->'AccoDetail'->'en'->>'City' As varchar) AS "AccoDetail-en-City",
CAST("data"->'AccoDetail'->'en'->>'Name' As varchar) AS "AccoDetail-en-Name",
CAST("data"->'AccoDetail'->'en'->>'Email' As varchar) AS "AccoDetail-en-Email",
CAST("data"->'AccoDetail'->'en'->>'Phone' As varchar) AS "AccoDetail-en-Phone",
CAST("data"->'AccoDetail'->'en'->>'Mobile' As varchar) AS "AccoDetail-en-Mobile",
CAST("data"->'AccoDetail'->'en'->>'Street' As varchar) AS "AccoDetail-en-Street",
CAST("data"->'AccoDetail'->'en'->>'Website' As varchar) AS "AccoDetail-en-Website",
CAST("data"->'AccoDetail'->'en'->>'Language' As varchar) AS "AccoDetail-en-Language",
CAST("data"->'AccoDetail'->'en'->>'Lastname' As varchar) AS "AccoDetail-en-Lastname",
CAST("data"->'AccoDetail'->'en'->>'Longdesc' As varchar) AS "AccoDetail-en-Longdesc",
CAST("data"->'AccoDetail'->'en'->>'Firstname' As varchar) AS "AccoDetail-en-Firstname",
CAST("data"->'AccoDetail'->'en'->>'Shortdesc' As varchar) AS "AccoDetail-en-Shortdesc",
CAST("data"->'AccoDetail'->'en'->>'NameAddition' As varchar) AS "AccoDetail-en-NameAddition",
CAST("data"->'AccoDetail'->'it'->>'Fax' As varchar) AS "AccoDetail-it-Fax",
CAST("data"->'AccoDetail'->'it'->>'Vat' As varchar) AS "AccoDetail-it-Vat",
CAST("data"->'AccoDetail'->'it'->>'Zip' As varchar) AS "AccoDetail-it-Zip",
CAST("data"->'AccoDetail'->'it'->>'City' As varchar) AS "AccoDetail-it-City",
CAST("data"->'AccoDetail'->'it'->>'Name' As varchar) AS "AccoDetail-it-Name",
CAST("data"->'AccoDetail'->'it'->>'Email' As varchar) AS "AccoDetail-it-Email",
CAST("data"->'AccoDetail'->'it'->>'Phone' As varchar) AS "AccoDetail-it-Phone",
CAST("data"->'AccoDetail'->'it'->>'Mobile' As varchar) AS "AccoDetail-it-Mobile",
CAST("data"->'AccoDetail'->'it'->>'Street' As varchar) AS "AccoDetail-it-Street",
CAST("data"->'AccoDetail'->'it'->>'Website' As varchar) AS "AccoDetail-it-Website",
CAST("data"->'AccoDetail'->'it'->>'Language' As varchar) AS "AccoDetail-it-Language",
CAST("data"->'AccoDetail'->'it'->>'Lastname' As varchar) AS "AccoDetail-it-Lastname",
CAST("data"->'AccoDetail'->'it'->>'Longdesc' As varchar) AS "AccoDetail-it-Longdesc",
CAST("data"->'AccoDetail'->'it'->>'Firstname' As varchar) AS "AccoDetail-it-Firstname",
CAST("data"->'AccoDetail'->'it'->>'Shortdesc' As varchar) AS "AccoDetail-it-Shortdesc",
CAST("data"->'AccoDetail'->'it'->>'NameAddition' As varchar) AS "AccoDetail-it-NameAddition",
CAST("data"->'LocationInfo'->'TvInfo'->>'Id' As varchar) AS "LocationInfo-TvInfo-Id",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-TvInfo-Name-cs",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'de' As varchar) AS "LocationInfo-TvInfo-Name-de",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'en' As varchar) AS "LocationInfo-TvInfo-Name-en",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-TvInfo-Name-fr",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'it' As varchar) AS "LocationInfo-TvInfo-Name-it",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-TvInfo-Name-nl",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-TvInfo-Name-pl",
CAST("data"->'LocationInfo'->'TvInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-TvInfo-Name-ru",
CAST("data"->'LocationInfo'->'RegionInfo'->>'Id' As varchar) AS "LocationInfo-RegionInfo-Id",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-RegionInfo-Name-cs",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'de' As varchar) AS "LocationInfo-RegionInfo-Name-de",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'en' As varchar) AS "LocationInfo-RegionInfo-Name-en",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-RegionInfo-Name-fr",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'it' As varchar) AS "LocationInfo-RegionInfo-Name-it",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-RegionInfo-Name-nl",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-RegionInfo-Name-pl",
CAST("data"->'LocationInfo'->'RegionInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-RegionInfo-Name-ru",
CAST("data"->'LocationInfo'->'DistrictInfo'->>'Id' As varchar) AS "LocationInfo-DistrictInfo-Id",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-DistrictInfo-Name-cs",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'de' As varchar) AS "LocationInfo-DistrictInfo-Name-de",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'en' As varchar) AS "LocationInfo-DistrictInfo-Name-en",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-DistrictInfo-Name-fr",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'it' As varchar) AS "LocationInfo-DistrictInfo-Name-it",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-DistrictInfo-Name-nl",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-DistrictInfo-Name-pl",
CAST("data"->'LocationInfo'->'DistrictInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-DistrictInfo-Name-ru",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->>'Id' As varchar) AS "LocationInfo-MunicipalityInfo-Id",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'cs' As varchar) AS "LocationInfo-MunicipalityInfo-Name-cs",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'de' As varchar) AS "LocationInfo-MunicipalityInfo-Name-de",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'en' As varchar) AS "LocationInfo-MunicipalityInfo-Name-en",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'fr' As varchar) AS "LocationInfo-MunicipalityInfo-Name-fr",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'it' As varchar) AS "LocationInfo-MunicipalityInfo-Name-it",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'nl' As varchar) AS "LocationInfo-MunicipalityInfo-Name-nl",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'pl' As varchar) AS "LocationInfo-MunicipalityInfo-Name-pl",
CAST("data"->'LocationInfo'->'MunicipalityInfo'->'Name'->>'ru' As varchar) AS "LocationInfo-MunicipalityInfo-Name-ru",
CAST("data"->>'TrustYouID' As varchar) AS "TrustYouID",
CAST("data"->>'HgvId' As varchar) AS "HgvId"
FROM accommodationsopen;

INSERT INTO "v_accommodationsopen_SmgTags"
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text("data" -> 'SmgTags') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'SmgTags' != 'null';

INSERT INTO "v_accommodationsopen_BadgeIds"
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text("data" -> 'BadgeIds') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'BadgeIds' != 'null';

INSERT INTO "v_accommodationsopen_BoardIds"
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text("data" -> 'BoardIds') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'BoardIds' != 'null';

INSERT INTO "v_accommodationsopen_ThemeIds"
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text("data" -> 'ThemeIds') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'ThemeIds' != 'null';

INSERT INTO "v_accommodationsopen_HasLanguage"
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text("data" -> 'HasLanguage') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'HasLanguage' != 'null';

INSERT INTO "v_accommodationsopen_MarketingGroupIds"
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text("data" -> 'MarketingGroupIds') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'MarketingGroupIds' != 'null';

INSERT INTO "v_accommodationsopen_SpecialFeaturesIds"
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements_text("data" -> 'SpecialFeaturesIds') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'SpecialFeaturesIds' != 'null';

INSERT INTO "v_accommodationsopen_Features"
WITH t ("Id", "data") AS (
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements("data" -> 'Features') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'Features' != 'null')
    SELECT "Id" AS "accommodationsopen_Id", CAST("data"->>'Id' As varchar) AS "Id",
CAST("data"->>'Name' As varchar) AS "Name",
CAST("data"->>'HgvId' As varchar) AS "HgvId"
    FROM t;

INSERT INTO "v_accommodationsopen_AccoBookingChannel"
WITH t ("Id", "data") AS (
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements("data" -> 'AccoBookingChannel') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'AccoBookingChannel' != 'null')
    SELECT "Id" AS "accommodationsopen_Id", CAST("data"->>'Id' As varchar) AS "Id",
CAST("data"->>'Pos1ID' As varchar) AS "Pos1ID",
CAST("data"->>'BookingId' As varchar) AS "BookingId",
CAST("data"->>'Portalname' As varchar) AS "Portalname"
    FROM t;

INSERT INTO "v_accommodationsopen_ImageGallery"
WITH t ("Id", "data") AS (
        SELECT CAST("data"->>'Id' As varchar) AS "Id", 
            jsonb_array_elements("data" -> 'ImageGallery') AS "data"
        FROM accommodationsopen
        WHERE "data" -> 'ImageGallery' != 'null')
    SELECT "Id" AS "accommodationsopen_Id", CAST("data"->>'Width' As integer) AS "Width",
CAST("data"->>'Height' As integer) AS "Height",
CAST("data"->>'License' As varchar) AS "License",
CAST("data"->>'ValidTo' As varchar) AS "ValidTo",
CAST("data"->>'ImageUrl' As varchar) AS "ImageUrl",
CAST("data"->>'CopyRight' As varchar) AS "CopyRight",
CAST("data"->>'ValidFrom' As varchar) AS "ValidFrom",
CAST("data"->>'IsInGallery' As bool) AS "IsInGallery",
CAST("data"->>'ListPosition' As integer) AS "ListPosition",
CAST("data"->'ImageDesc'->>'de' As varchar) AS "ImageDesc-de",
CAST("data"->'ImageDesc'->>'en' As varchar) AS "ImageDesc-en",
CAST("data"->'ImageDesc'->>'it' As varchar) AS "ImageDesc-it"
    FROM t;

ALTER SUBSCRIPTION ${subscription_name} ENABLE;

