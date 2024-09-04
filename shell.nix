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
    krew
    kubectl
    kubevirt
    kubernetes-helm
    pre-commit
    sops
    age
  ];
}
