FROM python:alpine3.17 as build

LABEL maintainer="Fabiano Florentino"
LABEL email="fabianoflorentino@outlook.com"
LABEL ansible version="7.3.0"
LABEL image version="v0.0.4"

COPY requirements.txt .

RUN apk add --no-cache make gcc g++ libffi-dev openssl openssl-dev sshpass openssh \
  && apk --no-cache update \
  && apk --no-cache upgrade \
  && pip install --upgrade pip \
  && pip install -r requirements.txt --no-cache-dir \
  && rm -vrf /var/cache/apk/*

FROM python:alpine3.17 as run

RUN adduser --disabled-password --gecos "" ansible \
  && apk --no-cache update \
  && apk --no-cache upgrade \
  && apk add --no-cache make openssh sshpass gnupg git \
  && rm -vrf /var/cache/apk/*

COPY --from=build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=build /usr/local/bin/ansible /usr/local/bin/ansible
COPY --from=build /usr/local/bin/ansible-playbook /usr/local/bin/ansible-playbook
COPY --from=build /usr/local/bin/ansible-galaxy /usr/local/bin/ansible-galaxy
COPY --from=build /usr/local/bin/ansible-vault /usr/local/bin/ansible-vault
COPY --from=build /usr/local/bin/ansible-lint /usr/local/bin/ansible-lint
COPY --from=build /usr/local/bin/ansible-config /usr/local/bin/ansible-config
COPY --from=build /usr/local/bin/ansible-test /usr/local/bin/ansible-test

USER ansible

ENTRYPOINT [ "ansible" ]
