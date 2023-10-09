FROM oraclelinux:8-slim AS eatmydata

RUN microdnf install git autoconf gcc make

RUN curl -L https://github.com/stewartsmith/libeatmydata/releases/download/v131/libeatmydata-131.tar.gz | tar --strip-components=1 -xvpz

RUN ./configure && make install

FROM mysql:8.0.34

COPY --from=eatmydata /usr/local/bin/eatmydata /usr/local/bin/eatmydata

LABEL org.opencontainers.image.source=https://github.com/simon-engledew/eatmysqldata

ENTRYPOINT ["/usr/local/bin/eatmydata", "docker-entrypoint.sh"]