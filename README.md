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

The rego policies and kustomize build can be tested with `make`.

Or the tests can be ran separately:

```
$ make rego
$ make kustomize
```

You can also install a `pre-push` git hook that will run the tests on push:

```
$ make install-git-hooks
```
