FROM python:3.12.0a1-alpine3.15 as build


LABEL maintainer="Fabiano Florentino"
LABEL email="fabianoflorentino@outlook.com"
LABEL ansible version="5.5.0"
LABEL image version="v0.2"

COPY requirements_ansible5_5_0.txt .

RUN apk add --no-cache make gcc g++ libffi-dev openssl openssl-dev sshpass openssh \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && pip install --upgrade pip \
    && pip install -r requirements_ansible5_5_0.txt --no-cache-dir \
    && rm -vrf /var/cache/apk/*

FROM python:3.12.0a1-alpine3.15 as run

RUN adduser --disabled-password --gecos "" ansible \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && rm -vrf /var/cache/apk/*

COPY --from=build /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=build /usr/local/bin/ansible-vault /usr/local/bin/ansible-vault
COPY --from=build /usr/local/bin/ansible-playbook /usr/local/bin/ansible-playbook
COPY --from=build /usr/local/bin/ansible /usr/local/bin/ansible

USER ansible

ENTRYPOINT [ "sh" ]
