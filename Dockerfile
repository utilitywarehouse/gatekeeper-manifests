FROM alpine:3 as kustomize

COPY ./cluster cluster
COPY ./namespaced namespaced
COPY ./example example

ENV KUSTOMIZE_VERSION="v3.5.4"

RUN \
    wget -O - https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz |\
    tar xz -C /usr/local/bin/

RUN kustomize build cluster
RUN kustomize build namespaced
RUN kustomize build example