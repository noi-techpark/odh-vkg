FROM ontop/ontop-endpoint:4.1-snapshot as base
COPY --from=flyway/flyway:7.3-alpine /flyway /flyway
COPY infrastructure/docker/ontop/entrypoint.sh /entrypoint.sh
COPY sql /opt/ontop/sql
RUN apk add --update curl && \
    apk add --no-cache postgresql-client && \
    rm -rf /var/cache/apk/* && \
    ln -s /flyway/flyway /usr/local/bin/flyway

# Dev
FROM base as dev
RUN curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /wait-for-it.sh
RUN chmod u+x /wait-for-it.sh

# Build
FROM base as build
COPY vkg /opt/ontop/input
COPY jdbc /opt/ontop/jdbc
ENTRYPOINT /entrypoint.sh