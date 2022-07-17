FROM debian:stable-slim

RUN echo "alias ll='ls -la'" >> $HOME/.bashrc
RUN echo 'export PATH="$PATH:/usr/local/bin"' >> $HOME/.bashrc
RUN echo 'export PATH="$PATH:/root/.nsccli/bin"' >> $HOME/.bashrc
RUN apt-get update && apt-get install -y ca-certificates curl tar iputils-ping dnsutils unzip traceroute python
WORKDIR /tmp
RUN curl -L https://binaries.cockroachdb.com/cockroach-v22.1.3.linux-amd64.tgz | tar -xz && cp -i cockroach-v22.1.3.linux-amd64/cockroach /usr/local/bin/ && rm -rf cockroach-v22.1.3.linux-amd64
RUN curl -L https://github.com/nats-io/natscli/releases/download/v0.0.33/nats-0.0.33-linux-amd64.zip -O && unzip nats-0.0.33-linux-amd64.zip && cp -i nats-0.0.33-linux-amd64/nats /usr/local/bin && rm -rf nats-0.0.33-linux-amd64*
RUN curl -L https://raw.githubusercontent.com/nats-io/nsc/master/install.py | python
RUN apt-get remove python
RUN apt-get clean && apt-get autoremove

ENTRYPOINT ["/bin/bash"]
