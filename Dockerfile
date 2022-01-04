FROM ubuntu/mysql:8.0-21.04_beta

RUN set -eux; \
	apt-get update; \
	DEBIAN_FRONTEND=noninteractive apt-get full-upgrade -y; \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        wget lsb-release gnupg locales-all

COPY mysql-apt-config_0.8.22-1_all.deb .
RUN echo mysql-apt-config mysql-apt-config/select-product select Ok | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.22-1_all.deb && \
    DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y ./mysql-apt-config_0.8.22-1_all.deb

RUN apt-get update -y && apt-get install mysql-shell -y

EXPOSE 3306 33060

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
