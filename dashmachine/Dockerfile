FROM k8sathome/ubuntu:latest

ARG TARGETPLATFORM
ARG VERSION

USER root

RUN \
  export EXTRA_INSTALL_ARG="build-essential libssl-dev libffi-dev python3-dev python3-pip"; \
  apt-get update -q \
  && apt-get install --no-install-recommends -qy \
    python3 \
    python3-setuptools \
    inetutils-ping \
    ${EXTRA_INSTALL_ARG} \
  && \
  ln -s /usr/bin/python3 /usr/bin/python \
  && \
  curl -fsSL "https://github.com/rmountjoy92/DashMachine/archive/v${VERSION}.tar.gz" | tar xzf - -C /dashmachine --strip-components 1 \
  && \
  echo "${VERSION}" > /dashmachine/version.txt \
  && \
  cd /dashmachine && pip install --no-cache-dir --progress-bar off -r requirements.txt \
  && \
  apt-get remove -y ${EXTRA_INSTALL_ARG} \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /dashmachine \
  && echo umask ${UMASK} >> /etc/bash.bashrc

USER kah

VOLUME /dashmachine/dashmachine/user_data
USER kah

EXPOSE 5000

COPY ./dashmachine/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
