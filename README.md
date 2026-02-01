# aitt-symbol-clf-deploy

Deployment for the aitt-symbol-clf ressource.

Basically, another repository manage the deployment of the ML model inference container.

This repository is used to deploy the container on the EC2 instance and ensure
it is up and running via Ansible (and systemd behind the scene on the remote server).

# Pre-requisites

## Ansible

You need `uv` installed. Then run:

```sh
uv sync
```

## Environment variables

In order to make this work you need some special environment variables.
You can put them in a .env file and load it with the `source .env` command.

```sh
ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/keys/name-of-your-private-key.pem
AWS_ACCOUNT_ID=************
AWS_REGION=***
IMAGE_NAME=***
IMAGE_TAG=0.1.0
PORT_INPUT=8000
```



