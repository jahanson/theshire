# Shell for bootstrapping flake-enabled nix and home-manager
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # Enable experimental features without having to specify the argument
  NIX_CONFIG = "experimental-features = nix-command flakes";

  nativeBuildInputs = with pkgs; [
    fluxcd
    git
    gitleaks
    go-task
    helmfile
    k9s
    kubectl
    kubevirt
    kubernetes-helm
    pre-commit
    sops
  ];
  # Possible inputs needed. Keeping here for posterity
  # age
  # ansible
  # cilium-cli
  # direnv
  # derailed/k9s/k9s
  # fluxcd/tap/flux
  # go-task/tap/go-task
  # helm
  # ipcalc
  # jq
  # kubernetes-cli
  # kustomize
  # pre-commit
  # prettier
  # shellcheck
  # sops
  # stern
  # talhelper
  # yamllint
  # yq
}
