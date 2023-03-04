# Container image for run ansible tool

[![BUILD IMAGE ANSIBLE 7.3.0](https://github.com/fabianoflorentino/ansible/actions/workflows/build.yml/badge.svg)](https://github.com/fabianoflorentino/ansible/actions/workflows/build.yml)

## **Usage**

| **Variable** | **Description** |
| --- | --- |
| $PWD | Current work directory with ansible code |

### **Local Usage**

```bash
# Ansible 7.3.0

# Build
docker build --no-cache -t <IMAGE NAME>:<TAG> -f ./Dockerfile .

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:7.3.0 sh
```

### **Local Usage from Remote**

```bash
# Ansible 7.3.0

# Pull (Download)
docker pull fabianoflorentino/ansible:7.3.0

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:2.9.21 sh
```

### **Github Actions**

#### **Ansible 7.3.0**

[.github/workflows/build-image-v550.yml](.github/workflows/build-image-v550.yml)

```yaml
---
name: BUILD IMAGE ANSIBLE 7.3.0

on:
  push:
    branches:
      - main
    paths-ignore:
      - 'README.md'
      - 'LICENSE'
      - 'docs/**'
      - '.github/**'

jobs:
  build:
    runs-on: ubuntu-latest
    name: Build Image
    steps:
      -
        name: Checkout
        uses: actions/checkout@v2
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      -
        name: Build and export
        uses: docker/build-push-action@v2
        with:
          file: Dockerfile
          context: .
          tags: fabianoflorentino/ansible:7.3.0
          outputs: type=docker,dest=/tmp/ansible.tar
      -
        name: Upload artifact
        uses: actions/upload-artifact@v2
        with:
          name: ansible
          path: /tmp/ansible.tar
  test:
    runs-on: ubuntu-latest
    name: Test Image
    needs: build
    steps:
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      -
        name: Download artifact
        uses: actions/download-artifact@v2
        with:
          name: ansible
          path: /tmp
      -
        name: Load image
        run: |
          docker load --input /tmp/ansible.tar
          docker image ls -a
      -
        name: Test
        run: |
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:7.3.0 /bin/sh -c "ansible --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:7.3.0 /bin/sh -c "ansible-vault --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:7.3.0 /bin/sh -c "ansible-playbook --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:7.3.0 /bin/sh -c "ansible localhost -m ping"
  push:
    runs-on: ubuntu-latest
    needs: test
    environment: DOCKERHUB
    name: Push Image
    steps:
      -
        name: Checkout
        uses: actions/checkout@v2
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      -
        name: Login to DockerHub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      -
        name: Build and push
        uses: docker/build-push-action@v2
        with:
          file: Dockerfile
          context: .
          push: true
          tags: fabianoflorentino/ansible:7.3.0
```
