# Shell for bootstrapping flake-enabled nix and home-manager
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # Enable experimental features without having to specify the argument
  NIX_CONFIG = "experimental-features = nix-command flakes";

  nativeBuildInputs = with pkgs; [
    git
    go-task
    sops
    pre-commit
    gitleaks
    k9s
    kubectl
    kubevirt
  ];
}
