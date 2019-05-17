FROM balenalib/generic-armv7ahf-alpine-python:3.7.2

RUN [ "cross-build-start" ]

# Install Glances (develop branch)
RUN apk add --no-cache --virtual .build_deps \
        gcc \
        musl-dev \
        linux-headers \
        && pip install 'psutil>=5.4.7,<5.5.0' bottle==0.12.13 \
        && apk del .build_deps
RUN apk add --no-cache git && git clone -b v3.1.0 https://github.com/nicolargo/glances.git

RUN [ "cross-build-end" ]

# Define working directory.
WORKDIR /glances

# EXPOSE PORT (For Web UI & XMLRPC)
EXPOSE 61208 61209

# Define default command.
CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT