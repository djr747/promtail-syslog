FROM debian:trixie-slim

ARG PROMTAIL_VERSION=3.1.1

# Setup non-root user
ENV USER_NAME=containeruser
ENV USER_UID=1001
ENV USER_GID=${USER_UID}
ENV GROUP_NAME=${USER_NAME}

# Install packages, create non-root user and set permissions
RUN apt update \
    && apt install -y rsyslog supervisor wget gpg \
    && mkdir -p /etc/apt/keyrings/ \
    && wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor > /etc/apt/keyrings/grafana.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee /etc/apt/sources.list.d/grafana.list \
    && apt update \
    && apt install -y promtail="${PROMTAIL_VERSION}" \
    && apt clean \
    && groupadd --gid "${USER_GID}" "${GROUP_NAME}" \
    && useradd --uid "${USER_UID}" --gid "${USER_GID}" -m "${USER_NAME}" \
    && chgrp "${GROUP_NAME}" /var/run \
    && chmod g+wx /var/run \
    && chgrp "${GROUP_NAME}" /var/log \
    && chmod g+wx /var/log

# Copy in configurations
COPY promtail.yaml /etc/promtail.yaml
COPY rsyslog.conf /etc/rsyslog.conf
COPY supervisord.conf /etc/supervisord.conf

# Set working directory to user's home
WORKDIR /home/${USER_NAME}

# Set to non-root user
USER $USER_NAME

# Container runtime details
EXPOSE 514/udp 514/tcp 9080/tcp
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
