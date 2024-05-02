# Bootstrap

## Prerequisites
```sh
brew install helmfile
helm plugin install https://github.com/databus23/helm-diff
```

## Talos

### Bootstrap talos cluster

```sh
omnictl cluster template sync -f ./omni-homelab-export.yaml --omniconfig ./omniconfig.yaml
```
## CNI & Container Proxy

### Install Cilium & Spegel
```sh
helmfile apply -f kubernetes/bootstrap/talos/apps/helmfile.yaml
```

## Flux Prep

### Install Flux

```sh
kubectl apply --server-side --kustomize ./kubernetes/bootstrap/flux
```

### Apply secrets, settings, and crds.

_These cannot be applied with `kubectl` in the regular fashion due to be encrypted with sops_

```sh
sops --decrypt kubernetes/bootstrap/flux/age-key.sops.yaml | kubectl apply -f -
sops --decrypt kubernetes/bootstrap/flux/git-deploy-key.sops.yaml | kubectl apply -f -
sops --decrypt kubernetes/flux/vars/cluster-secrets.sops.yaml | kubectl apply -f -
kubectl apply -f kubernetes/flux/vars/cluster-settings.yaml
```

## Wipe Rook Ceph

```sh
kubectl apply -f kubernetes/tools/wiperook.yaml
```

## Kick off Flux applying this repository

```sh
kubectl apply --server-side --kustomize ./kubernetes/flux/config
```
