FROM python:3.10.0-alpine as build

LABEL maintainer="Fabiano Florentino"
LABEL email="fabianoflorentino@outlook.com"

COPY requirements_ansible2_9_21.txt .

RUN apk add --no-cache make gcc g++ libffi-dev openssl openssl-dev sshpass openssh \
    && pip install --upgrade pip \
    && pip install -r requirements_ansible2_9_21.txt --no-cache-dir \
    && rm -vrf /var/cache/apk/*

FROM python:3.10.0-alpine as run

RUN adduser --disabled-password --gecos "" ansible

COPY --from=build /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=build /usr/local/bin/ansible-vault /usr/local/bin/ansible-vault
COPY --from=build /usr/local/bin/ansible-galaxy /usr/local/bin/ansible-galaxy
COPY --from=build /usr/local/bin/ansible-playbook /usr/local/bin/ansible-playbook
COPY --from=build /usr/local/bin/ansible /usr/local/bin/ansible

USER ansible

ENTRYPOINT [ "sh" ]