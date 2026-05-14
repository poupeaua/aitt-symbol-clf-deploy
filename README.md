# aitt-symbol-clf-deploy

Deployment for the aitt-symbol-clf ressource.

Basically, another repository manage the deployment of the ML model inference container.

This repository is used to deploy the container on the EC2 instance and ensure
it is up and running via Ansible (and systemd behind the scene on the remote server).

# Setup the EC2 instance

First of all, we need to setup the EC2 instance. Run, after `source .env`:

```bash
make setup
```

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

See the `.env.example` file for an example.

# How-To

1. You first have to ensure you have a private ssh key locally and the public key
on the EC2 instance. You can create the key pair using the AWS console on the 
interface in the Network and Security section EC2 section. Make sure you can
already connect to the EC2 instance using:
`ssh -i ~/.ssh/keys/name-of-your-private-key.pem ec2-user@public_ip_address`

Ideally you have configured your `~/.ssh/config` file with the following content:

```
Host aitt-instance-1
  HostName ec2-user@public_ip_address
  IdentityFile ~/.ssh/keys/name-of-you-private-key.pem
  User ec2-user
```

So you can more easily connect to the EC2 instance using the command 
`ssh aitt-instance-1`

Set correctly your `ANSIBLE_PRIVATE_KEY_FILE` environment variable.

The EC2 will be automatically found via Ansible thanks to tags defined in the
instance after creation by the Terraform repository:
https://github.com/poupeaua/aitt-infra

2. Run `make setup`

3. Run `make deploy`

# Tests after Deployment

Once you ran `make deploy`, you can test if everything is ok by:

1. Connecting via SSH to your EC2 instance.
2. Run `systemctl status aitt-symbol-clf` you should see `active (running)`.
3. Run `curl http://0.0.0.0:8000/health`. Ensure you have a 200 HTTP response.
