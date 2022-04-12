[![BUILD IMAGE ANSIBLE 2.7.11](https://github.com/fabianoflorentino/ansible/actions/workflows/build-image-v2711.yml/badge.svg)](https://github.com/fabianoflorentino/ansible/actions/workflows/build-image-v2711.yml) 
[![BUILD IMAGE ANSIBLE 2.9.21](https://github.com/fabianoflorentino/ansible/actions/workflows/build-image-v2921.yml/badge.svg)](https://github.com/fabianoflorentino/ansible/actions/workflows/build-image-v2921.yml) 
[![BUILD IMAGE ANSIBLE 5.5.0](https://github.com/fabianoflorentino/ansible/actions/workflows/build-image-v550.yml/badge.svg)](https://github.com/fabianoflorentino/ansible/actions/workflows/build-image-v550.yml)

# A container image for run ansible tool

## **Usage**

| **Variable** | **Description** |
| --- | --- |
| $PWD | Current work directory with ansible code |

### **Local Usage**

```bash
# Ansible 2.7.11

# Build
docker build --no-cache -t <IMAGE NAME>:<TAG> -f ./ansible27.Dockerfile .

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:2.7.11 sh
```

```bash
# Ansible 2.9.21

# Build
docker build --no-cache -t <IMAGE NAME>:<TAG> -f ./ansible29.Dockerfile .

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:2.9.21 sh
```

```bash
# Ansible 5.5.0

# Build
docker build --no-cache -t <IMAGE NAME>:<TAG> -f ./ansible55.Dockerfile .

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:5.5.0 sh
```

### **Local Usage from Remote**

```bash
# Ansible 2.7.11

# Pull (Download)
docker pull fabianoflorentino/ansible:2.7.11

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:2.7.11 sh
```

```bash
# Ansible 2.9.21

# Pull (Download)
docker pull fabianoflorentino/ansible:2.9.21

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:2.9.21 sh
```

```bash
# Ansible 5.5.0

# Pull (Download)
docker pull fabianoflorentino/ansible:5.5.0

# Run
docker run -it --name ansible -v $PWD:/ansible -w /ansible --entrypoint "" fabianoflorentino/ansible:2.9.21 sh
```

### **Github Actions**

#### **Ansible 2.7.11**

```yaml
---
name: BUILD IMAGE ANSIBLE 2.7.11

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
          file: ansible27.Dockerfile
          context: .
          tags: fabianoflorentino/ansible:2.7.11
          outputs: type=docker,dest=/tmp/ansible27.tar
      -
        name: Upload artifact
        uses: actions/upload-artifact@v2
        with:
          name: ansible27
          path: /tmp/ansible27.tar
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
          name: ansible27
          path: /tmp
      -
        name: Load image
        run: |
          docker load --input /tmp/ansible27.tar
          docker image ls -a
      - 
        name: Test
        run: |
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.7.11 /bin/sh -c "ansible --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.7.11 /bin/sh -c "ansible-vault --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.7.11 /bin/sh -c "ansible-galaxy --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.7.11 /bin/sh -c "ansible-playbook --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.7.11 /bin/sh -c "ansible localhost -m ping"
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
          file: ansible27.Dockerfile
          context: .
          push: true
          tags: fabianoflorentino/ansible:2.7.11
```

#### **Ansible 2.9.21**

[.github/workflows/build-image-v2921.yml](.github/workflows/build-image-v2921.yml)

```yaml
---
name: BUILD IMAGE ANSIBLE 2.9.21

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
          file: ansible29.Dockerfile
          context: .
          tags: fabianoflorentino/ansible:2.9.21
          outputs: type=docker,dest=/tmp/ansible29.tar
      -
        name: Upload artifact
        uses: actions/upload-artifact@v2
        with:
          name: ansible29
          path: /tmp/ansible29.tar
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
          name: ansible29
          path: /tmp
      -
        name: Load image
        run: |
          docker load --input /tmp/ansible29.tar
          docker image ls -a
      - 
        name: Test
        run: |
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.9.21 /bin/sh -c "ansible --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.9.21 /bin/sh -c "ansible-vault --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.9.21 /bin/sh -c "ansible-galaxy --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.9.21 /bin/sh -c "ansible-playbook --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:2.9.21 /bin/sh -c "ansible localhost -m ping"
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
          file: ansible29.Dockerfile
          context: .
          push: true
          tags: fabianoflorentino/ansible:2.9.21
```

#### **Ansible 5.5.0**

[.github/workflows/build-image-v550.yml](.github/workflows/build-image-v550.yml)

```yaml
---
name: BUILD IMAGE ANSIBLE 5.5.0

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
          file: ansible55.Dockerfile
          context: .
          tags: fabianoflorentino/ansible:5.5.0
          outputs: type=docker,dest=/tmp/ansible55.tar
      -
        name: Upload artifact
        uses: actions/upload-artifact@v2
        with:
          name: ansible55
          path: /tmp/ansible55.tar
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
          name: ansible55
          path: /tmp
      -
        name: Load image
        run: |
          docker load --input /tmp/ansible55.tar
          docker image ls -a
      - 
        name: Test
        run: |
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:5.5.0 /bin/sh -c "ansible --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:5.5.0 /bin/sh -c "ansible-vault --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:5.5.0 /bin/sh -c "ansible-playbook --version"
          docker run -i --rm --entrypoint "" $GITHUB_REPOSITORY:5.5.0 /bin/sh -c "ansible localhost -m ping"
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
          file: ansible55.Dockerfile
          context: .
          push: true
          tags: fabianoflorentino/ansible:5.5.0
```
