FROM python:3.9.13-alpine3.15 as build

LABEL maintainer="Fabiano Florentino"
LABEL email="fabianoflorentino@outlook.com"
LABEL ansible version="2.7.11"
LABEL image version="v0.1"

COPY requirements_ansible2_7_11.txt .

RUN apk add --no-cache make gcc g++ libffi-dev openssl openssl-dev sshpass openssh \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && pip install --upgrade pip \
    && pip install -r requirements_ansible2_7_11.txt --no-cache-dir \
    && rm -vrf /var/cache/apk/*

FROM python:3.9.13-alpine3.15 as run

RUN adduser --disabled-password --gecos "" ansible \
    && apk --no-cache update \
    && apk --no-cache upgrade \
    && apk add openssl openssl-dev sshpass openssh \
    && rm -vrf /var/cache/apk/*

COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=build /usr/local/bin/ansible-vault /usr/local/bin/ansible-vault
COPY --from=build /usr/local/bin/ansible-galaxy /usr/local/bin/ansible-galaxy
COPY --from=build /usr/local/bin/ansible-playbook /usr/local/bin/ansible-playbook
COPY --from=build /usr/local/bin/ansible /usr/local/bin/ansible

USER ansible

ENTRYPOINT [ "sh" ]