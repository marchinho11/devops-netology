FROM centos:7 AS base

RUN yum install -y wget perl-Digest-SHA

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.0-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.0-linux-x86_64.tar.gz.sha512

RUN shasum -a 512 -c elasticsearch-7.15.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-7.15.0-linux-x86_64.tar.gz


FROM centos:7

COPY --from=base elasticsearch-7.15.0 /elastic

RUN useradd -ms /bin/bash elastic && \
    chown -R elastic /elastic && \
    chown -R elastic /var/lib

USER elastic

ENV ES_HOME=/elastic

EXPOSE 9200 9300

RUN echo -e "\
discovery.type: single-node       \n\
node.name: netology_test          \n\
path.data: /var/lib/elasticsearch \n\
path.repo: /elastic/snapshots     \n\
network.host: 0.0.0.0             \n\
" > $ES_HOME/config/elasticsearch.yml

ENTRYPOINT $ES_HOME/bin/elasticsearch
