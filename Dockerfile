FROM golang:1.12 as rego

WORKDIR /go/src/extract-rego

COPY lib/extract-rego/ .
COPY ./bases/templates templates

RUN go get -d ./...
RUN go run extract-rego.go templates/*.yaml

RUN curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.13.3/opa_linux_amd64
RUN chmod 755 opa
RUN ./opa test -v *.rego


FROM golang:1.12 as kustomize

COPY ./bases bases
COPY ./example example

RUN curl -L -o kustomize \
    https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64
RUN chmod 755 kustomize

RUN ./kustomize build bases/cluster
RUN ./kustomize build bases/namespaced
RUN ./kustomize build bases/templates
RUN ./kustomize build example