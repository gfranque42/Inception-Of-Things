# FROM debian:12.10-slim

# RUN apt update

# RUN apt install -y curl openssh-server ca-certificates perl

# WORKDIR /project

# RUN curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash

# RUN apt install -y gitlab-ce

# RUN sed -i "s|external_url 'http://gitlab.example.com'|external_url 'http://localhost:8080'|" /etc/gitlab/gitlab.rb

# RUN gitlab-ctl reconfigure

# COPY ./entrypoint.sh /project/entrypoint.sh

# EXPOSE 8080

# ENTRYPOINT ["bash", "entrypoint.sh"]
FROM gitlab/gitlab-ce:17.11.3-ce.0

# Variables d'environnement pour la configuration de GitLab
ENV GITLAB_OMNIBUS_CONFIG="external_url 'http://localhost:8080'; \
gitlab_rails['gitlab_shell_ssh_port'] = 2222; \
nginx['listen_port'] = 8080; \
prometheus['enable'] = false; \
alertmanager['enable'] = false; \
puma['port'] = 8081; \
prometheus_monitoring['enable'] = false;"

# Vous pouvez ajouter des outils supplémentaires si nécessaire
RUN apt-get update && apt-get install -y \
    vim \
    git \
    lsof \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Exposer les ports
EXPOSE 8080 8081 2222
