# Bootstrap

## Talos

### Bootstrap talos cluster

```sh
omnictl cluster template sync -f ./template.yaml --omniconfig ./omniconfig.yaml
```
## CNI

### Install Cilium

```sh
cilium install \
    --helm-set=ipam.mode=kubernetes \
    --helm-set=kubeProxyReplacement=true \
    --helm-set=securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --helm-set=securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --helm-set=cgroup.autoMount.enabled=false \
    --helm-set=cgroup.hostRoot=/sys/fs/cgroup \
    --helm-set=k8sServiceHost=127.0.0.1 \
    --helm-set=k8sServicePort=7445 \
    --helm-set=bgpControlPlane.enabled=true \
    --helm-set=bgp.enabled=false \
    --helm-set=bgp.announce.loadbalancerIP=true \
    --helm-set=bgp.announce.podCIDR=false \
    --helm-set=cni-exclusive=false
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
