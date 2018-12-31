# Hive Docker Builder

Dockerfile setup to install various versions of Hadoop in a minimalist
environment.

The Java version `JAVA_VERSION` defaults to 8, while `HADOOP_VERSION` build
argument must be specified.

## Example build and run commands

```bash
JAVA_VERSION=8
HADOOP_VERSION=2.7.7

# Build
docker build . \
    --build-arg HADOOP_VERSION=${HADOOP_VERSION} \
    -t guangie88/hadoop:${HADOOP_VERSION}_java-${JAVA_VERSION}

# Check Hadoop version
docker run --rm -it \
    guangie88/hadoop:${HADOOP_VERSION}_java-${JAVA_VERSION} \
    hadoop version
```
