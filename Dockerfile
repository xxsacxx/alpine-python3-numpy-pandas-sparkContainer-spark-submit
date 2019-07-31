FROM python:3.6-alpine



ENV PYTHONUNBUFFERED 1
ENV CHROME_BIN /usr/bin/chromium-browser
ENV CHROME_PATH /usr/lib/chromium/

ADD requirements.txt /requirements.txt
RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
        libstdc++ \
        python3-dev \
        fontconfig \
        chromium \
        chromium-chromedriver \
    && apk add --no-cache --virtual .build-deps \
        g++ \
        gcc \
        make \
        libc-dev \
        libffi-dev \
        openssl-dev \
        ca-certificates \
        libxml2-dev \
        libxslt-dev \
        libjpeg-turbo-dev \
        zlib-dev  \
        musl-dev \
        linux-headers \
        pcre-dev \
        curl \
        git \
    && update-ca-certificates 2>/dev/null || true \
    && export PATH=$PATH:/usr/lib/chromium-browser \
    && pip3.6 install -U pip==9.0.3 \

    && pip3.6 install --no-cache-dir -r requirements.txt \
    && apk del .build-deps




ENV SPARK_HOME=/opt/spark
ENV SPARK_USER=ticksmith

ARG SPARK_VERSION=2.4.3

WORKDIR /opt

RUN apk add --update openssl wget bash && \
    wget -P /opt https://www.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
    tar xvzf spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
    rm spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
    ln -s /opt/spark-$SPARK_VERSION-bin-hadoop2.7 /opt/spark





    

