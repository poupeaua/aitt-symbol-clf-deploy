include .env
include .scripts/ensure_env_vars.mk

setup: check-env-vars
	ansible-playbook playbooks/setup.yaml \
		-e "ansible_ssh_private_key_file=${ANSIBLE_PRIVATE_KEY_FILE}" \
		-e "AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID}" \
		-e "AWS_REGION=${AWS_REGION}" \
		-e "IMAGE_NAME=${IMAGE_NAME}" \
		-e "IMAGE_TAG=${IMAGE_TAG}" \
		-e "PORT_INPUT=${PORT_INPUT}" \
		-e "DOCKER_NETWORK=${DOCKER_NETWORK}"

deploy: check-env-vars
	ansible-playbook playbooks/deploy.yaml \
		-e "ansible_ssh_private_key_file=${ANSIBLE_PRIVATE_KEY_FILE}" \
		-e "AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID}" \
		-e "AWS_REGION=${AWS_REGION}" \
		-e "IMAGE_NAME=${IMAGE_NAME}" \
		-e "IMAGE_TAG=${IMAGE_TAG}" \
		-e "PORT_INPUT=${PORT_INPUT}" \
		-e "DOCKER_NETWORK=${DOCKER_NETWORK}"
