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
  - github.com/utilitywarehouse/gatekeeper-manifests/cluster?ref=3.1.0-beta.2-2
  - github.com/utilitywarehouse/gatekeeper-manifests/namespaced?ref=3.1.0-beta.2-2
```

Define the gatekeeper configuration suitable for your environment.

Refer to the `example/`.

Note that you need to [provide the `ClusterRoleBinding` for gatekeeper's service
account](example/rbac.yaml). This is required in order to keep the base namespace-agnostic.

The `namespaced` base sets the `--disable-cert-rotation` flag, which means you must manage the webhook certificate, in a secret called `gatekeeper-webhook-server-cert`, separately. Additionally, the CA certificate must be injected into the `ValidatingWebhookConfiguration`. The example uses cert-manager and cert-manager's cainjector to achieve both things.

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
