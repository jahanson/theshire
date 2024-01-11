#!/bin/bash
cilium install \
--helm-set=ipam.mode=kubernetes \
--helm-set=kubeProxyReplacement=true \
--helm-set=k8sServiceHost=167.235.217.82 \
--helm-set=policyAuditMode=true \
--helm-set=hostFirewall.enabled=true \
--helm-set=extraConfig.allow-localhost=policy \
--helm-set=hubble.relay.enabled=true \
--helm-set=hubble.ui.enabled=true
