# Infrastructure

The Virtual Knowledge Graph is composed of a single VKG Postgres DB, from where
we subscribe to various source databases via logical replication. Then, we
create a `SparQL endpoint` and `SparQL querying web application` with two docker
containers, namely `Ontop` and `Nginx`.

If you want to know how to setup logical replication, have a look at our [Flight
Rules](https://github.com/noi-techpark/documentation/blob/master/FLIGHTRULES.md#i-want-to-enable-logical-replication-on-an-awsrds-or-regular-postgres-instance).

## Endpoints

Current deployments:
 * Production: https://sparql.opendatahub.bz.it/
 * Testing: https://sparql.opendatahub.testingmachine.eu/

On these servers, one can find:
* Front-end portal:  `/`
* SPARQL endpoint: `/sparql`
* Predefined queries: `/predefined/{queryId}?{param1=value1}*`
  * Example: https://sparql.opendatahub.testingmachine.eu/predefined/accommodation?Id=86673280ABD13ADC4D521DF459C75474
* Clone of the existing ODH API `/api/JsonLD/DetailInLD?type={value1}&{param2=value2}*`
  * Example: https://sparql.opendatahub.testingmachine.eu/api/JsonLD/DetailInLD?type=accommodation&Id=32E7BE648E7B11D181AB006097B896BA&showid=false


## Deployment

Deployment in these environments is achieved through Jenkins scripts:
- CI: `jenkins/ci.groovy`
- CD for the testing enviroment: `jenkins/test.groovy`
- CD for the production environment: `jenkins/prod.groovy`

...and docker-compose scripts:
- Build docker: `docker-compose.build.yml` 
- Run docker: `docker-compose.run.yml`

Jenkins
- CI: https://ci.opendatahub.bz.it/job/it.bz.opendatahub.sparql
- CD: https://jenkins.testingmachine.eu/job/it.bz.opendatahub.sparql

## Credentials

Prefix is `it.bz.opendatahub.sparql`.

Jenkins:
- `it.bz.opendatahub.sparql.db.vkg.password`
- `it.bz.opendatahub.sparql.db.vkg.password.readonly`
- `it.bz.opendatahub.sparql.db.tourism.password`

Passbolt:
- Resource = `it.bz.opendatahub.sparql.db.tourism`; Username = `vkgreplicate`
- Resource = `it.bz.opendatahub.sparql.db.vkg`; Username = `vkguser`
- Resource = `it.bz.opendatahub.sparql.db.vkg`; Username = `vkguser_readonly`
- Resource = `it.bz.opendatahub.sparql.db.vkg`; Username = `postgres`

## Security

Open ports (Postgres' default is `5432`)
- The VKG database must have access to the tourism db for the subscription
- The Docker server must have access to the VKG database

Create DB roles
- See both database sections for further details

## Databases

The databases used in the test and production environments of NOI are not
managed by Docker, but are instead AWS RDS services.

### Tourism Postgres DB (source)
This is the original source of tourism data. We access it through logical
replication as described in our [Flight
Rules](https://github.com/noi-techpark/documentation/blob/master/FLIGHTRULES.md#i-want-to-enable-logical-replication-on-an-awsrds-or-regular-postgres-instance).

### Virtual Knowledge Graph Postgres DB (destination)

#### Users

We need a superuser `vkguser`, that will run all our Flyway scripts. This
example is about the `tourism_test` replication, but it will be similar for all
other replications.

```sql
CREATE ROLE vkguser WITH LOGIN PASSWORD 's3cret';
COMMENT ON ROLE vkguser IS 'Admin account to access the virtual knowledge graph';
GRANT CONNECT ON DATABASE tourism_test TO vkguser;
GRANT CREATE ON SCHEMA public TO vkguser;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO vkguser;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO vkguser;
ALTER ROLE vkguser SET statement_timeout TO '360s';
```

In addition we need a read only user `vkguser_readonly`, to access the data.

```sql
CREATE ROLE vkguser_readonly WITH LOGIN PASSWORD 's3cret';
COMMENT ON ROLE vkguser_readonly IS 'Read-only account to access the virtual knowledge graph';
GRANT CONNECT ON DATABASE tourism_test TO vkguser_readonly;
GRANT USAGE ON SCHEMA public TO vkguser_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO vkguser_readonly;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO vkguser_readonly;
ALTER ROLE vkguser_readonly SET statement_timeout TO '360s';
```

#### Databases

```sql
CREATE DATABASE tourism_test;
CREATE DATABASE tourism_prod;
```

## Docker containers
First, we start an `Ontop` container, which initially executes
[Flyway](https://flywaydb.org) to update the schema of the replication database.

Second, we start an `Nginx` container to serve the web frontend of the SparQL endpoint.

## Flight Rules

### I want to update the tourism DB dump

The current dump is inside `sql/V1__initial_setup.sql`.

```sh
cd infrastructure/utils
./tourism-dump-schema.sh
```

### I have a Flyway schema error, which I want to repair

Assume that the docker of Ontop runs on `dockertest2` and all commands are
executed as `root`.

```sh
ssh dockertest2
cd /var/docker/odh-vkg/current
docker-compose run --entrypoint="flyway -X repair" ontop
```

### I want to login into the Ontop container

Assume that the docker of Ontop runs on `dockertest2` and all commands are
executed as `root`.

```sh
ssh dockertest2
cd /var/docker/odh-vkg/current
docker-compose run --entrypoint=/bin/bash ontop
```
