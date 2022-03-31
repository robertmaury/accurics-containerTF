FROM alpine:3.15.0

ARG SCAN_VER="1.13.2"
ARG SCAN_URL="https://github.com/accurics/terrascan/releases/download"
ARG TER_VER="1.1.7"
ARG TER_URL="https://releases.hashicorp.com/terraform"
ARG ACC_VER="1.0.34"
ARG ACC_URL="https://downloads.accurics.com/cli"

RUN   apk add --update git ca-certificates curl jq

RUN   curl -s -L -o terrascan.tar.gz \
      ${SCAN_URL}/v${SCAN_VER}/terrascan_${SCAN_VER}_Linux_x86_64.tar.gz && \
      tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz && \
      install terrascan /usr/local/bin && rm terrascan

RUN   curl -s -S -L -o terraform.zip \
      ${TER_URL}/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip && \
      unzip -d /usr/local/bin terraform.zip

RUN   curl -s ${ACC_URL}/${ACC_VER}/accurics_linux -o /usr/bin/accurics && \
      chmod 755 /usr/bin/accurics
