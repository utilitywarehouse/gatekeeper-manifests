# gatekeeper-manifests

[![CircleCI](https://circleci.com/gh/utilitywarehouse/gatekeeper-manifests/tree/master.svg?style=svg)](https://circleci.com/gh/utilitywarehouse/gatekeeper-manifests/tree/master)

This repository provides a Kustomize base to deploy Open Policy Agent gatekeeper and a set of generic constraint templates.

## Usage

Reference the remote base in your `kustomization.yaml`

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/utilitywarehouse/gatekeeper-manifests/base?ref=v1.0.0
```

Define the constraints and gatekeeper configuration suitable for your environment. Refer to the `example/`.

## Requires

- https://github.com/kubernetes-sigs/kustomize

```
go get -u sigs.k8s.io/kustomize
```

## Testing

Run the circleci jobs locally

```
$ circleci local execute --job rego
$ circleci local execute --job kustomize
```
