#
# Elasticsearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM dockerfile/java:oracle-java8

ENV ES_PKG_NAME elasticsearch-1.4.4

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /local && \
  rm -f $ES_PKG_NAME.tar.gz

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD files/elasticsearch.yaml /etc/elasticsearch/elasticsearch.yaml

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200 9300

# Define default command.
CMD ["/local/bin/elasticsearch", "-Des.config=/etc/elasticsearch/elasticsearch.yaml"]

