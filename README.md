# aitt-symbol-clf-deploy

Deployment for the aitt-symbol-clf ressource.

Basically, another repository manage the deployment of the ML model inference container.

This repository is used to deploy the container on the EC2 instance and ensure
it is up and running via Ansible (and systemd behind the scene on the remote server).

# Setup the EC2 instance

This repository is also responsible to provide the *basic* setup for the EC2
instance. This basic setup includes:

1. **General**: making updates
2. **Docker**: installing Docker and configuring Docker properly for further use
3. **CloudWatch**: configuring CloudWatch Agent to send wanted metrics

This _theoretically_ should be done before any other specific deployments.
Those specific deployments are: 
- **AITT Angle Symbol ML Deployment**: This repository main goal
- **AITT Core**: the deployment of the AITT Core

Thus this should be in another dedicated repostory since this is another responsability: 
setting up the base of the instance so that the rest of the deployment works like a 
charm.

However for the sake of simplicity we do it here for the moment.

If the setup becomes to complex, we will move it to another repository.

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
IMAGE_NAME=aitt/angle-symbol-clf
IMAGE_TAG=0.1.0
SERVICE_NAME=aitt-symbol-clf
PORT_INPUT=8000
DOCKER_NETWORK=aitt-network
```



