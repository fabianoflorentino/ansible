FROM python:3.9.14-alpine3.16 as build

LABEL maintainer="Fabiano Florentino"
LABEL email="fabianoflorentino@outlook.com"
LABEL ansible version="4.10.0"
LABEL ansible-core="2.11.7"
LABEL image version="v0.3"

COPY requirements_ansible4_10_0.txt .

RUN apk add --no-cache make gcc g++ libffi-dev openssl openssl-dev sshpass openssh \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && pip install --upgrade pip \
    && pip install -r requirements_ansible4_10_0.txt --no-cache-dir \
    && rm -vrf /var/cache/apk/*

FROM python:3.9.14-alpine3.16 as run

RUN adduser --disabled-password --gecos "" ansible \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && apk add --no-cache openssl openssl-dev sshpass openssh git \
    && rm -vrf /var/cache/apk/*

COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=build /usr/local/bin/ansible-vault /usr/local/bin/ansible-vault
COPY --from=build /usr/local/bin/ansible-galaxy /usr/local/bin/ansible-galaxy
COPY --from=build /usr/local/bin/ansible-playbook /usr/local/bin/ansible-playbook
COPY --from=build /usr/local/bin/ansible /usr/local/bin/ansible
COPY --from=build /usr/local/bin/ansible-lint /usr/local/bin/ansible-lint

USER ansible

ENTRYPOINT [ "sh" ]
