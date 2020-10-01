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
  - github.com/utilitywarehouse/gatekeeper-manifests/cluster?ref=3.1.1-1
  - github.com/utilitywarehouse/gatekeeper-manifests/namespaced?ref=3.1.1-1
```

Define the gatekeeper configuration suitable for your environment.

Refer to the `example/`.

Note that you need to [provide the `ClusterRoleBinding` for gatekeeper's service
account](example/rbac.yaml). This is required in order to keep the base namespace-agnostic.

## Update

```
helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm repo update
helm fetch gatekeeper/gatekeeper
helm template --name gatekeeper gatekeeper-3.1.1.tgz
```

Then:

- Split cluster and namespace scoped resources into `cluster/gatekeeper.yaml` and
  `namespaced/gatekeeper.yaml`, respectively.
- Remove `Namespace`, `ClusterRoleBinding` and `RoleBinding` resources
- Remove the `metadata.namespace` field from all the namespaced resources
- Update any patches in `{cluster,namespaced}/gatekeeper-patch.yaml` to account
  for upstream changes

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
