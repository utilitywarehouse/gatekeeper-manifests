# gatekeeper-manifests

[![CircleCI](https://circleci.com/gh/utilitywarehouse/gatekeeper-manifests/tree/master.svg?style=svg)](https://circleci.com/gh/utilitywarehouse/gatekeeper-manifests/tree/master)

This repository provides Kustomize bases to deploy Open Policy Agent gatekeeper and a set of generic constraint templates.

## Usage

The resources are divided into three bases:

- `bases/cluster` - cluster scoped resources
- `bases/namespaced` - namespaced resources
- `bases/templates` - the library of `ConstraintTemplates`

Reference them in your `kustomization.yaml`, like so:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/utilitywarehouse/gatekeeper-manifests/bases/cluster?ref=3.0.4-beta.1-2
  - github.com/utilitywarehouse/gatekeeper-manifests/bases/namespaced?ref=3.0.4-beta.1-2
  - github.com/utilitywarehouse/gatekeeper-manifests/bases/templates?ref=3.0.4-beta.1-2
```

Define the constraints and gatekeeper configuration suitable for your environment.

Refer to the `example/`.

Note that you need to [provide the `ClusterRoleBinding` for gatekeeper's service
account](example/gatekeeper-cluster-role-binding.yaml). This is required in order to keep the base namespace-agnostic.

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
