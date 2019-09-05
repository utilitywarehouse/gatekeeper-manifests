FROM alpine:3 as kustomize

COPY ./cluster cluster
COPY ./namespaced namespaced
COPY ./example example

RUN wget -O kustomize \
    https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64
RUN chmod 755 kustomize

RUN ./kustomize build cluster
RUN ./kustomize build namespaced
RUN ./kustomize build example