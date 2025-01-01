# Bootstrap

## Prerequisites
```sh
mise use helm helmfile
helm plugin install https://github.com/databus23/helm-diff
```

## Talos

### Bootstrap talos cluster

```sh
talosctl apply-config --nodes=frodo --file=./kubernetes/bootstrap/talos/clusterconfig/theshire-frodo.yaml --insecure
talosctl apply-config --nodes=bilbo --file=./kubernetes/bootstrap/talos/clusterconfig/theshire-bilbo.yaml --insecure
talosctl apply-config --nodes=sam --file=./kubernetes/bootstrap/talos/clusterconfig/theshire-sam.yaml --insecure
talosctl apply-config --nodes=merry --file=./kubernetes/bootstrap/talos/clusterconfig/theshire-merry.yaml --insecure
talosctl apply-config --nodes=pippin --file=./kubernetes/bootstrap/talos/clusterconfig/theshire-pippin.yaml --insecure
talosctl apply-config --nodes=rosie --file=./kubernetes/bootstrap/talos/clusterconfig/theshire-rosie.yaml --insecure
talosctl bootstrap --nodes=frodo
```
## CNI & Container Proxy

### Install Cilium, csr-approver, coredns, and Prometheus CRDs.
```sh
helmfile apply -f kubernetes/bootstrap/helmfile.yaml
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
