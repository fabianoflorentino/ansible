# A container image for run ansible tool

## **Usage**

| **Variable** | **Description** |
| --- | --- |
| $PWD | Current work directory with ansible code |

### **Local Usage**

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
    environment: DOCKERHUB
    name: Build and Push to Docker Hub
    runs-on: ubuntu-latest

    steps:
      # Checkout the repository
      - name: Checkout
        uses: actions/checkout@v2

      # Login to Docker Hub
      - name: Login
        run: docker login -u ${{ secrets.DOCKERHUB_USERNAME }} -p ${{ secrets.DOCKERHUB_TOKEN }}

      # Build the image (Ansible 2.9.21)
      - name: Build Image (Ansible 2.9.21)
        run: |
          docker build --no-cache --rm -t $GITHUB_REPOSITORY:2.9.21 -f ./ansible29.Dockerfile .

      # Push the image to Docker Hub (Ansible 2.9.21)
      - name: Push Version
        run: docker push $GITHUB_REPOSITORY:2.9.21
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
    environment: DOCKERHUB
    name: Build and Push to Docker Hub
    runs-on: ubuntu-latest

    steps:
      # Checkout the repository
      - name: Checkout
        uses: actions/checkout@v2

      # Login to Docker Hub
      - name: Login
        run: docker login -u ${{ secrets.DOCKERHUB_USERNAME }} -p ${{ secrets.DOCKERHUB_TOKEN }}

      # Build the image (Ansible 5.5.0)
      - name: Build Image (Ansible 5.5.0)
        run: |
          docker build --no-cache --rm -t $GITHUB_REPOSITORY:5.5.0 -f ./ansible55.Dockerfile .
      
      # Push the image to Docker Hub (Ansible 5.5.0)
      - name: Push Version
        run: docker push $GITHUB_REPOSITORY:5.5.0
```
