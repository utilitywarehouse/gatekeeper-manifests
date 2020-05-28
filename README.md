# gatekeeper-manifests

[![CircleCI](https://circleci.com/gh/utilitywarehouse/gatekeeper-manifests/tree/master.svg?style=svg)](https://circleci.com/gh/utilitywarehouse/gatekeeper-manifests/tree/master)

This repository provides Kustomize bases to deploy Open Policy Agent gatekeeper.

## Usage

The resources are divided into two bases:

- `cluster` - cluster scoped resources
- `namespaced` - namespaced resources

Reference them in your `kustomization.yaml`, like so:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - github.com/utilitywarehouse/gatekeeper-manifests/cluster?ref=3.1.0-beta.9-1
  - github.com/utilitywarehouse/gatekeeper-manifests/namespaced?ref=3.1.0-beta.9-1
```

Define the gatekeeper configuration suitable for your environment.

Refer to the `example/`.

Note that you need to [provide the `ClusterRoleBinding` for gatekeeper's service
account](example/rbac.yaml). This is required in order to keep the base namespace-agnostic.

## Requires

- https://github.com/kubernetes-sigs/kustomize

```
go get -u sigs.k8s.io/kustomize
```

## Testing

The kustomize build can be tested with `make`.

You can also install a `pre-push` git hook that will run the tests on push:

```
$ make install-git-hooks
```

## Templates

Our library of `ConstraintTemplates` can also be pulled in as a base. See [gatekeeper-template-manifests](https://github.com/utilitywarehouse/gatekeeper-template-manifests).
