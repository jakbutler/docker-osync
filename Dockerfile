FROM ubuntu:14.04

RUN apt-get update && apt-get install -y wget git inotify-tools rsync ssh vim && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /opt && \
	cd /opt && \
	git clone -b "stable" https://github.com/deajan/osync

# Set work directory
WORKDIR /opt/osync

# Install the osync to run it like a daemon
RUN cd /opt/osync && ./install.sh --silent

# Create volume data for osync initiator
VOLUME /data/primary
VOLUME /data/secondary
VOLUME /config

ADD osync.conf /config/

ENTRYPOINT ["/opt/osync/osync.sh"]
CMD ["/config/osync.conf", "--on-changes"]


