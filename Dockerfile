FROM python:3.6-alpine



ENV PYTHONUNBUFFERED 1
ENV CHROME_BIN /usr/bin/chromium-browser
ENV CHROME_PATH /usr/lib/chromium/

RUN set -ex && \
    apk upgrade --no-cache && \
    apk add --no-cache bash tini libc6-compat linux-pam && \
    mkdir -p /opt/spark && \
    mkdir -p /opt/spark/work-dir && \
    touch /opt/spark/RELEASE && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd

    
ADD jars /opt/spark/jars
ADD bin /opt/spark/bin
ADD sbin /opt/spark/sbin
ADD kubernetes/dockerfiles/spark/entrypoint.sh /opt/
ADD examples /opt/spark/examples
ADD kubernetes/tests /opt/spark/tests
ADD data /opt/spark/data

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






ENV SPARK_HOME /opt/spark

WORKDIR /opt/spark/work-dir

ENTRYPOINT [ "/opt/entrypoint.sh" ]

    

