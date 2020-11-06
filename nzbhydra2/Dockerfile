FROM k8sathome/ubuntu:focal-20201008

ARG TARGETPLATFORM
ARG VERSION

USER root

RUN \
  apt-get -qq update \
  &&\
  apt-get -qq install -y --no-install-recommends \
    openjdk-11-jre-headless \
    python3 \
    unzip \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && echo umask ${UMASK} >> /etc/bash.bashrc

USER kah

RUN \
  mkdir -p /app/nzbhydra2/bin \
  && curl -fsSL -o /tmp/nzbhydra2.zip \
    "https://github.com/theotherp/nzbhydra2/releases/download/v${VERSION}/nzbhydra2-${VERSION}-linux.zip" \
  && unzip -q "/tmp/nzbhydra2.zip" -d /app/nzbhydra2/bin \
  && rm -rf /tmp/nzbhydra2.zip \
  && curl -fsSL -o /app/nzbhydra2/bin/nzbhydra2wrapperPy3.py \
    "https://raw.githubusercontent.com/theotherp/nzbhydra2/master/other/wrapper/nzbhydra2wrapperPy3.py"

EXPOSE 5076

CMD umask ${UMASK} && /app/nzbhydra2/bin/nzbhydra2wrapperPy3.py --nobrowser --datafolder /config ${ARGS}