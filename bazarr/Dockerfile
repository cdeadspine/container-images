FROM k8sathome/ubuntu:focal-20201008

ARG VERSION
ARG TARGETPLATFORM

USER root

RUN \
  case "${TARGETPLATFORM}" in \
    'linux/arm64') \
      export EXTRA_INSTALL_ARG="libxml2-dev libxslt1-dev python3-libxml2 python3-lxml libatlas-base-dev" ;; \
    'linux/arm/v7') \
      export EXTRA_INSTALL_ARG="libxml2-dev libxslt1-dev python3-libxml2 python3-lxml libatlas-base-dev" ;; \
  esac \
  && \
  apt-get -qq update \
  && \
  apt-get -qq install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-distutils \
    ffmpeg \
    unrar-free \
    ${EXTRA_INSTALL_ARG} \
  && \
  mkdir -p /app/bazarr/bin \
  && curl -fsSL "https://github.com/morpheus65535/bazarr/archive/v${VERSION}.tar.gz" | tar xzf - -C /app/bazarr/bin --strip-components=1 \
  && pip3 install --no-cache-dir -r /app/bazarr/bin/requirements.txt \
  && chown -R kah:kah /app \
  && apt-get remove -y python3-pip \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /app/bazarr/bin/bin \
    /app/bazarr/bin/screenshots \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && echo umask ${UMASK} >> /etc/bash.bashrc

USER kah

EXPOSE 6767

CMD umask ${UMASK} && python3 /app/bazarr/bin/bazarr.py --no-update --config /config ${ARGS}