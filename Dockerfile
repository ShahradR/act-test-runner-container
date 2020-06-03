FROM ubuntu:bionic

SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

RUN apt-get update \
  && apt-get -y install --no-install-recommends \
  sudo=1.8.21p2-3ubuntu1.2 \
  docker.io=19.03.6-0ubuntu1~18.04.1 \
  curl=7.58.0-2ubuntu3.8 \
  build-essential=12.4ubuntu1 \
  openssl=1.1.1-1ubuntu2.1~18.04.6 \
  libssl-dev=1.1.1-1ubuntu2.1~18.04.6 \
  python3-distutils=3.6.9-1~18.04 \
  python3-pip=9.0.1-2.3~ubuntu1.18.04.1 \
  wget=1.19.4-1ubuntu2.2 \
  gpg-agent=2.2.4-1ubuntu1.2 \
  software-properties-common=0.96.24.32.13 \
  git=1:2.17.1-1ubuntu0.7 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget -O- https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y --no-install-recommends \
     nodejs=14.4.0-1nodesource1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Add the Haskell PPA for Hadolint support
RUN add-apt-repository ppa:hvr/ghc
RUN apt-get update \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Allow executing pip3 by invoking pip
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Configure Maven
RUN wget http://apache.mirror.rafal.ca/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp && tar xf /tmp/apache-maven-*.tar.gz -C /opt
ENV M2_HOME=/opt/apache-maven-3.6.3
ENV MAVEN_HOME=/opt/apache-maven-3.6.3
ENV PATH="/opt/apache-maven-3.6.3/bin:${PATH}"
