FROM balenalib/generic-armv7ahf-debian-python:3.8.2

RUN [ "cross-build-start" ]

# Install Glances
RUN apt-get update && apt-get install -y --no-install-recommends \
		git \
	&& pip install 'psutil>=5.7.0' bottle \
	&& rm -rf /var/lib/apt/lists/*
RUN  git clone -b v3.1.4 https://github.com/nicolargo/glances.git

RUN [ "cross-build-end" ]

# Define working directory.
WORKDIR /glances

# EXPOSE PORT (For Web UI & XMLRPC)
EXPOSE 61208 61209

# Define default command.
CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT
