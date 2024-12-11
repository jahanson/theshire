# Shell for bootstrapping flake-enabled nix and home-manager
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # Enable experimental features without having to specify the argument
  NIX_CONFIG = "experimental-features = nix-command flakes";
  shellHook = ''
    export TMP=$(mktemp -d "/tmp/nix-shell-XXXXXX")
    export TEMP=$TMP
    export TMPDIR=$TMP
  '';

  nativeBuildInputs = with pkgs; [
    fluxcd
    git
    gitleaks
    helmfile
    k9s
    kubevirt
    kubernetes-helm
    pre-commit
    sops
    age
    mqttui
    kustomize
    yq-go
    go-task
    kubectl
  ];
}
