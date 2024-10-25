FROM arm64v8/alpine:3

RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    wget -P /etc/apk/keys/ https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk update && \
    apk add zulu11-jdk && \
    apk add coreutils \
            libgcc \
            bash \
            wget \
            libstdc++ \
    && \
    rm -rfv /var/cache/apk/*

# Copy and setup DB app
ENV GRIDGAIN_HOME=/opt/gridgain9-db
ENV LIBS_DIR=$GRIDGAIN_HOME/lib
ENV GRIDGAIN_WORK_DIR=$GRIDGAIN_HOME/work
ENV GRIDGAIN_CONFIG_PATH=$GRIDGAIN_HOME/etc/gridgain-config.conf

COPY gridgain9-db-9.0.6 $GRIDGAIN_HOME

EXPOSE 3344 10300 10800

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
ENV PATH="/usr/local/bin:${PATH}"

# Copy CLI app
ENV GRIDGAIN_CLI_HOME=/opt/gridgain9-cli
COPY gridgain9-cli-9.0.6 $GRIDGAIN_CLI_HOME

ENTRYPOINT ["docker-entrypoint.sh"]
