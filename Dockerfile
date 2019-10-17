
FROM tomcat:8.5.46-jdk8-openjdk-slim

MAINTAINER Cavamagie@

WORKDIR $CATALINA_HOME

ENV CMDBUILD_URL https://sourceforge.net/projects/cmdbuild/files/3.1.1/cmdbuild-3.1.1.war/download
ENV POSTGRES_USER postgres
ENV POSTGRES_PASS postgres
ENV POSTGRES_PORT 5432
ENV POSTGRES_HOST cmdbuild_db
ENV POSTGRES_DB cmdbuild_db31
ENV CMDBUILD_DUMP demo

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    maven \
    postgresql-client\
    postgis \
    libpostgresql-jdbc-java

RUN set -x \
 	&& mkdir $CATALINA_HOME/conf/cmdbuild/ \
 	&& mkdir $CATALINA_HOME/webapps/cmdbuild/

COPY files/postgresql-42.2.8.jar $CATALINA_HOME/lib/postgresql-42.2.8.jar
COPY files/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml
COPY files/context.xml $CATALINA_HOME/webapps/manager/META-INF/context.xml
COPY files/database.conf $CATALINA_HOME/conf/cmdbuild/database.conf
COPY files/docker-entrypoint.sh /usr/local/bin/


RUN set -x \
	&& groupadd tomcat \
	&& useradd -s /bin/false -g tomcat -d $CATALINA_HOME tomcat \
	&& cd /tmp \
	&& wget -O cmdbuild.war "$CMDBUILD_URL" \
	&& chmod 777 cmdbuild.war \
	&& chmod 777 /usr/local/bin/docker-entrypoint.sh \
	&& unzip cmdbuild.war -d cmdbuild \
	&& mv cmdbuild.war $CATALINA_HOME/webapps/cmdbuild.war \
	&& mv cmdbuild/* $CATALINA_HOME/webapps/cmdbuild/ \
	&& chmod 777 $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh \
	&& chown tomcat -R $CATALINA_HOME \
	&& cd /tmp \
	&& rm -rf * \
	&& rm -rf /var/lib/apt/lists/*

# cleanup
RUN apt-get -qy autoremove

ENTRYPOINT /usr/local/bin/docker-entrypoint.sh

USER tomcat

EXPOSE 8080

CMD ["catalina.sh", "run"]
