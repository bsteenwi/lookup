
FROM java:8

MAINTAINER  DBpedia Team <dbpedia-developers@lists.sourceforge.net>

RUN apt-get update && apt-get install -y \
    curl

ENV INDEX_URL https://www.dropbox.com/s/vv9w7kz7jprqrmc/index.zip?dl=0#
ENV INDEX_FILENAME index.zip

ENV LOOKUP_JAR dbpedia-lookup-3.1-jar-with-dependencies.jar
ENV LOOKUP_URL www.dropbox.com/s/5f852uwzov0hgmt

RUN mkdir -p /opt/lookup && \
    cd /opt/lookup && \
    wget "http://$LOOKUP_URL/$LOOKUP_JAR?dl=1" -O $LOOKUP_JAR  && \
    wget "http://$INDEX_URL/$INDEX_FILENAME?dl=1" -O $INDEX_FILENAME  && \
    unzip $INDEX_FILENAME   && \
    rm  $INDEX_FILENAME

EXPOSE 1111
