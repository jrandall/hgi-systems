FROM ubuntu:16.04

# Install qemu-img
COPY scripts/get-qemu-img.sh /tmp/get-qemu-img.sh
RUN /tmp/get-qemu-img.sh && rm /tmp/get-qemu-img.sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         apt-utils \
         software-properties-common \
    && apt-get install -y --no-install-recommends \
         bash \
         curl \
         git \
         ruby \
    && rm -rf /var/lib/apt/lists/*

# Install python-gitlab
COPY scripts/get-python-gitlab.sh /tmp/get-python-gitlab.sh
RUN /tmp/get-python-gitlab.sh && rm /tmp/get-python-gitlab.sh

RUN curl -L -o /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && \
    chmod a+x /usr/local/bin/mc

# Install go
COPY scripts/get-go.sh /tmp/get-go.sh
RUN /tmp/get-go.sh && rm /tmp/get-go.sh

# Setup go environment
ENV PATH /usr/local/go/bin:$PATH

# Install openstack client
COPY scripts/get-openstackclient.sh /tmp/get-openstackclient.sh
RUN /tmp/get-openstackclient.sh && rm /tmp/get-openstackclient.sh

# Install glance-proxy
COPY scripts/get-glance-proxy.sh /tmp/get-glance-proxy.sh
RUN /tmp/get-glance-proxy.sh && rm /tmp/get-glance-proxy.sh

# Set workdir and entrypoint
WORKDIR /tmp
ENTRYPOINT []

