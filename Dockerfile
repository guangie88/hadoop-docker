# Debian based
ARG JAVA_VERSION=8
FROM openjdk:${JAVA_VERSION}-jre-slim

ARG HADOOP_VERSION="2.7.7"

ENV HADOOP_NAME "hadoop-${HADOOP_VERSION}"
ENV HADOOP_DIR "/opt/${HADOOP_NAME}"
ENV HADOOP_HOME "/usr/local/hadoop"

RUN set -eux; \
    # Setup and install 
    if [ -z "${HADOOP_VERSION}" ]; then \
        echo "Please set --build-arg HADOOP_VERSION for Docker build!" >&2; \
        sh -c "exit 1"; \
    fi; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        # Build-time only deps
        wget; \
    #
    # Hadoop installation
    #
    wget https://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz; \
    tar zxf hadoop-${HADOOP_VERSION}.tar.gz -C /opt; \
    rm hadoop-${HADOOP_VERSION}.tar.gz; \
    ln -s ${HADOOP_DIR} ${HADOOP_HOME}; \
    #
    # Remove unnecessary build-time only dependencies
    #
    apt-get remove -y wget; \
    rm -rf /var/lib/apt/lists/*

ENV PATH "${PATH}:${HADOOP_HOME}/bin"
