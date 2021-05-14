# Container image that runs your code
FROM alpine:3.12

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY main.tf main.tf

RUN apk update && \
  apk add --upgrade --no-cache ca-certificates curl jq && \
  curl -s https://downloads.accurics.com/cli/1.0.17/accurics_linux -o /usr/bin/accurics && \
  chmod 755 /entrypoint.sh /usr/bin/accurics && \
  curl -s -S -L -o /tmp/terraform_0.15.3_linux_amd64.zip https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip && \
  unzip -d /usr/local/bin /tmp/terraform_0.15.3_linux_amd64.zip && \
  mkdir -p ~/.terraform.d/plugin-cache && \
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache" && \
  terraform init && \
  rm -rf main.tf
