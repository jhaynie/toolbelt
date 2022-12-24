FROM debian:stable-slim

ENV COCKROACH_VERSION=22.2.1
ENV NATS_CLI_VERSION=0.0.35
ENV MONGO_VERSION=1.6.1

RUN echo "alias ll='ls -la'" >> $HOME/.bashrc
RUN echo 'export PATH="$PATH:/usr/local/bin"' >> $HOME/.bashrc
RUN echo 'export PATH="$PATH:/root/.nsccli/bin"' >> $HOME/.bashrc
RUN apt-get update && apt-get install -y ca-certificates curl tar iputils-ping dnsutils unzip traceroute python jq redis-tools
WORKDIR /tmp
RUN curl -L https://binaries.cockroachdb.com/cockroach-v${COCKROACH_VERSION}.linux-amd64.tgz | tar -xz && cp -i cockroach-v${COCKROACH_VERSION}.linux-amd64/cockroach /usr/local/bin/ && rm -rf cockroach-v${COCKROACH_VERSION}.linux-amd64
RUN curl -L https://github.com/nats-io/natscli/releases/download/v${NATS_CLI_VERSION}/nats-${NATS_CLI_VERSION}-linux-amd64.zip -O && unzip nats-${NATS_CLI_VERSION}-linux-amd64.zip && cp -i nats-${NATS_CLI_VERSION}-linux-amd64/nats /usr/local/bin && rm -rf nats-${NATS_CLI_VERSION}-linux-amd64*
RUN curl -L https://raw.githubusercontent.com/nats-io/nsc/master/install.py | python
RUN curl -L https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip && rm -rf /tmp/aws
RUN curl -L https://downloads.mongodb.com/compass/mongosh-${MONGO_VERSION}-linux-x64.tgz | tar -xz && cd /tmp/mongosh-${MONGO_VERSION}-linux-x64/bin && cp -R . /usr/local/bin && rm -rf /tmp/mongosh-${MONGO_VERSION}-linux-x64
RUN apt-get remove python
RUN apt-get clean && apt-get autoremove

ENTRYPOINT ["/bin/bash"]
